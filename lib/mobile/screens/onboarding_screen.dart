import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../services/telemetry.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../first_run.dart';

/// First-run experience: two calm screens.
///
/// S1 states the promise + privacy. S2 asks "What would help right now?" and
/// routes the user straight into one short, relevant activity. There is no
/// multi-page teaching carousel, no tour, and no paywall here — depth is
/// revealed later, once the user has felt some value.
class WelcomeScreen extends StatefulWidget {
  /// Called when the user picks a path on S2. The shell persists the choice and
  /// routes into the matching activity.
  final void Function(FirstRunPath path) onChoosePath;

  /// "Import existing data" — brings a returning user back to their backup.
  final VoidCallback onImport;

  const WelcomeScreen({
    super.key,
    required this.onChoosePath,
    required this.onImport,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  var _index = 0;

  @override
  void initState() {
    super.initState();
    Telemetry.log('onboarding.s1_shown');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToChoices() {
    Telemetry.log('onboarding.get_started');
    _controller.animateToPage(
      1,
      duration: AppMotion.medium,
      curve: Curves.easeOutCubic,
    );
  }

  void _back() {
    _controller.animateToPage(
      0,
      duration: AppMotion.medium,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Hard-coded dark surface (fixed gradient + glass), so force the dark theme
    // regardless of the app's resolved mode to keep descendants readable.
    return Theme(
      data: AppTheme.mobileDarkTheme,
      child: Builder(builder: _buildContent),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 160),
                      child: _index == 0
                          ? const SizedBox(key: ValueKey('no-back'))
                          : IconButton(
                              key: const ValueKey('back'),
                              tooltip: 'Back',
                              onPressed: _back,
                              icon: const Icon(LineIcons.angleLeft, size: 20),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() => _index = value);
                      if (value == 1) Telemetry.log('onboarding.s2_shown');
                    },
                    children: [
                      _PromiseView(
                        onGetStarted: _goToChoices,
                        onImport: widget.onImport,
                      ),
                      _ChoicesView(onChoose: widget.onChoosePath),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Private by design. Not a diagnosis or a replacement for '
                  'professional care.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- S1: promise + privacy -------------------------------------------------

class _PromiseView extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onImport;

  const _PromiseView({required this.onGetStarted, required this.onImport});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                FadeSlideIn(
                  child: Text(
                    'PATTERNS',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.warmYellow,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                const FadeSlideIn(
                  duration: AppMotion.slow,
                  child: _Hero(icon: LineIcons.feather),
                ),
                const SizedBox(height: 30),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 90),
                  child: Text(
                    'A calm, private place\nfor the hard moments.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppTheme.displayFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      height: 1.1,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 130),
                  child: Text(
                    'Notice a thought, sit with an urge, and practise '
                    'responding differently, one small step at a time.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.48,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 170),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: _glassDecoration(),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.warmYellow.withValues(alpha: 0.14),
                          ),
                          child: const Icon(
                            LineIcons.lock,
                            color: AppTheme.warmYellow,
                            size: 17,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Everything stays on this device. No account. '
                            'No cloud. No remote analytics.',
                            style: TextStyle(
                              fontSize: 13.5,
                              height: 1.35,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onGetStarted,
            child: const Text('Get started'),
          ),
        ),
        TextButton(
          onPressed: onImport,
          child: const Text('Import existing data'),
        ),
      ],
    );
  }
}

// --- S2: what would help right now? ----------------------------------------

class _Choice {
  final FirstRunPath path;
  final IconData icon;
  final String title;
  final String subtitle;

  const _Choice(this.path, this.icon, this.title, this.subtitle);
}

const _choices = <_Choice>[
  _Choice(
    FirstRunPath.urge,
    LineIcons.hourglassHalf,
    "I'm dealing with an urge",
    'Create some space before you respond.',
  ),
  _Choice(
    FirstRunPath.journal,
    LineIcons.pen,
    'I want to write something down',
    'Get the thought out of your head.',
  ),
  _Choice(
    FirstRunPath.erp,
    LineIcons.seedling,
    'I want to practise responding differently',
    'A short, guided exercise.',
  ),
  _Choice(
    FirstRunPath.selfcheck,
    LineIcons.clipboardList,
    'I want to understand my patterns',
    'An optional check-in. About 10 minutes.',
  ),
  _Choice(
    FirstRunPath.explore,
    LineIcons.compass,
    "I'm just exploring",
    'Have a look around first.',
  ),
];

class _ChoicesView extends StatelessWidget {
  final void Function(FirstRunPath path) onChoose;

  const _ChoicesView({required this.onChoose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        FadeSlideIn(
          child: Text(
            'What would help right now?',
            style: const TextStyle(
              fontFamily: AppTheme.displayFamily,
              fontWeight: FontWeight.w600,
              fontSize: 28,
              height: 1.1,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        FadeSlideIn(
          delay: const Duration(milliseconds: 80),
          child: Text(
            'Pick one. You can do the rest whenever you like.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 4),
            itemCount: _choices.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final choice = _choices[i];
              return FadeSlideIn(
                delay: Duration(milliseconds: 120 + i * 50),
                child: _ChoiceCard(
                  choice: choice,
                  onTap: () => onChoose(choice.path),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  final _Choice choice;
  final VoidCallback onTap;

  const _ChoiceCard({required this.choice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _glassDecoration(),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.warmYellow.withValues(alpha: 0.13),
              ),
              child: Icon(choice.icon, color: AppTheme.warmYellow, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    choice.title,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    choice.subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.3,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              LineIcons.angleRight,
              color: AppTheme.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

// --- shared visuals --------------------------------------------------------

class _Hero extends StatelessWidget {
  final IconData icon;

  const _Hero({required this.icon});

  @override
  Widget build(BuildContext context) {
    const size = 172.0;
    const inner = size * 0.447;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: const _SignalPainter(color: AppTheme.warmYellow),
        child: Center(
          child: Container(
            width: inner,
            height: inner,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.warmYellow,
                  AppTheme.warmYellow.withValues(alpha: 0.62),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.warmYellow.withValues(alpha: 0.28),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF17130A), size: 34),
          ),
        ),
      ),
    );
  }
}

class _SignalPainter extends CustomPainter {
  final Color color;

  const _SignalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = color.withValues(alpha: 0.26);
    for (final fraction in [0.287, 0.394, 0.497]) {
      canvas.drawCircle(center, size.width * fraction, ringPaint);
    }

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..color = color.withValues(alpha: 0.34);
    final path = Path();
    for (var i = 0; i < 5; i++) {
      final x = size.width * (0.16 + i * 0.17);
      final y = center.dy + math.sin(i * 1.2) * 22;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = color);
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _SignalPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

BoxDecoration _glassDecoration() {
  return BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1B1B19), Color(0xFF141413)],
    ),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: const Color(0xFF34322D)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.22),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
