import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../l10n/app_localizations_en.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

/// Stable content identifiers for the Y-BOCS-based self-check.
///
/// Presentation is resolved from generated localization resources. Scoring,
/// saved symptom IDs, saved category IDs, and historical assessments therefore
/// remain unchanged when the active language changes.

enum YbocsDimension { obsessions, compulsions }

class YbocsSeverityQuestion {
  final String id;
  final YbocsDimension dimension;

  const YbocsSeverityQuestion({required this.id, required this.dimension});

  String localizedPrompt(AppLocalizations strings) =>
      strings.ybocsQuestionPrompt(id);

  String localizedOption(AppLocalizations strings, int score) =>
      strings.ybocsQuestionOption('${id}_$score');

  String get prompt => localizedPrompt(AppLocalizationsEn());

  List<String> get options => [
    for (var score = 0; score <= 4; score++)
      localizedOption(AppLocalizationsEn(), score),
  ];
}

const ybocsSeverityQuestions = <YbocsSeverityQuestion>[
  YbocsSeverityQuestion(id: 'o_time', dimension: YbocsDimension.obsessions),
  YbocsSeverityQuestion(
    id: 'o_interfere',
    dimension: YbocsDimension.obsessions,
  ),
  YbocsSeverityQuestion(id: 'o_distress', dimension: YbocsDimension.obsessions),
  YbocsSeverityQuestion(id: 'o_resist', dimension: YbocsDimension.obsessions),
  YbocsSeverityQuestion(id: 'o_control', dimension: YbocsDimension.obsessions),
  YbocsSeverityQuestion(id: 'c_time', dimension: YbocsDimension.compulsions),
  YbocsSeverityQuestion(
    id: 'c_interfere',
    dimension: YbocsDimension.compulsions,
  ),
  YbocsSeverityQuestion(
    id: 'c_distress',
    dimension: YbocsDimension.compulsions,
  ),
  YbocsSeverityQuestion(id: 'c_resist', dimension: YbocsDimension.compulsions),
  YbocsSeverityQuestion(id: 'c_control', dimension: YbocsDimension.compulsions),
];

class YbocsSymptomItem {
  final String id;
  const YbocsSymptomItem(this.id);

  String localizedLabel(AppLocalizations strings) =>
      strings.ybocsSymptomLabel(id);

  String get label => localizedLabel(AppLocalizationsEn());
}

class YbocsSymptomCategory {
  final String id;
  final YbocsDimension kind;
  final List<YbocsSymptomItem> items;

  const YbocsSymptomCategory({
    required this.id,
    required this.kind,
    required this.items,
  });

  String localizedTitle(AppLocalizations strings) =>
      strings.ybocsCategoryTitle(id);

  String get title => localizedTitle(AppLocalizationsEn());
}

const ybocsCategories = <YbocsSymptomCategory>[
  YbocsSymptomCategory(
    id: 'aggressive',
    kind: YbocsDimension.obsessions,
    items: [
      YbocsSymptomItem('agg_harm_self'),
      YbocsSymptomItem('agg_harm_others'),
      YbocsSymptomItem('agg_violent'),
      YbocsSymptomItem('agg_blurt'),
      YbocsSymptomItem('agg_impulse'),
      YbocsSymptomItem('agg_responsible'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'contamination',
    kind: YbocsDimension.obsessions,
    items: [
      YbocsSymptomItem('con_dirt'),
      YbocsSymptomItem('con_bodily'),
      YbocsSymptomItem('con_chemicals'),
      YbocsSymptomItem('con_ill'),
      YbocsSymptomItem('con_spread'),
      YbocsSymptomItem('con_sticky'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'sexual',
    kind: YbocsDimension.obsessions,
    items: [
      YbocsSymptomItem('sex_forbidden'),
      YbocsSymptomItem('sex_others'),
      YbocsSymptomItem('sex_orientation'),
      YbocsSymptomItem('sex_aggressive'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'hoarding_obs',
    kind: YbocsDimension.obsessions,
    items: [YbocsSymptomItem('hoard_discard'), YbocsSymptomItem('hoard_value')],
  ),
  YbocsSymptomCategory(
    id: 'religious',
    kind: YbocsDimension.obsessions,
    items: [
      YbocsSymptomItem('rel_sacrilege'),
      YbocsSymptomItem('rel_rightwrong'),
      YbocsSymptomItem('rel_punish'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'symmetry_obs',
    kind: YbocsDimension.obsessions,
    items: [
      YbocsSymptomItem('sym_even'),
      YbocsSymptomItem('sym_exact'),
      YbocsSymptomItem('sym_incomplete'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'somatic',
    kind: YbocsDimension.obsessions,
    items: [YbocsSymptomItem('som_illness'), YbocsSymptomItem('som_body')],
  ),
  YbocsSymptomCategory(
    id: 'misc_obs',
    kind: YbocsDimension.obsessions,
    items: [
      YbocsSymptomItem('misc_know'),
      YbocsSymptomItem('misc_saywrong'),
      YbocsSymptomItem('misc_lucky'),
      YbocsSymptomItem('misc_sounds'),
      YbocsSymptomItem('misc_lose'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'washing',
    kind: YbocsDimension.compulsions,
    items: [
      YbocsSymptomItem('wash_hands'),
      YbocsSymptomItem('wash_shower'),
      YbocsSymptomItem('wash_clean'),
      YbocsSymptomItem('wash_avoid'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'checking',
    kind: YbocsDimension.compulsions,
    items: [
      YbocsSymptomItem('chk_locks'),
      YbocsSymptomItem('chk_harm'),
      YbocsSymptomItem('chk_mistake'),
      YbocsSymptomItem('chk_body'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'repeating',
    kind: YbocsDimension.compulsions,
    items: [
      YbocsSymptomItem('rep_reread'),
      YbocsSymptomItem('rep_routine'),
      YbocsSymptomItem('rep_untilright'),
    ],
  ),
  YbocsSymptomCategory(
    id: 'counting',
    kind: YbocsDimension.compulsions,
    items: [YbocsSymptomItem('cnt_count'), YbocsSymptomItem('cnt_numbers')],
  ),
  YbocsSymptomCategory(
    id: 'ordering',
    kind: YbocsDimension.compulsions,
    items: [YbocsSymptomItem('ord_arrange'), YbocsSymptomItem('ord_align')],
  ),
  YbocsSymptomCategory(
    id: 'misc_comp',
    kind: YbocsDimension.compulsions,
    items: [
      YbocsSymptomItem('mc_mental'),
      YbocsSymptomItem('mc_reassure'),
      YbocsSymptomItem('mc_touch'),
      YbocsSymptomItem('mc_lists'),
      YbocsSymptomItem('mc_avoid'),
    ],
  ),
];

YbocsSymptomCategory? ybocsCategoryFor(String id) {
  for (final category in ybocsCategories) {
    if (category.id == id) return category;
  }
  return null;
}

String? localizedYbocsCategoryTitleFor(String id, AppLocalizations strings) =>
    ybocsCategoryFor(id)?.localizedTitle(strings);

/// English compatibility for desktop code outside the 1.10 mobile gate.
String? ybocsCategoryTitleFor(String id) =>
    localizedYbocsCategoryTitleFor(id, AppLocalizationsEn());

extension YbocsSeverityDisplay on YbocsSeverity {
  String localizedLabel(AppLocalizations strings) => switch (this) {
    YbocsSeverity.subclinical => strings.ybocsSeveritySubclinical,
    YbocsSeverity.mild => strings.ybocsSeverityMild,
    YbocsSeverity.moderate => strings.ybocsSeverityModerate,
    YbocsSeverity.severe => strings.ybocsSeveritySevere,
    YbocsSeverity.extreme => strings.ybocsSeverityExtreme,
  };

  String localizedBlurb(AppLocalizations strings) =>
      strings.ybocsSeverityBlurb(name);

  String get label => localizedLabel(AppLocalizationsEn());

  String get range => switch (this) {
    YbocsSeverity.subclinical => '0–7',
    YbocsSeverity.mild => '8–15',
    YbocsSeverity.moderate => '16–23',
    YbocsSeverity.severe => '24–31',
    YbocsSeverity.extreme => '32–40',
  };

  String get blurb => localizedBlurb(AppLocalizationsEn());

  Color get color => switch (this) {
    YbocsSeverity.subclinical => const Color(0xFF6FBF73),
    YbocsSeverity.mild => const Color(0xFF9CCC65),
    YbocsSeverity.moderate => AppTheme.warmYellow,
    YbocsSeverity.severe => const Color(0xFFFFB74D),
    YbocsSeverity.extreme => const Color(0xFFE57373),
  };
}
