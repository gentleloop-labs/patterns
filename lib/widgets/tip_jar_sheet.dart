import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:line_icons/line_icons.dart';

import '../l10n/l10n.dart';
import '../services/tip_jar.dart';
import '../theme/app_colors.dart';
import 'app_snack_bar.dart';
import 'platform.dart';
import 'tip_thanks_dialog.dart';

enum _TipLoadError { purchasesUnavailable, noOptions, failed }

class TipJarSheet extends StatefulWidget {
  const TipJarSheet({super.key});

  static Future<void> show(BuildContext context) {
    const child = TipJarSheet();
    if (kIsDesktop) {
      return showDialog<void>(
        context: context,
        useRootNavigator: true,
        builder: (_) => Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 24,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480, maxHeight: 640),
            child: child,
          ),
        ),
      );
    }
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => child,
    );
  }

  @override
  State<TipJarSheet> createState() => _TipJarSheetState();
}

class _TipJarSheetState extends State<TipJarSheet> {
  List<ProductDetails>? _products;
  _TipLoadError? _loadError;
  bool _loading = true;
  bool _purchaseInFlight = false;
  StreamSubscription<TipJarEvent>? _eventSub;

  @override
  void initState() {
    super.initState();
    _eventSub = TipJarService.events.listen(_onEvent);
    _loadProducts();
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final available = await TipJarService.isAvailable();
      if (!available) {
        _applyProducts(null, error: _TipLoadError.purchasesUnavailable);
        return;
      }
      final products = await _fetchProductsWithRetry();
      _applyProducts(products, error: _TipLoadError.noOptions);
    } catch (_) {
      _applyProducts(null, error: _TipLoadError.failed);
    }
  }

  /// Loads the products, retrying a few times with short backoff to ride out
  /// transient store failures. Returns an empty list only if every attempt
  /// came back empty; rethrows if the final attempt errored.
  Future<List<ProductDetails>> _fetchProductsWithRetry() async {
    const maxAttempts = 3;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final products = await TipJarService.loadProducts(forceReload: true);
        if (products.isNotEmpty || attempt == maxAttempts) return products;
      } catch (_) {
        if (attempt == maxAttempts) rethrow;
      }
      await Future.delayed(Duration(milliseconds: 400 * attempt));
    }
    return const [];
  }

  /// Applies a load result, falling back to the last cached products so a
  /// transient failure still shows usable options instead of an error.
  void _applyProducts(
    List<ProductDetails>? products, {
    required _TipLoadError error,
  }) {
    if (!mounted) return;
    final resolved = (products != null && products.isNotEmpty)
        ? products
        : TipJarService.cachedProducts;
    setState(() {
      _loading = false;
      if (resolved != null && resolved.isNotEmpty) {
        _products = resolved;
        _loadError = null;
      } else {
        _products = const [];
        _loadError = error;
      }
    });
  }

  void _onEvent(TipJarEvent event) {
    if (!mounted) return;
    switch (event) {
      case TipJarSuccess():
        setState(() => _purchaseInFlight = false);
        final navigator = Navigator.of(context);
        navigator.pop();
        TipThanksDialog.show(navigator.context);
      case TipJarError():
        setState(() => _purchaseInFlight = false);
        showAppSnackBar(
          context,
          context.l10n.tipJarPurchaseFailed,
          type: ToastType.error,
        );
      case TipJarCanceled():
        setState(() => _purchaseInFlight = false);
    }
  }

  Future<void> _onTip(ProductDetails product) async {
    if (_purchaseInFlight) return;
    setState(() => _purchaseInFlight = true);
    try {
      final launched = await TipJarService.buyTip(product);
      if (!launched && mounted) {
        setState(() => _purchaseInFlight = false);
        showAppSnackBar(
          context,
          context.l10n.tipJarPurchaseFailed,
          type: ToastType.error,
        );
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _purchaseInFlight = false);
      showAppSnackBar(
        context,
        context.l10n.tipJarPurchaseFailed,
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
                      LineIcons.heart,
                      color: theme.colorScheme.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      strings.tipJarTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                strings.tipJarBody,
                style: TextStyle(
                  color: context.appColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),
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
        label: strings.tipJarLoadingLabel,
        liveRegion: true,
        child: const ExcludeSemantics(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
    final error = _loadError;
    if (error != null) {
      final errorMessage = switch (error) {
        _TipLoadError.purchasesUnavailable =>
          strings.tipJarPurchasesUnavailable,
        _TipLoadError.noOptions => strings.tipJarOptionsUnavailable,
        _TipLoadError.failed => strings.tipJarLoadFailed,
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
            onPressed: _loadProducts,
            child: Text(strings.tipJarTryAgainAction),
          ),
        ],
      );
    }
    final products = _products ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final product in products) ...[
          _TipChoice(
            product: product,
            disabled: _purchaseInFlight,
            onTap: () => _onTip(product),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _TipChoice extends StatelessWidget {
  final ProductDetails product;
  final bool disabled;
  final VoidCallback onTap;

  const _TipChoice({
    required this.product,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final copy = TipJarService.localizedCopy(strings, product.id);

    return Semantics(
      button: true,
      enabled: !disabled,
      label: strings.tipChoiceSemantics(
        copy.title,
        product.price,
        copy.description,
      ),
      hint: strings.tipChoiceHint,
      excludeSemantics: true,
      child: Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: disabled ? null : onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 44),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: theme.dividerColor),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final details = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      copy.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (copy.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        copy.description,
                        style: TextStyle(
                          color: context.appColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                );
                final price = Text(
                  product.price,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                  ),
                );
                final usesAccessibilityText =
                    MediaQuery.textScalerOf(context).scale(1) > 1.3;
                if (usesAccessibilityText || constraints.maxWidth < 300) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      details,
                      const SizedBox(height: 10),
                      Align(alignment: Alignment.centerRight, child: price),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: details),
                    const SizedBox(width: 12),
                    price,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
