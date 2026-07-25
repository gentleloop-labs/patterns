import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../app_preferences.dart';
import '../../services/notification_service.dart';
import '../../services/telemetry.dart';
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

  ({String headline, String body, IconData icon}) get _copy {
    final before = widget.result.intensityBefore;
    final after = widget.result.intensityAfter;
    switch (widget.kind) {
      case FirstRunPath.urge:
        final dropLine = (before != null && after != null && after < before)
            ? 'Your urge dropped from $before to $after. '
            : 'Whether or not the urge dropped, showing up is what counts. ';
        return (
          headline: 'You made space before responding.',
          body:
              '${dropLine}That pause is the practice. The urge doesn’t have to '
              'win, and you just proved it.',
          icon: LineIcons.hourglassHalf,
        );
      case FirstRunPath.journal:
        return (
          headline: 'It’s out of your head and on the page.',
          body:
              'Naming a thought takes some of its power away. That’s a real '
              'step.',
          icon: LineIcons.pen,
        );
      case FirstRunPath.erp:
        return (
          headline: 'You practised sitting with discomfort.',
          body:
              'That’s exactly how the brain learns the fear alarm is a false '
              'one.',
          icon: LineIcons.seedling,
        );
      case FirstRunPath.selfcheck:
        return (
          headline: 'Thanks for checking in.',
          body:
              'This gives you a starting point to look back on later, not a '
              'label.',
          icon: LineIcons.clipboardList,
        );
      case FirstRunPath.explore:
        return (
          headline: 'Nice to have you here.',
          body: 'Take your time and look around.',
          icon: LineIcons.compass,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final copy = _copy;

    return Theme(
      data: AppTheme.mobileDarkTheme,
      child: Builder(
        builder: (context) => Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0B0B0A), AppTheme.deepCharcoal],
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
                                child: Container(
                                  width: 76,
                                  height: 76,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.warmYellow.withValues(
                                      alpha: 0.15,
                                    ),
                                  ),
                                  child: Icon(
                                    copy.icon,
                                    color: AppTheme.warmYellow,
                                    size: 34,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 26),
                              FadeSlideIn(
                                delay: const Duration(milliseconds: 90),
                                child: Text(
                                  copy.headline,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: AppTheme.displayFamily,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 27,
                                    height: 1.15,
                                    color: AppTheme.textPrimary,
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
                                    color: AppTheme.textSecondary,
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
                        icon: const Icon(LineIcons.bell, size: 18),
                        label: const Text('Set a gentle reminder'),
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
                        child: const Text('Go to my space'),
                      ),
                    ),
                  ],
                ),
              ),
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
      helpText: 'When should we check in?',
    );
    if (picked == null || !mounted) {
      Telemetry.log('reminder.declined', {'reason': 'no_time'});
      return;
    }

    final granted = await NotificationService.requestPermission();
    if (!granted) {
      Telemetry.log('reminder.declined', {'reason': 'permission'});
      if (mounted) {
        showAppSnackBar(
          context,
          'Notifications are off for Patterns. You can turn them on anytime '
          'in Settings.',
          type: ToastType.info,
        );
      }
      return;
    }

    await NotificationService.scheduleDailyReminder(picked);
    await ref.read(reminderProvider.notifier).setTime(picked.hour, picked.minute);
    await ref.read(reminderProvider.notifier).setEnabled(true);
    Telemetry.log('reminder.enabled');
    if (!mounted) return;
    setState(() => _reminderSet = true);
    showAppSnackBar(
      context,
      'A gentle reminder is set. Turn it off anytime in Settings.',
      type: ToastType.success,
    );
  }
}
