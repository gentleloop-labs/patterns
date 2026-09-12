import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../navigation/neutral_home_navigation.dart';
import 'platform.dart';

enum ActivityCompletionKind { journal, trackedMoment, compulsionDelay, erp }

class ActivityCompletionResult {
  final ActivityCompletionKind kind;
  final bool updated;

  const ActivityCompletionResult(this.kind, {this.updated = false});
}

Future<void> showQuietCompletion(
  BuildContext context,
  ActivityCompletionResult result,
) async {
  final strings = context.l10n;
  final title = switch (result.kind) {
    ActivityCompletionKind.journal ||
    ActivityCompletionKind.trackedMoment => strings.completionSavedTitle,
    ActivityCompletionKind.compulsionDelay ||
    ActivityCompletionKind.erp => strings.completionPracticeTitle,
  };
  final body = switch (result.kind) {
    ActivityCompletionKind.journal => strings.completionJournalBody,
    ActivityCompletionKind.trackedMoment =>
      result.updated
          ? strings.completionTrackedUpdatedBody
          : strings.completionTrackedBody,
    ActivityCompletionKind.compulsionDelay => strings.completionDelayBody,
    ActivityCompletionKind.erp => strings.completionErpBody,
  };

  final content = PopScope(
    canPop: false,
    child: Semantics(
      container: true,
      explicitChildNodes: true,
      scopesRoute: true,
      namesRoute: true,
      liveRegion: true,
      label: strings.completionAnnouncement(title, body),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ExcludeSemantics(
              child: Icon(Icons.check_circle_outline_rounded, size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(body, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(strings.doneForNowAction),
            ),
          ],
        ),
      ),
    ),
  );

  if (kIsDesktop) {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: content,
        ),
      ),
    );
  } else {
    await showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      builder: (_) => SafeArea(child: content),
    );
  }
}

/// Closes any full-screen activity route and asks the platform shell to select
/// its neutral Today/Home tab. Calling this after [showQuietCompletion]
/// preserves the already-saved data while giving the user a clear stopping
/// point.
void returnToNeutralHome(BuildContext context) {
  Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
  neutralHomeNavigation.request();
}
