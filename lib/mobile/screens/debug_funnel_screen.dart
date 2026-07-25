import 'package:flutter/material.dart';

import '../../app_preferences.dart';
import '../../services/telemetry.dart';
import '../../theme/app_theme.dart';

/// Hidden debug readout for on-device [Telemetry]. Reachable only from a
/// debug-gated Settings entry. Renders the funnel counters and the recent
/// event ring buffer so the first-session redesign can be validated locally,
/// plus a toggle for the opt-in demo seed and a reset.
class DebugFunnelScreen extends StatefulWidget {
  const DebugFunnelScreen({super.key});

  @override
  State<DebugFunnelScreen> createState() => _DebugFunnelScreenState();
}

class _DebugFunnelScreenState extends State<DebugFunnelScreen> {
  bool get _seedEnabled =>
      appPreferences?.getBool(debugSeedEnabledKey) ?? false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final counters = Telemetry.counters();
    final events = Telemetry.recentEvents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug · Funnel'),
        actions: [
          IconButton(
            tooltip: 'Reset telemetry',
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await Telemetry.reset();
              if (mounted) setState(() {});
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          SwitchListTile(
            value: _seedEnabled,
            title: const Text('Seed demo data on next launch'),
            subtitle: const Text(
              'Debug only. Off = honest clean-slate first run.',
            ),
            onChanged: (v) async {
              await appPreferences?.setBool(debugSeedEnabledKey, v);
              if (mounted) setState(() {});
            },
          ),
          const SizedBox(height: 16),
          _sectionLabel(theme, 'Counters (${counters.length})'),
          if (counters.isEmpty)
            _empty(theme, 'No events recorded yet.')
          else
            ...counters.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.key,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                    Text(
                      '${e.value}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
          _sectionLabel(theme, 'Recent events (${events.length})'),
          if (events.isEmpty)
            _empty(theme, 'No events yet.')
          else
            ...events.map((e) {
              final props = e['p'];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  '${e['e']}${props == null ? '' : '  $props'}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _sectionLabel(ThemeData theme, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        color: AppTheme.textSecondary,
        letterSpacing: 1,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  Widget _empty(ThemeData theme, String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
    ),
  );
}
