import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_preferences.dart';
import '../l10n/app_language.dart';
import '../l10n/app_localizations.dart';
import '../services/notification_service.dart';
import 'platform.dart';

Future<void> showAppLanguagePicker(BuildContext context, WidgetRef ref) async {
  final current = ref.read(languageProvider);
  final currentStrings = AppLocalizations.of(context);

  Widget buildPicker(BuildContext pickerContext) => SafeArea(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
      child: Semantics(
        namesRoute: true,
        label: currentStrings.languageTitle,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
              child: Text(
                currentStrings.languageTitle,
                style: Theme.of(
                  pickerContext,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            for (final language in availableAppLanguages)
              Semantics(
                selected: language == current,
                button: true,
                child: ListTile(
                  title: Text(
                    language == AppLanguage.system
                        ? currentStrings.systemDefault
                        : language.nativeName,
                  ),
                  trailing: language == current
                      ? const Icon(Icons.check_rounded)
                      : null,
                  selected: language == current,
                  onTap: () async {
                    await ref
                        .read(languageProvider.notifier)
                        .setLanguage(language);

                    final locale = resolveEffectiveLocale(
                      language,
                      WidgetsBinding.instance.platformDispatcher.locales,
                    );
                    final strings = await AppLocalizations.delegate.load(
                      locale,
                    );
                    final reminder = ref.read(reminderProvider);
                    if (reminder.enabled) {
                      await NotificationService.scheduleDailyReminder(
                        TimeOfDay(hour: reminder.hour, minute: reminder.minute),
                        strings: strings,
                      );
                    }

                    if (pickerContext.mounted) {
                      Navigator.pop(pickerContext);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    ),
  );

  if (kIsDesktop) {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: buildPicker(dialogContext),
        ),
      ),
    );
    return;
  }

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: buildPicker,
  );
}
