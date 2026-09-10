import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../services/app_events.dart';
import '../services/pro_service.dart';
import '../services/pro_entry_point.dart';
import '../services/usage_analytics.dart';
import '../services/telemetry.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';
import '../app_preferences.dart';
import 'app_snack_bar.dart';
import 'platform.dart';

enum _ProductLoadError { purchasesUnavailable, productUnavailable, failed }

/// Bottom sheet that sells the one-time "Patterns Pro" unlock.
/// On desktop, it automatically shows the high-fidelity [DesktopPaywallView].
class PaywallSheet extends StatefulWidget {
  final ProEntryPoint entryPoint;

  const PaywallSheet({super.key, this.entryPoint = ProEntryPoint.settings});

  static Future<void> show(
    BuildContext context, {
    ProEntryPoint entryPoint = ProEntryPoint.settings,
  }) {
    Telemetry.log('paywall.shown', {'source': entryPoint.wireName});
    AppEvents.logProFeatureTapped(entryPoint);
    AppEvents.logSupporterScreenViewed(source: entryPoint);
    if (kIsDesktop) {
      return showDialog<void>(
        context: context,
        useRootNavigator: true,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 24,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: DesktopPaywallView(onUnlocked: () => Navigator.pop(context)),
          ),
        ),
      );
    }
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => PaywallSheet(entryPoint: entryPoint),
    );
  }

  @override
  State<PaywallSheet> createState() => _PaywallSheetState();
}

class _PaywallSheetState extends State<PaywallSheet> {
  ProductDetails? _product;
  _ProductLoadError? _loadError;
  bool _loading = true;
  bool _purchaseInFlight = false;
  bool _restoreInFlight = false;
  StreamSubscription<ProEvent>? _eventSub;
  Timer? _restoreTimeout;

  @override
  void initState() {
    super.initState();
    _eventSub = ProService.events.listen(_onEvent);
    _loadProduct();
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    _restoreTimeout?.cancel();
    super.dispose();
  }

  Future<void> _loadProduct() async {
    if (!ProService.isPlatformSupported) {
      setState(() {
        _loading = false;
        _loadError = _ProductLoadError.purchasesUnavailable;
      });
      return;
    }
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final available = await ProService.isAvailable();
      if (!available) {
        AppEvents.logProductLoadResult(
          result: UsageAnalyticsContext.unavailable,
        );
        _applyProduct(null, error: _ProductLoadError.purchasesUnavailable);
        return;
      }
      final product = await _fetchProductWithRetry();
      AppEvents.logProductLoadResult(
        result: product == null
            ? UsageAnalyticsContext.unavailable
            : UsageAnalyticsContext.success,
      );
      _applyProduct(product, error: _ProductLoadError.productUnavailable);
    } catch (_) {
      AppEvents.logProductLoadResult(result: UsageAnalyticsContext.error);
      _applyProduct(null, error: _ProductLoadError.failed);
    }
  }

  Future<ProductDetails?> _fetchProductWithRetry() async {
    const maxAttempts = 3;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final product = await ProService.loadProduct(forceReload: true);
        if (product != null || attempt == maxAttempts) return product;
      } catch (_) {
        if (attempt == maxAttempts) rethrow;
      }
      await Future.delayed(Duration(milliseconds: 400 * attempt));
    }
    return null;
  }

  void _applyProduct(
    ProductDetails? product, {
    required _ProductLoadError error,
  }) {
    if (mounted) {
      setState(() {
        _product = product;
        _loading = false;
        if (product == null) {
          _loadError = error;
        }
      });
    }
  }

  void _onEvent(ProEvent event) {
    // Events arrive from an app-lifetime stream, so this sheet may already be
    // gone by the time one lands.
    if (!mounted) return;

    if (event is ProSuccess) {
      Telemetry.log(event.restored ? 'paywall.restore' : 'paywall.purchase');
      AppEvents.logSupporterPurchaseCompleted(
        restored: event.restored,
        source: widget.entryPoint,
      );
      _restoreTimeout?.cancel();
      setState(() {
        _purchaseInFlight = false;
        _restoreInFlight = false;
      });
      final navigator = Navigator.of(context);
      navigator.pop();
      _showUnlockedDialog(navigator.context, restored: event.restored);
    } else if (event is ProError) {
      final message = _restoreInFlight
          ? context.l10n.proPaywallRestoreFailed
          : context.l10n.proPaywallPurchaseFailed;
      if (_restoreInFlight) {
        AppEvents.logRestoreFailed(widget.entryPoint);
      } else {
        AppEvents.logPurchaseFailed(widget.entryPoint);
      }
      _restoreTimeout?.cancel();
      setState(() {
        _purchaseInFlight = false;
        _restoreInFlight = false;
      });
      showAppSnackBar(context, message, type: ToastType.error);
    } else if (event is ProCanceled) {
      AppEvents.logPurchaseCanceled(widget.entryPoint);
      // Without this the in-flight flag stayed true after the user dismissed
      // the store sheet, leaving Unlock *and* Restore disabled. Someone who
      // already owns Pro could not then restore it.
      _restoreTimeout?.cancel();
      setState(() {
        _purchaseInFlight = false;
        _restoreInFlight = false;
      });
    }
  }

  void _onBuy() async {
    final product = _product;
    if (product == null) return;
    AppEvents.logSupporterPurchaseStarted(widget.entryPoint);
    setState(() {
      _purchaseInFlight = true;
      _restoreInFlight = false;
    });
    try {
      final success = await ProService.buyPro(product);
      if (!success) {
        AppEvents.logPurchaseFailed(widget.entryPoint);
        if (!mounted) return;
        setState(() => _purchaseInFlight = false);
        showAppSnackBar(
          context,
          context.l10n.proPaywallPurchaseStartFailed,
          type: ToastType.error,
        );
      }
    } catch (_) {
      AppEvents.logPurchaseFailed(widget.entryPoint);
      if (!mounted) return;
      setState(() => _purchaseInFlight = false);
      showAppSnackBar(
        context,
        context.l10n.proPaywallPurchaseFailed,
        type: ToastType.error,
      );
    }
  }

  void _onRestore() async {
    AppEvents.logRestoreStarted(widget.entryPoint);
    setState(() {
      _purchaseInFlight = true;
      _restoreInFlight = true;
    });
    // A restore that finds nothing emits no event at all, which used to leave
    // the sheet spinning forever. Give it a deadline and say so plainly.
    _restoreTimeout?.cancel();
    _restoreTimeout = Timer(const Duration(seconds: 12), () {
      if (!mounted || !_purchaseInFlight) return;
      AppEvents.logRestoreNotFound(widget.entryPoint);
      setState(() {
        _purchaseInFlight = false;
        _restoreInFlight = false;
      });
      showAppSnackBar(
        context,
        context.l10n.proPaywallRestoreNotFound,
        type: ToastType.info,
      );
    });
    try {
      await ProService.restore();
    } catch (_) {
      AppEvents.logRestoreFailed(widget.entryPoint);
      _restoreTimeout?.cancel();
      if (!mounted) return;
      setState(() {
        _purchaseInFlight = false;
        _restoreInFlight = false;
      });
      showAppSnackBar(
        context,
        context.l10n.proPaywallRestoreFailed,
        type: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary.withValues(alpha: 0.14),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      LineIcons.unlock,
                      color: theme.colorScheme.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      strings.proPaywallTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.entryPoint.headline(strings),
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 12),
              // Someone who already bought Pro and reinstalled arrives here
              // looking at a price they have already paid. Say so before the
              // price, not in a quiet button underneath it.
              _AlreadyPurchasedRow(
                onRestore: _purchaseInFlight ? null : _onRestore,
              ),
              const SizedBox(height: 18),
              for (final point in widget.entryPoint.benefits(strings)) ...[
                _ProPoint(text: point),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 6),
              Text(
                strings.proPaywallIncludedTools,
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              _buildBody(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    final strings = context.l10n;
    if (_loading) {
      return Semantics(
        label: strings.proPaywallLoadingLabel,
        liveRegion: true,
        child: const ExcludeSemantics(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
    final error = _loadError;
    if (error != null) {
      final errorMessage = switch (error) {
        _ProductLoadError.purchasesUnavailable =>
          strings.proPaywallPurchasesUnavailable,
        _ProductLoadError.productUnavailable =>
          strings.proPaywallProductUnavailable,
        _ProductLoadError.failed => strings.proPaywallProductLoadFailed,
      };
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            errorMessage,
            style: TextStyle(
              color: context.appColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: _loadProduct,
            child: Text(strings.proPaywallTryAgainAction),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _purchaseInFlight ? null : _onRestore,
            child: Text(strings.proPaywallRestorePurchasesAction),
          ),
        ],
      );
    }
    final product = _product;
    final buttonText = product != null
        ? strings.proPaywallUnlockWithPrice(product.price)
        : strings.proPaywallUnlockAction;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _purchaseInFlight ? null : _onBuy,
            child: _purchaseInFlight
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(buttonText),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _purchaseInFlight ? null : _onRestore,
          child: Text(strings.proPaywallRestorePurchasesAction),
        ),
      ],
    );
  }
}

/// Reassurance for a returning purchaser: Pro is a one-time buy, so anyone
/// seeing this sheet a second time already owns it and should restore rather
/// than pay again. Deliberately above the price.
class _AlreadyPurchasedRow extends StatelessWidget {
  final VoidCallback? onRestore;

  const _AlreadyPurchasedRow({required this.onRestore});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = Text(
      context.l10n.proPaywallAlreadyPurchased,
      style: TextStyle(
        color: context.appColors.textSecondary,
        height: 1.4,
        fontSize: 13,
      ),
    );
    final restoreButton = TextButton(
      onPressed: onRestore,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size(44, 44),
      ),
      child: Text(context.l10n.proPaywallRestoreShortAction),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final usesAccessibilityText =
              MediaQuery.textScalerOf(context).scale(1) > 1.3;
          if (usesAccessibilityText || constraints.maxWidth < 300) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                message,
                const SizedBox(height: 4),
                Align(alignment: Alignment.centerRight, child: restoreButton),
              ],
            );
          }
          return Row(
            children: [
              Expanded(child: message),
              const SizedBox(width: 8),
              restoreButton,
            ],
          );
        },
      ),
    );
  }
}

class _ProPoint extends StatelessWidget {
  final String text;
  const _ProPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(LineIcons.check, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
        ),
      ],
    );
  }
}

/// A high-fidelity, premium paywall view for Desktop (reused dialog / inline).
class DesktopPaywallView extends StatefulWidget {
  final VoidCallback? onUnlocked;
  const DesktopPaywallView({super.key, this.onUnlocked});

  @override
  State<DesktopPaywallView> createState() => _DesktopPaywallViewState();
}

class _DesktopPaywallViewState extends State<DesktopPaywallView> {
  final _licenseController = TextEditingController();
  bool _isEnteringLicense = false;

  @override
  void dispose() {
    _licenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // List of premium features optimized for desktop
    final features = [
      (
        icon: Icons.linear_scale_rounded,
        title: 'Hierarchy Builder',
        desc: 'Construct and track exposure steps and ladders.',
      ),
      (
        icon: Icons.assignment_turned_in_rounded,
        title: 'ERP Exercise Logs',
        desc: 'Log response prevention and timed exercises.',
      ),
      (
        icon: Icons.hourglass_empty_rounded,
        title: 'Urge Surfing Waves',
        desc: 'Ride urge spikes with live timed logging.',
      ),
      (
        icon: Icons.analytics_rounded,
        title: 'Advanced Insights',
        desc: 'View interactive trend charts and weekly metrics.',
      ),
    ];

    Widget buildFeatureCard(IconData icon, String title, String desc) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: theme.colorScheme.primary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withOpacity(0.12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.verified_user_rounded,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unlock Patterns Desktop Pro',
                      style: TextStyle(
                        fontFamily: AppTheme.displayFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'A cheaper, one-time payment for offline desktop-optimized recovery tools.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: theme.colorScheme.onSurface.withOpacity(0.55),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Features Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 560;
              if (isNarrow) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildFeatureCard(
                      features[0].icon,
                      features[0].title,
                      features[0].desc,
                    ),
                    const SizedBox(height: 10),
                    buildFeatureCard(
                      features[1].icon,
                      features[1].title,
                      features[1].desc,
                    ),
                    const SizedBox(height: 10),
                    buildFeatureCard(
                      features[2].icon,
                      features[2].title,
                      features[2].desc,
                    ),
                    const SizedBox(height: 10),
                    buildFeatureCard(
                      features[3].icon,
                      features[3].title,
                      features[3].desc,
                    ),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildFeatureCard(
                          features[0].icon,
                          features[0].title,
                          features[0].desc,
                        ),
                        const SizedBox(height: 12),
                        buildFeatureCard(
                          features[2].icon,
                          features[2].title,
                          features[2].desc,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildFeatureCard(
                          features[1].icon,
                          features[1].title,
                          features[1].desc,
                        ),
                        const SizedBox(height: 12),
                        buildFeatureCard(
                          features[3].icon,
                          features[3].title,
                          features[3].desc,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),

          // Pricing & Checkout Box
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.15),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!_isEnteringLicense) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'One-Time License',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$9.99 (one-time purchase)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => launchUrl(
                                Uri.parse(
                                  'https://maskedsyntax.lemonsqueezy.com/buy/patterns-desktop-pro',
                                ),
                                mode: LaunchMode.externalApplication,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: const Text('Purchase License Key'),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24, color: Colors.white10),
                      GestureDetector(
                        onTap: () => setState(() => _isEnteringLicense = true),
                        child: Center(
                          child: Text(
                            'Already purchased? Enter your License Key',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      Text(
                        'Enter your Lemon Squeezy license key:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _licenseController,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          labelText: 'License Key',
                          hintText: 'e.g. DESKTOP-XXXX-XXXX-XXXX',
                          hintStyle: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.3),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'For testing, enter any 8+ character key (e.g. DESKTOP-TEST-KEY).',
                        style: TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: theme.colorScheme.onSurface.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Consumer(
                              builder: (context, ref, _) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    final key = _licenseController.text.trim();
                                    if (key.length >= 8) {
                                      await appPreferences?.setBool(
                                        proUnlockedKey,
                                        true,
                                      );
                                      ref.read(proProvider.notifier).refresh();
                                      if (widget.onUnlocked != null) {
                                        widget.onUnlocked!();
                                      } else {
                                        _showUnlockedDialog(
                                          context,
                                          restored: false,
                                        );
                                      }
                                    } else {
                                      showAppSnackBar(
                                        context,
                                        'Please enter a valid license key (at least 8 characters).',
                                        type: ToastType.error,
                                      );
                                    }
                                  },
                                  child: const Text('Activate License'),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => setState(() {
                                _isEnteringLicense = false;
                                _licenseController.clear();
                              }),
                              child: const Text('Back'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showUnlockedDialog(BuildContext context, {required bool restored}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      final theme = Theme.of(dialogContext);
      final strings = dialogContext.l10n;
      final surface = dialogContext.appColors.card;
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withValues(alpha: 0.14),
                ),
                alignment: Alignment.center,
                child: Icon(
                  LineIcons.unlock,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                restored
                    ? strings.proPaywallWelcomeBack
                    : strings.proPaywallAllSet,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontFamily: AppTheme.displayFamily,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                restored
                    ? strings.proPaywallRestoredBody
                    : strings.proPaywallUnlockedBody,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: dialogContext.appColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(strings.proPaywallContinueAction),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
