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
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  icon: const Icon(LineIcons.angleLeft),
                ),
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      strings.settingsTitle,
                      style: _screenTitle(theme),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            _sectionHeading(context, strings.appearanceTitle),
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
            _sectionHeading(context, strings.settingsDataSection),
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
              _sectionHeading(context, strings.settingsRemindersSection),
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
            _sectionHeading(context, strings.settingsPrivacySection),
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
              onChanged: (value) => _setUsageAnalytics(context, ref, value),
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
              _sectionHeading(context, strings.settingsProSection),
              const SizedBox(height: 12),
              if (ref.watch(proProvider)) ...[
                _SettingsItem(
                  icon: LineIcons.checkCircle,
                  title: strings.settingsProActiveTitle,
                  subtitle: strings.settingsProActiveSubtitle,
                  onTap: () => showAppSnackBar(
                    context,
                    strings.settingsText('proActiveMessage'),
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
            _sectionHeading(context, strings.settingsHelpSection),
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
                  strings.settingsText('welcomeScheduled'),
                  type: ToastType.info,
                );
              },
            ),
            const SizedBox(height: 28),
            _sectionHeading(context, strings.settingsFeedbackSection),
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
              _sectionHeading(context, 'Debug'),
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
            Semantics(
              header: true,
              child: Text(
                strings.settingsText('exportPromptTitle'),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              strings.settingsText('exportPromptBody'),
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
                child: Text(strings.settingsText('exportBackupAction')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    final strings = context.l10n;
    try {
      final bytes = await DbHelper.instance.exportBundle();
      final path = await FilePicker.platform.saveFile(
        dialogTitle: strings.settingsText('exportDialogTitle'),
        fileName: 'patterns_backup.zip',
        type: FileType.custom,
        allowedExtensions: ['zip'],
        bytes: bytes,
      );
      if (path == null) return;
      if (context.mounted) {
        _showMessage(context, strings.settingsText('exportSucceeded'));
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(
          context,
          strings.settingsText('exportFailed'),
          type: ToastType.error,
        );
      }
    }
  }

  void _confirmImport(BuildContext context, WidgetRef ref) {
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
            Semantics(
              header: true,
              child: Text(
                strings.settingsText('importPromptTitle'),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              strings.settingsText('importPromptBody'),
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
                child: Text(strings.settingsText('chooseBackupAction')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    final strings = context.l10n;
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: strings.settingsText('importDialogTitle'),
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
            strings.settingsText('backupUnreadable'),
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
          strings.settingsText('backupInvalid'),
          type: ToastType.error,
        );
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(
          context,
          strings.settingsText('importFailed'),
          type: ToastType.error,
        );
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
    final strings = context.l10n;
    final recoveryCount =
        summary.exposureHierarchyCount +
        summary.exposureStepCount +
        summary.responsePreventionCount +
        summary.urgeSurfCount +
        summary.programEnrollmentCount +
        summary.programTaskProgressCount +
        summary.behavioralExperimentCount +
        summary.exposureReflectionCount +
        summary.actionPlanCount +
        summary.implementationIntentionCount +
        summary.uncertaintyLogCount +
        summary.exposureMaterialCount;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _BottomPanel(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                strings.settingsText('importPreviewTitle'),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              strings.settingsText('importPreviewIntro'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
            _BackupCountList(
              lines: [
                strings.settingsBackupJournalCount(summary.journalCount),
                strings.settingsBackupOcdCount(summary.ocdCount),
                strings.settingsBackupDelayCount(summary.delaySessionCount),
                strings.settingsBackupErpPlanCount(
                  summary.erpExercisePlanCount,
                ),
                strings.settingsBackupErpPracticeCount(
                  summary.erpExerciseSessionCount,
                ),
                strings.settingsBackupRecoveryCount(recoveryCount),
                strings.settingsBackupSelfCheckCount(
                  summary.ybocsAssessmentCount,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _PanelActions(
              cancelLabel: strings.cancelAction,
              confirmLabel: strings.settingsText('replaceAction'),
              onCancel: () => Navigator.pop(context),
              onConfirm: () async {
                Navigator.pop(context);
                await _finishImport(context, ref, bytes, isZip);
              },
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
    final strings = context.l10n;
    try {
      if (isZip) {
        await DbHelper.instance.importBundle(bytes);
      } else {
        await DbHelper.instance.importAll(utf8.decode(bytes));
      }
      _invalidateLocalDataProviders(ref);
      if (context.mounted) {
        _showMessage(context, strings.settingsText('importSucceeded'));
      }
    } on FormatException {
      if (context.mounted) {
        _showMessage(
          context,
          strings.settingsText('backupInvalid'),
          type: ToastType.error,
        );
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(
          context,
          strings.settingsText('importFailed'),
          type: ToastType.error,
        );
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
            Semantics(
              header: true,
              child: Text(
                strings.settingsText('wipePromptTitle'),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              strings.settingsText('wipePromptBody'),
              style: TextStyle(
                color: context.appColors.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            _PanelActions(
              cancelLabel: strings.cancelAction,
              confirmLabel: strings.settingsText('wipeAction'),
              onCancel: () => Navigator.pop(context),
              onConfirm: () async {
                final successMessage = strings.settingsText('wipeSucceeded');
                Navigator.pop(context);
                try {
                  await DbHelper.instance.clearAll();
                  await MaterialFileStore.deleteAll();
                  await clearLocalPreferences();
                  _invalidateLocalDataProviders(ref);
                  _invalidateLocalPreferenceProviders(ref);
                  if (context.mounted) {
                    _showMessage(context, successMessage);
                  }
                } catch (_) {
                  if (context.mounted) {
                    _showMessage(
                      context,
                      strings.settingsText('wipeFailed'),
                      type: ToastType.error,
                    );
                  }
                }
              },
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
      try {
        await ref.read(appLockEnabledProvider.notifier).setEnabled(false);
        if (context.mounted) {
          _showMessage(context, context.l10n.settingsText('appLockDisabled'));
        }
      } catch (_) {
        if (context.mounted) {
          _showMessage(
            context,
            context.l10n.settingsText('appLockEnableFailed'),
            type: ToastType.error,
          );
        }
      }
      return;
    }

    try {
      final auth = ref.read(biometricAuthenticatorProvider);
      final supported = await auth.isDeviceSupported();
      if (!supported) {
        if (context.mounted) {
          _showMessage(
            context,
            context.l10n.settingsText('deviceLockUnavailable'),
            type: ToastType.error,
          );
        }
        return;
      }
      // local_auth 3.x returns true only on success; everything else (cancel,
      // lockout, missing biometrics, etc.) is surfaced as LocalAuthException.
      final authenticated = await auth.authenticate(
        reason: context.l10n.settingsText('appLockReason'),
      );
      if (!authenticated) return;
      await ref.read(appLockEnabledProvider.notifier).setEnabled(true);
      if (context.mounted) {
        _showMessage(context, context.l10n.settingsText('appLockEnabled'));
      }
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
            context.l10n.settingsText('appLockTemporaryLockout'),
            type: ToastType.error,
          );
          break;
        case LocalAuthExceptionCode.biometricLockout:
          _showMessage(
            context,
            context.l10n.settingsText('appLockBiometricLockout'),
            type: ToastType.error,
          );
          break;
        case LocalAuthExceptionCode.noBiometricsEnrolled:
        case LocalAuthExceptionCode.noCredentialsSet:
        case LocalAuthExceptionCode.noBiometricHardware:
        case LocalAuthExceptionCode.biometricHardwareTemporarilyUnavailable:
          _showMessage(
            context,
            context.l10n.settingsText('deviceLockUnavailable'),
            type: ToastType.error,
          );
          break;
        default:
          _showMessage(
            context,
            context.l10n.settingsText('appLockEnableFailed'),
            type: ToastType.error,
          );
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(
          context,
          context.l10n.settingsText('appLockEnableFailed'),
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
    final strings = context.l10n;
    try {
      if (!enabled) {
        await NotificationService.cancelReminder();
        await ref.read(reminderProvider.notifier).setEnabled(false);
        if (context.mounted) {
          _showMessage(context, strings.settingsText('reminderOff'));
        }
        return;
      }

      final granted = await NotificationService.requestPermission();
      if (!granted) {
        if (context.mounted) {
          _showMessage(
            context,
            strings.settingsText('notificationsUnavailable'),
            type: ToastType.info,
          );
        }
        return;
      }

      final settings = ref.read(reminderProvider);
      await NotificationService.scheduleDailyReminder(
        TimeOfDay(hour: settings.hour, minute: settings.minute),
        strings: strings,
      );
      await ref.read(reminderProvider.notifier).setEnabled(true);
      if (context.mounted) {
        _showMessage(context, strings.settingsText('reminderOn'));
      }
    } catch (_) {
      if (enabled) {
        await NotificationService.cancelReminder().catchError((_) {});
      }
      if (context.mounted) {
        _showMessage(
          context,
          strings.settingsText('reminderChangeFailed'),
          type: ToastType.error,
        );
      }
    }
  }

  Future<void> _pickReminderTime(BuildContext context, WidgetRef ref) async {
    final settings = ref.read(reminderProvider);
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: settings.hour, minute: settings.minute),
    );
    if (picked == null) return;
    final strings = context.l10n;
    try {
      if (settings.enabled) {
        await NotificationService.scheduleDailyReminder(
          picked,
          strings: strings,
        );
      }
      await ref
          .read(reminderProvider.notifier)
          .setTime(picked.hour, picked.minute);
      if (context.mounted) {
        _showMessage(
          context,
          strings.settingsReminderSetFor(picked.format(context)),
        );
      }
    } catch (_) {
      if (settings.enabled) {
        await NotificationService.scheduleDailyReminder(
          TimeOfDay(hour: settings.hour, minute: settings.minute),
          strings: strings,
        ).catchError((_) {});
      }
      if (context.mounted) {
        _showMessage(
          context,
          strings.settingsText('reminderChangeFailed'),
          type: ToastType.error,
        );
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
            Semantics(
              header: true,
              child: Text(
                strings.privacySafetyTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
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
                onPressed: () => _openPrivacyPolicy(context),
                child: Text(strings.viewPrivacyPolicyAction),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    try {
      final opened = await launchUrl(
        Uri.parse('https://patternsocd.com/privacy'),
        mode: LaunchMode.externalApplication,
      );
      if (!opened && context.mounted) {
        _showMessage(
          context,
          context.l10n.settingsText('privacyPolicyFailed'),
          type: ToastType.error,
        );
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(
          context,
          context.l10n.settingsText('privacyPolicyFailed'),
          type: ToastType.error,
        );
      }
    }
  }

  Future<void> _setUsageAnalytics(
    BuildContext context,
    WidgetRef ref,
    bool enabled,
  ) async {
    final previous = ref.read(usageAnalyticsEnabledProvider);
    final previousDecision = appPreferences?.getString(
      analyticsConsentDecisionKey,
    );
    try {
      await appPreferences?.setString(
        analyticsConsentDecisionKey,
        (enabled
                ? AnalyticsConsentDecision.granted
                : AnalyticsConsentDecision.declined)
            .name,
      );
      await ref
          .read(usageAnalyticsEnabledProvider.notifier)
          .setEnabled(enabled);
      await usageAnalytics.setCollectionEnabled(enabled);
      if (enabled) {
        AppEvents.logAnalyticsConsentGranted();
        await usageAnalytics.flush();
      }
    } catch (_) {
      await ref
          .read(usageAnalyticsEnabledProvider.notifier)
          .setEnabled(previous);
      await usageAnalytics.setCollectionEnabled(previous).catchError((_) {});
      if (previousDecision == null) {
        await appPreferences?.remove(analyticsConsentDecisionKey);
      } else {
        await appPreferences?.setString(
          analyticsConsentDecisionKey,
          previousDecision,
        );
      }
      if (context.mounted) {
        _showMessage(
          context,
          context.l10n.settingsText('analyticsChangeFailed'),
          type: ToastType.error,
        );
      }
    }
  }
}

void _invalidateLocalDataProviders(WidgetRef ref) {
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
  ref.invalidate(ybocsAssessmentProvider);
}

void _invalidateLocalPreferenceProviders(WidgetRef ref) {
  ref.invalidate(usageAnalyticsEnabledProvider);
  ref.invalidate(appearanceProvider);
  ref.invalidate(languageProvider);
  ref.invalidate(calmInsightsProvider);
  ref.invalidate(meaningfulActionCountProvider);
  ref.invalidate(appLockEnabledProvider);
  ref.invalidate(reminderProvider);
  ref.invalidate(proProvider);
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

    return Semantics(
      button: true,
      label: title,
      hint: subtitle,
      onTap: onTap,
      child: ExcludeSemantics(
        child: PressScale(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 44),
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
        ),
      ),
    );
  }
}

class _BackupCountList extends StatelessWidget {
  final List<String> lines;

  const _BackupCountList({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExcludeSemantics(
                  child: Icon(
                    Icons.circle,
                    size: 5,
                    color: context.appColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(line)),
              ],
            ),
          ),
      ],
    );
  }
}

class _PanelActions extends StatelessWidget {
  final String cancelLabel;
  final String confirmLabel;
  final VoidCallback onCancel;
  final FutureOr<void> Function() onConfirm;

  const _PanelActions({
    required this.cancelLabel,
    required this.confirmLabel,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final stacked = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    final cancel = OutlinedButton(
      onPressed: onCancel,
      child: Text(cancelLabel),
    );
    final confirm = ElevatedButton(
      onPressed: onConfirm,
      child: Text(confirmLabel),
    );
    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [confirm, const SizedBox(height: 10), cancel],
      );
    }
    return Row(
      children: [
        Expanded(child: cancel),
        const SizedBox(width: 12),
        Expanded(child: confirm),
      ],
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

    return Semantics(
      container: true,
      toggled: value,
      label: title,
      hint: subtitle,
      onTap: () => onChanged(!value),
      child: ExcludeSemantics(
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
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
        ),
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
    final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: _softDecoration(theme, radius: 22),
      child: SegmentedButton<AppAppearance>(
        direction: largeText ? Axis.vertical : Axis.horizontal,
        expandedInsets: largeText ? null : const EdgeInsets.all(0),
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
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.88,
          ),
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: SingleChildScrollView(child: child),
        ),
      ),
    );
  }
}

Widget _sectionHeading(BuildContext context, String text) {
  return Semantics(
    header: true,
    child: Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
    ),
  );
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
