import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:local_auth/local_auth.dart'
    show LocalAuthException, LocalAuthExceptionCode;
import 'package:url_launcher/url_launcher.dart';

import '../../database/db_helper.dart';
import '../../providers/providers.dart';
import '../../services/material_file_store.dart';
import '../../services/app_events.dart';
import '../../services/notification_service.dart';
import '../../services/pro_service.dart';
import '../../services/pro_entry_point.dart';
import '../../services/review_prompt.dart';
import '../../services/tip_jar.dart';
import '../../services/usage_analytics.dart';
import '../../l10n/l10n.dart';
import '../../l10n/app_language.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_colors.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/export_report_sheet.dart';
import '../../widgets/language_picker.dart';
import '../../widgets/paywall_sheet.dart';
import '../../widgets/platform.dart';
import '../../widgets/tip_jar_sheet.dart';
import '../biometric_auth.dart';
import '../main_shell.dart' show tourRequestProvider;
import '../preferences.dart';
import 'debug_funnel_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appLockEnabled = ref.watch(appLockEnabledProvider);
    final reminder = ref.watch(reminderProvider);
    final usageAnalyticsEnabled = ref.watch(usageAnalyticsEnabledProvider);
    final appearance = ref.watch(appearanceProvider);
    final language = ref.watch(languageProvider);
    final calmInsightsEnabled = ref.watch(calmInsightsProvider);
    final strings = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: staggered([
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LineIcons.angleLeft),
                ),
                Expanded(
                  child: Text(
                    strings.settingsTitle,
                    style: _screenTitle(theme),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              strings.appearanceTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            _AppearancePicker(
              value: appearance,
              onChanged: (value) =>
                  ref.read(appearanceProvider.notifier).setAppearance(value),
            ),
            const SizedBox(height: 12),
            _SettingsItem(
              icon: LineIcons.language,
              title: strings.languageTitle,
              subtitle: language == AppLanguage.system
                  ? strings.systemDefault
                  : language.nativeName,
              onTap: () => showAppLanguagePicker(context, ref),
            ),
            const SizedBox(height: 10),
            _SettingsSwitchItem(
              icon: LineIcons.leaf,
              title: strings.calmInsightsTitle,
              subtitle: strings.calmInsightsSubtitle,
              value: calmInsightsEnabled,
              onChanged: (value) =>
                  ref.read(calmInsightsProvider.notifier).setEnabled(value),
            ),
            const SizedBox(height: 28),
            Text(
              strings.settingsDataSection,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            _SettingsItem(
              icon: LineIcons.download,
              title: strings.settingsExportDataTitle,
              subtitle: strings.settingsExportDataSubtitle,
              onTap: () => _confirmExport(context),
            ),
            if (isPdfExportSupported) ...[
              const SizedBox(height: 10),
              _SettingsItem(
                icon: LineIcons.fileExport,
                title: strings.exportReportTitle,
                subtitle: strings.exportReportDescription,
                onTap: () => ExportReportSheet.show(context),
              ),
            ],
            const SizedBox(height: 10),
            _SettingsItem(
              icon: LineIcons.upload,
              title: strings.settingsImportDataTitle,
              subtitle: strings.settingsImportDataSubtitle,
              onTap: () => _confirmImport(context, ref),
            ),
            if (NotificationService.isSupported) ...[
              const SizedBox(height: 28),
              Text(
                strings.settingsRemindersSection,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              _SettingsSwitchItem(
                icon: LineIcons.bell,
                title: strings.settingsDailyReminderTitle,
                subtitle: reminder.enabled
                    ? strings.settingsDailyReminderAt(
                        TimeOfDay(
                          hour: reminder.hour,
                          minute: reminder.minute,
                        ).format(context),
                      )
                    : strings.settingsDailyReminderOff,
                value: reminder.enabled,
                onChanged: (value) => _setReminderEnabled(context, ref, value),
              ),
              if (reminder.enabled) ...[
                const SizedBox(height: 10),
                _SettingsItem(
                  icon: LineIcons.clock,
                  title: strings.settingsReminderTimeTitle,
                  subtitle: TimeOfDay(
                    hour: reminder.hour,
                    minute: reminder.minute,
                  ).format(context),
                  onTap: () => _pickReminderTime(context, ref),
                ),
              ],
            ],
            const SizedBox(height: 28),
            Text(
              strings.settingsPrivacySection,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            _SettingsItem(
              icon: LineIcons.lock,
              title: strings.privacySafetyTitle,
              subtitle: strings.settingsPrivacySafetySubtitle,
              onTap: () => _showPrivacySheet(context),
            ),
            const SizedBox(height: 10),
            _SettingsSwitchItem(
              icon: LineIcons.barChart,
              title: strings.settingsAnalyticsTitle,
              subtitle: strings.settingsAnalyticsSubtitle,
              value: usageAnalyticsEnabled,
              onChanged: (value) => _setUsageAnalytics(ref, value),
            ),
            const SizedBox(height: 10),
            _SettingsSwitchItem(
              icon: LineIcons.userLock,
              title: strings.settingsAppLockTitle,
              subtitle: strings.settingsAppLockSubtitle,
              value: appLockEnabled,
              onChanged: (value) => _setAppLock(context, ref, value),
            ),
            const SizedBox(height: 10),
            _SettingsItem(
              icon: LineIcons.alternateTrash,
              title: strings.settingsWipeTitle,
              subtitle: strings.settingsWipeSubtitle,
              onTap: () => _confirmWipeData(context, ref),
            ),
            if (ProService.isPlatformSupported) ...[
              const SizedBox(height: 28),
              Text(
                strings.settingsProSection,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              if (ref.watch(proProvider)) ...[
                _SettingsItem(
                  icon: LineIcons.checkCircle,
                  title: strings.settingsProActiveTitle,
                  subtitle: strings.settingsProActiveSubtitle,
                  onTap: () => showAppSnackBar(
                    context,
                    'Patterns Pro is active on this device.',
                    type: ToastType.success,
                  ),
                ),
              ] else
                _SettingsItem(
                  icon: LineIcons.unlock,
                  title: strings.settingsUnlockProTitle,
                  subtitle: strings.settingsUnlockProSubtitle,
                  onTap: () => PaywallSheet.show(
                    context,
                    entryPoint: ProEntryPoint.settings,
                  ),
                ),
              const SizedBox(height: 10),
              _SettingsItem(
                icon: LineIcons.syncIcon,
                title: strings.settingsRestorePurchasesTitle,
                subtitle: strings.settingsRestorePurchasesSubtitle,
                onTap: () => _restorePurchases(context, ref),
              ),
            ],
            const SizedBox(height: 28),
            Text(
              strings.settingsHelpSection,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            _SettingsItem(
              icon: LineIcons.compass,
              title: strings.settingsReplayTourTitle,
              subtitle: strings.settingsReplayTourSubtitle,
              onTap: () {
                mobilePreferences?.setBool(tabTourSeenKey, false);
                final container = ProviderScope.containerOf(
                  context,
                  listen: false,
                );
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  container.read(tourRequestProvider.notifier).request();
                });
              },
            ),
            const SizedBox(height: 10),
            _SettingsItem(
              icon: LineIcons.lightbulb,
              title: strings.settingsShowWelcomeTitle,
              subtitle: strings.settingsShowWelcomeSubtitle,
              onTap: () {
                mobilePreferences?.setBool(hasStartedKey, false);
                showAppSnackBar(
                  context,
                  'The welcome screens will show next time you open Patterns.',
                  type: ToastType.info,
                );
              },
            ),
            const SizedBox(height: 28),
            Text(
              strings.settingsFeedbackSection,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            _SettingsItem(
              icon: LineIcons.star,
              title: strings.settingsRateTitle,
              subtitle: strings.settingsRateSubtitle,
              onTap: () => ReviewPromptService.requestReviewManually(context),
            ),
            const SizedBox(height: 10),
            _SettingsItem(
              icon: LineIcons.envelope,
              title: strings.settingsSendFeedbackTitle,
              subtitle: strings.settingsSendFeedbackSubtitle,
              onTap: () => ReviewPromptService.sendFeedback(context),
            ),
            if (TipJarService.isPlatformSupported) ...[
              const SizedBox(height: 10),
              _SettingsItem(
                icon: LineIcons.heart,
                title: strings.settingsSupportTitle,
                subtitle: strings.settingsSupportSubtitle,
                onTap: () => TipJarSheet.show(context),
              ),
            ],
            if (kDebugMode) ...[
              const SizedBox(height: 28),
              Text(
                'Debug',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              _SettingsItem(
                icon: LineIcons.barChart,
                title: 'Funnel',
                subtitle: 'On-device telemetry counters & recent events',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const DebugFunnelScreen(),
                  ),
                ),
              ),
            ],
          ], maxSteps: 6),
        ),
      ),
    );
  }

  void _confirmExport(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Export data?',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              'The backup is a readable JSON file and is not encrypted by Patterns. Save it somewhere private.',
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _exportData(context);
                },
                child: const Text('Export JSON backup'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    try {
      final bytes = await DbHelper.instance.exportBundle();
      final path = await FilePicker.platform.saveFile(
        dialogTitle: 'Export Patterns Data',
        fileName: 'patterns_backup.zip',
        type: FileType.custom,
        allowedExtensions: ['zip'],
        bytes: bytes,
      );
      if (path == null) return;
      if (context.mounted) _showMessage(context, 'Data exported');
    } catch (error) {
      if (context.mounted) {
        _showMessage(context, 'Export failed', type: ToastType.error);
      }
    }
  }

  void _confirmImport(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Import data?',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              'Choose a JSON backup. Patterns will show what it contains before replacing current entries.',
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _importData(context, ref);
                },
                child: const Text('Choose backup'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Select Patterns Backup',
        type: FileType.custom,
        allowedExtensions: ['zip', 'json'],
        withData: true,
      );
      if (result == null) return;
      final bytes = result.files.single.bytes;
      if (bytes == null) {
        if (context.mounted) {
          _showMessage(
            context,
            'Could not read backup file',
            type: ToastType.error,
          );
        }
        return;
      }
      final isZip =
          (result.files.single.extension ?? '').toLowerCase() == 'zip';
      final summary = isZip
          ? DbHelper.previewBundle(bytes)
          : DbHelper.previewBackup(utf8.decode(bytes));
      if (context.mounted) {
        _showImportPreview(context, ref, bytes, isZip, summary);
      }
    } on FormatException {
      if (context.mounted) {
        _showMessage(
          context,
          'Backup file is not valid',
          type: ToastType.error,
        );
      }
    } catch (error) {
      if (context.mounted) {
        _showMessage(context, 'Import failed', type: ToastType.error);
      }
    }
  }

  void _showImportPreview(
    BuildContext context,
    WidgetRef ref,
    Uint8List bytes,
    bool isZip,
    BackupSummary summary,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Import backup?',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              'This backup contains ${summary.journalCount} journal entries, ${summary.ocdCount} OCD events, ${summary.delaySessionCount} delay sessions, ${summary.erpExercisePlanCount} ERP plans, and ${summary.erpExerciseSessionCount} ERP practices. Importing replaces your current entries.',
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await _finishImport(context, ref, bytes, isZip);
                    },
                    child: const Text('Replace'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _finishImport(
    BuildContext context,
    WidgetRef ref,
    Uint8List bytes,
    bool isZip,
  ) async {
    try {
      if (isZip) {
        await DbHelper.instance.importBundle(bytes);
      } else {
        await DbHelper.instance.importAll(utf8.decode(bytes));
      }
      ref.invalidate(journalProvider);
      ref.invalidate(ocdProvider);
      ref.invalidate(delaySessionProvider);
      ref.invalidate(erpExercisePlanProvider);
      ref.invalidate(erpExerciseSessionProvider);
      ref.invalidate(exposureHierarchyProvider);
      ref.invalidate(exposureStepProvider);
      ref.invalidate(responsePreventionProvider);
      ref.invalidate(urgeSurfProvider);
      ref.invalidate(programEnrollmentProvider);
      ref.invalidate(programTaskProgressProvider);
      ref.invalidate(behavioralExperimentProvider);
      ref.invalidate(exposureReflectionProvider);
      ref.invalidate(actionPlanProvider);
      ref.invalidate(implementationIntentionProvider);
      ref.invalidate(uncertaintyLogProvider);
      ref.invalidate(exposureMaterialProvider);
      if (context.mounted) _showMessage(context, 'Data imported');
    } on FormatException {
      if (context.mounted) {
        _showMessage(
          context,
          'Backup file is not valid',
          type: ToastType.error,
        );
      }
    } catch (error) {
      if (context.mounted) {
        _showMessage(context, 'Import failed', type: ToastType.error);
      }
    }
  }

  /// Restores a previous Pro purchase and reports what actually happened.
  ///
  /// The old version fired [ProService.restore] without awaiting and always
  /// said "Restoring your purchases", so a purchaser whose restore found
  /// nothing, or failed, was told the same thing as one whose restore worked.
  /// The outcome arrives on [ProService.events]; a restore that matches no
  /// purchase emits nothing at all, hence the deadline.
  Future<void> _restorePurchases(BuildContext context, WidgetRef ref) async {
    AppEvents.logRestoreStarted(ProEntryPoint.settings);
    final messenger = ScaffoldMessenger.of(context);
    showAppSnackBar(
      context,
      context.l10n.proRestoreChecking,
      type: ToastType.info,
    );

    final completer = Completer<ProEvent?>();
    final sub = ProService.events.listen((event) {
      if (!completer.isCompleted) completer.complete(event);
    });

    try {
      await ProService.restore();
      final event = await completer.future.timeout(
        const Duration(seconds: 12),
        onTimeout: () => null,
      );
      if (!context.mounted) return;
      messenger.hideCurrentSnackBar();

      if (event is ProSuccess) {
        AppEvents.logSupporterPurchaseCompleted(
          restored: true,
          source: ProEntryPoint.settings,
        );
        ref.read(proProvider.notifier).refresh();
        showAppSnackBar(
          context,
          context.l10n.proRestoreSucceeded,
          type: ToastType.success,
        );
      } else if (event is ProError) {
        AppEvents.logRestoreFailed(ProEntryPoint.settings);
        showAppSnackBar(
          context,
          context.l10n.proPaywallRestoreFailed,
          type: ToastType.error,
        );
      } else {
        AppEvents.logRestoreNotFound(ProEntryPoint.settings);
        showAppSnackBar(
          context,
          context.l10n.proPaywallRestoreNotFound,
          type: ToastType.info,
        );
      }
    } catch (_) {
      AppEvents.logRestoreFailed(ProEntryPoint.settings);
      if (!context.mounted) return;
      messenger.hideCurrentSnackBar();
      showAppSnackBar(
        context,
        context.l10n.proPaywallRestoreFailed,
        type: ToastType.error,
      );
    } finally {
      await sub.cancel();
    }
  }

  void _confirmWipeData(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wipe all data?',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              'This deletes local journal entries, OCD events, ERP practice history, and app preferences from this device. This cannot be undone.\n\n'
              'If you have Patterns Pro, your purchase is safe, but this device will forget it. Tap Restore purchases afterwards to bring it back.',
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await DbHelper.instance.clearAll();
                      await MaterialFileStore.deleteAll();
                      await clearLocalPreferences();
                      ref.invalidate(usageAnalyticsEnabledProvider);
                      ref.invalidate(appearanceProvider);
                      ref.invalidate(meaningfulActionCountProvider);
                      ref.invalidate(journalProvider);
                      ref.invalidate(ocdProvider);
                      ref.invalidate(delaySessionProvider);
                      ref.invalidate(erpExercisePlanProvider);
                      ref.invalidate(erpExerciseSessionProvider);
                      ref.invalidate(exposureMaterialProvider);
                      if (context.mounted) {
                        _showMessage(context, 'Local data wiped');
                      }
                    },
                    child: const Text('Wipe'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(
    BuildContext context,
    String message, {
    ToastType type = ToastType.success,
  }) {
    showAppSnackBar(context, message, type: type);
  }

  Future<void> _setAppLock(
    BuildContext context,
    WidgetRef ref,
    bool enabled,
  ) async {
    if (!enabled) {
      await ref.read(appLockEnabledProvider.notifier).setEnabled(false);
      if (context.mounted) _showMessage(context, 'App lock disabled');
      return;
    }

    try {
      final auth = ref.read(biometricAuthenticatorProvider);
      final supported = await auth.isDeviceSupported();
      if (!supported) {
        if (context.mounted) {
          _showMessage(
            context,
            'Device lock unavailable',
            type: ToastType.error,
          );
        }
        return;
      }
      // local_auth 3.x returns true only on success; everything else (cancel,
      // lockout, missing biometrics, etc.) is surfaced as LocalAuthException.
      await auth.authenticate(reason: 'Unlock Patterns to enable app lock.');
      await ref.read(appLockEnabledProvider.notifier).setEnabled(true);
      if (context.mounted) _showMessage(context, 'App lock enabled');
    } on LocalAuthException catch (e) {
      if (!context.mounted) return;
      switch (e.code) {
        case LocalAuthExceptionCode.userCanceled:
        case LocalAuthExceptionCode.systemCanceled:
        case LocalAuthExceptionCode.timeout:
        case LocalAuthExceptionCode.userRequestedFallback:
          // User-initiated abort - no message, the toggle simply stays off.
          break;
        case LocalAuthExceptionCode.temporaryLockout:
          _showMessage(
            context,
            'Too many attempts. Try again in a moment.',
            type: ToastType.error,
          );
          break;
        case LocalAuthExceptionCode.biometricLockout:
          _showMessage(
            context,
            'Biometric authentication is locked. Unlock your device with your passcode first.',
            type: ToastType.error,
          );
          break;
        case LocalAuthExceptionCode.noBiometricsEnrolled:
        case LocalAuthExceptionCode.noCredentialsSet:
        case LocalAuthExceptionCode.noBiometricHardware:
        case LocalAuthExceptionCode.biometricHardwareTemporarilyUnavailable:
          _showMessage(
            context,
            'Device lock unavailable',
            type: ToastType.error,
          );
          break;
        default:
          _showMessage(
            context,
            'Could not enable app lock',
            type: ToastType.error,
          );
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(
          context,
          'Could not enable app lock',
          type: ToastType.error,
        );
      }
    }
  }

  Future<void> _setReminderEnabled(
    BuildContext context,
    WidgetRef ref,
    bool enabled,
  ) async {
    if (!enabled) {
      await ref.read(reminderProvider.notifier).setEnabled(false);
      await NotificationService.cancelReminder();
      if (context.mounted) _showMessage(context, 'Daily reminder turned off');
      return;
    }

    final granted = await NotificationService.requestPermission();
    if (!granted) {
      if (context.mounted) {
        _showMessage(
          context,
          'Notifications are off for Patterns. Enable them in your device '
          'settings to get reminders.',
          type: ToastType.info,
        );
      }
      return;
    }

    final settings = ref.read(reminderProvider);
    await NotificationService.scheduleDailyReminder(
      TimeOfDay(hour: settings.hour, minute: settings.minute),
      strings: context.l10n,
    );
    await ref.read(reminderProvider.notifier).setEnabled(true);
    if (context.mounted) _showMessage(context, 'Daily reminder is on');
  }

  Future<void> _pickReminderTime(BuildContext context, WidgetRef ref) async {
    final settings = ref.read(reminderProvider);
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: settings.hour, minute: settings.minute),
    );
    if (picked == null) return;
    await ref
        .read(reminderProvider.notifier)
        .setTime(picked.hour, picked.minute);
    if (ref.read(reminderProvider).enabled) {
      await NotificationService.scheduleDailyReminder(
        picked,
        strings: context.l10n,
      );
      if (context.mounted) {
        _showMessage(context, 'Reminder set for ${picked.format(context)}');
      }
    }
  }

  void _showPrivacySheet(BuildContext context) {
    final strings = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strings.privacySafetyTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Text(
              strings.privacyLocalContent,
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              strings.privacyPurchases,
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              strings.privacyExports,
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              strings.privacyAnalytics,
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              strings.privacyClinicalBoundary,
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => launchUrl(
                  Uri.parse('https://patternsocd.com/privacy'),
                  mode: LaunchMode.externalApplication,
                ),
                child: Text(strings.viewPrivacyPolicyAction),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setUsageAnalytics(WidgetRef ref, bool enabled) async {
    await appPreferences?.setString(
      analyticsConsentDecisionKey,
      (enabled
              ? AnalyticsConsentDecision.granted
              : AnalyticsConsentDecision.declined)
          .name,
    );
    await ref.read(usageAnalyticsEnabledProvider.notifier).setEnabled(enabled);
    await usageAnalytics.setCollectionEnabled(enabled);
    if (enabled) {
      AppEvents.logAnalyticsConsentGranted();
      await usageAnalytics.flush();
    }
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PressScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: _softDecoration(theme, radius: 22),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LineIcons.angleRight,
              color: context.appColors.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSwitchItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _softDecoration(theme, radius: 22),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: context.appColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _AppearancePicker extends StatelessWidget {
  final AppAppearance value;
  final ValueChanged<AppAppearance> onChanged;

  const _AppearancePicker({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: _softDecoration(theme, radius: 22),
      child: SegmentedButton<AppAppearance>(
        segments: [
          ButtonSegment(
            value: AppAppearance.system,
            icon: const Icon(LineIcons.adjust),
            label: Text(context.l10n.appearanceSystem),
          ),
          ButtonSegment(
            value: AppAppearance.light,
            icon: const Icon(LineIcons.sun),
            label: Text(context.l10n.appearanceLight),
          ),
          ButtonSegment(
            value: AppAppearance.dark,
            icon: const Icon(LineIcons.moon),
            label: Text(context.l10n.appearanceDark),
          ),
        ],
        selected: {value},
        showSelectedIcon: false,
        onSelectionChanged: (selection) => onChanged(selection.single),
      ),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  final Widget child;

  const _BottomPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: child,
      ),
    );
  }
}

TextStyle _screenTitle(ThemeData theme) {
  return TextStyle(
    fontFamily: AppTheme.sansFamily,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.5,
    color: theme.colorScheme.onSurface,
  );
}

BoxDecoration _softDecoration(ThemeData theme, {required double radius}) {
  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.9)),
  );
}
