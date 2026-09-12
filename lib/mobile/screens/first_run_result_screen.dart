import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../app_preferences.dart';
import '../../services/notification_service.dart';
import '../../l10n/l10n.dart';
import '../../services/telemetry.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/app_snack_bar.dart';
import '../first_run.dart';

/// The honest, effort-framed close of a new user's first activity.
///
/// One calm screen: a message that credits *effort* (never clinical
/// improvement), an optional gentle-reminder ask (the psychologically honest
/// moment to request notification permission), and a single primary CTA into
/// the app.
class FirstRunResultScreen extends ConsumerStatefulWidget {
  final FirstRunPath kind;
  final FirstRunActivityResult result;
  final VoidCallback onDone;

  const FirstRunResultScreen({
    super.key,
    required this.kind,
    required this.result,
    required this.onDone,
  });

  @override
  ConsumerState<FirstRunResultScreen> createState() =>
      _FirstRunResultScreenState();
}

class _FirstRunResultScreenState extends ConsumerState<FirstRunResultScreen> {
  bool _reminderSet = false;

  @override
  void initState() {
    super.initState();
    Telemetry.log('result.shown', {'kind': widget.kind.name});
  }

  ({String headline, String body, IconData icon}) _copy(BuildContext context) {
    final strings = context.l10n;
    switch (widget.kind) {
      case FirstRunPath.urge:
        return (
          headline: strings.completionPracticeTitle,
          body: strings.completionDelayBody,
          icon: LineIcons.hourglassHalf,
        );
      case FirstRunPath.journal:
        return (
          headline: strings.completionSavedTitle,
          body: strings.completionTrackedBody,
          icon: LineIcons.pen,
        );
      case FirstRunPath.erp:
        return (
          headline: strings.completionPracticeTitle,
          body: strings.completionErpBody,
          icon: LineIcons.seedling,
        );
      case FirstRunPath.selfcheck:
        return (
          headline: strings.completionSavedTitle,
          body: strings.shellText('firstSelfCheckBody'),
          icon: LineIcons.clipboardList,
        );
      case FirstRunPath.explore:
        return (
          headline: strings.shellText('firstExploreTitle'),
          body: strings.shellText('firstExploreBody'),
          icon: LineIcons.compass,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final copy = _copy(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [context.appColors.surface, context.appColors.surface],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FadeSlideIn(
                            child: ExcludeSemantics(
                              child: Container(
                                width: 76,
                                height: 76,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.appColors.accent.withValues(
                                    alpha: 0.15,
                                  ),
                                ),
                                child: Icon(
                                  copy.icon,
                                  color: context.appColors.accent,
                                  size: 34,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),
                          FadeSlideIn(
                            delay: const Duration(milliseconds: 90),
                            child: Semantics(
                              header: true,
                              child: Text(
                                copy.headline,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.displayFamily,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 27,
                                  height: 1.15,
                                  color: context.appColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          FadeSlideIn(
                            delay: const Duration(milliseconds: 130),
                            child: Text(
                              copy.body,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: context.appColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!_reminderSet)
                  OutlinedButton.icon(
                    onPressed: _askReminder,
                    icon: Icon(LineIcons.bell, size: 18),
                    label: Text(context.l10n.shellText('setReminder')),
                  ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Telemetry.log('result.cta_today', {
                        'kind': widget.kind.name,
                      });
                      widget.onDone();
                    },
                    child: Text(context.l10n.shellText('goToSpace')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _askReminder() async {
    Telemetry.log('result.cta_reminder', {'kind': widget.kind.name});
    Telemetry.log('reminder.ask_shown');
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(
        hour: NotificationService.defaultHour,
        minute: NotificationService.defaultMinute,
      ),
      helpText: context.l10n.shellText('reminderPrompt'),
    );
    if (picked == null || !mounted) {
      Telemetry.log('reminder.declined', {'reason': 'no_time'});
      return;
    }

    final strings = context.l10n;
    final granted = await NotificationService.requestPermission();
    if (!granted) {
      Telemetry.log('reminder.declined', {'reason': 'permission'});
      if (mounted) {
        showAppSnackBar(
          context,
          strings.shellText('notificationsOff'),
          type: ToastType.info,
        );
      }
      return;
    }

    try {
      await NotificationService.scheduleDailyReminder(picked, strings: strings);
      await ref
          .read(reminderProvider.notifier)
          .setTime(picked.hour, picked.minute);
      await ref.read(reminderProvider.notifier).setEnabled(true);
      Telemetry.log('reminder.enabled');
      if (!mounted) return;
      setState(() => _reminderSet = true);
      showAppSnackBar(
        context,
        strings.shellText('reminderSet'),
        type: ToastType.success,
      );
    } catch (_) {
      await NotificationService.cancelReminder().catchError((_) {});
      if (!mounted) return;
      showAppSnackBar(
        context,
        strings.shellText('reminderFailed'),
        type: ToastType.error,
      );
    }
  }
}
