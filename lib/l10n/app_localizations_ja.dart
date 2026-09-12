// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Patterns';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsDataSection => 'データ';

  @override
  String get settingsExportDataTitle => 'データを書き出す';

  @override
  String get settingsExportDataSubtitle => '記録を端末内のJSONバックアップに保存します';

  @override
  String get settingsImportDataTitle => 'データを読み込む';

  @override
  String get settingsImportDataSubtitle => 'ZIPまたはJSONバックアップから記録を復元します';

  @override
  String get settingsRemindersSection => 'リマインダー';

  @override
  String get settingsDailyReminderTitle => '毎日のリマインダー';

  @override
  String settingsDailyReminderAt(String time) {
    return '$timeに穏やかにお知らせします';
  }

  @override
  String get settingsDailyReminderOff => '毎日の振り返りを穏やかにお知らせします';

  @override
  String get settingsReminderTimeTitle => 'リマインダーの時刻';

  @override
  String get settingsPrivacySection => 'プライバシー';

  @override
  String get settingsPrivacySafetySubtitle => '端末内のデータの取り扱いについて';

  @override
  String get settingsAnalyticsTitle => '匿名の利用状況を共有';

  @override
  String get settingsAnalyticsSubtitle => '機能の利用イベントのみを共有します。個人のOCDデータは含まれません。';

  @override
  String get settingsAppLockTitle => 'アプリロック';

  @override
  String get settingsAppLockSubtitle => 'Patternsを再度開くときに端末のロック解除を求めます';

  @override
  String get settingsWipeTitle => 'すべてのデータを消去';

  @override
  String get settingsWipeSubtitle => '端末内の記録を削除してアプリ設定をリセットします';

  @override
  String get settingsProSection => 'Patterns Pro';

  @override
  String get settingsProActiveTitle => 'Patterns Proは有効です';

  @override
  String get settingsProActiveSubtitle => 'すべての回復ツールを利用できます。ありがとうございます。';

  @override
  String get settingsUnlockProTitle => 'Patterns Proを利用する';

  @override
  String get settingsUnlockProSubtitle => '一度の購入ですべての回復ツールを利用できます';

  @override
  String get settingsRestorePurchasesTitle => '購入を復元';

  @override
  String get settingsRestorePurchasesSubtitle => '以前購入したPatterns Proを復元します';

  @override
  String get settingsHelpSection => 'ヘルプ';

  @override
  String get settingsReplayTourTitle => 'アプリツアーをもう一度見る';

  @override
  String get settingsReplayTourSubtitle => '各タブの役割をもう一度確認します';

  @override
  String get settingsShowWelcomeTitle => 'ようこそ画面を表示';

  @override
  String get settingsShowWelcomeSubtitle => '次にPatternsを開いたときに紹介画面を表示します';

  @override
  String get settingsFeedbackSection => 'フィードバック';

  @override
  String get settingsRateTitle => 'Patternsを評価';

  @override
  String get settingsRateSubtitle => 'App Storeで感想を共有してください';

  @override
  String get settingsSendFeedbackTitle => 'フィードバックを送信';

  @override
  String get settingsSendFeedbackSubtitle => 'アイデアや問題をお知らせください';

  @override
  String get settingsSupportTitle => 'Patternsを支援';

  @override
  String get settingsSupportSubtitle => '任意のチップで開発を支援できます';

  @override
  String get appearanceTitle => '外観';

  @override
  String get appearanceSystem => 'システム';

  @override
  String get appearanceLight => 'ライト';

  @override
  String get appearanceDark => 'ダーク';

  @override
  String get languageTitle => '言語';

  @override
  String get languageSubtitle => 'Patternsで使用する言語を選択';

  @override
  String get calmInsightsTitle => '穏やかなインサイト';

  @override
  String get calmInsightsSubtitle => '連続記録と計算スコアを非表示にします。記録したデータは引き続き確認できます。';

  @override
  String get calmRecentActivityTitle => '最近の記録';

  @override
  String get calmNoRecentActivity => '過去7日間の記録はありません。必要なときにいつでも始められます。';

  @override
  String calmJournalActivity(int count) {
    return '日記 $count件';
  }

  @override
  String calmTrackedActivity(int count) {
    return '記録した出来事 $count件';
  }

  @override
  String calmDelayActivity(int count) {
    return '強迫行為の延期 $count回';
  }

  @override
  String calmErpActivity(int count) {
    return 'ERP練習 $count回';
  }

  @override
  String calmExposureActivity(int count) {
    return '完了した曝露 $count回';
  }

  @override
  String get recoveryMetricsTitle => '回復アクティビティ';

  @override
  String get recoveryMetricsTeaserTitle => '回復アクティビティをまとめて確認';

  @override
  String get recoveryMetricsCalmTeaserBody =>
      'ERPツールで記録したエクスポージャー、練習セッション、衝動の変化を確認できます。Patterns Proで利用できます。';

  @override
  String get recoveryMetricsDetailedTeaserBody =>
      'ERPツールで練習の連続記録、完了したエクスポージャー、記録した衝動の変化を確認できます。Patterns Proで利用できます。';

  @override
  String get recoveryMetricsUnlockPro => 'Patterns Proを利用する';

  @override
  String get recoveryMetricsEmptyTitle => '回復アクティビティがここに表示されます';

  @override
  String get recoveryMetricsCalmEmptyBody =>
      '強迫行為の延期、ERPセッション、またはエクスポージャーのステップを練習すると、事実に基づく活動件数がここに表示されます。';

  @override
  String get recoveryMetricsDetailedEmptyBody =>
      '強迫行為の延期、ERPセッション、またはエクスポージャーのステップを練習すると、活動履歴と練習の連続記録が始まります。';

  @override
  String get recoveryMetricsExposuresDone => '完了したエクスポージャー';

  @override
  String get recoveryMetricsSessionsPracticed => '練習したセッション';

  @override
  String get recoveryMetricsAverageUrgeDrop => '記録した衝動の平均変化';

  @override
  String get recoveryMetricsThisWeek => '今週';

  @override
  String recoveryMetricsDayStreak(int days) {
    return '$days日連続';
  }

  @override
  String get systemDefault => 'システム設定';

  @override
  String get cancelAction => 'キャンセル';

  @override
  String get doneAction => '完了';

  @override
  String get doneForNowAction => '今はここまで';

  @override
  String get completionSavedTitle => '保存しました';

  @override
  String get completionPracticeTitle => '練習を記録しました';

  @override
  String get completionJournalBody => '日記をこのデバイスに保存しました。';

  @override
  String get completionTrackedBody => '記録した出来事をこのデバイスに保存しました。';

  @override
  String get completionTrackedUpdatedBody => '記録した出来事を更新しました。';

  @override
  String get completionDelayBody => '強迫行為を延期する練習を記録しました。';

  @override
  String get completionErpBody => 'ERP練習を記録しました。';

  @override
  String get notificationOpenAction => '通知を開く';

  @override
  String get dailyReminderChannelName => '毎日のリマインダー';

  @override
  String get dailyReminderChannelDescription =>
      'Patternsを静かに振り返るための毎日のリマインダーです。';

  @override
  String get dailyReminderTitle => '静かな振り返り';

  @override
  String get dailyReminderBody => '準備ができたときに、Patternsとともに穏やかな時間をお過ごしください。';

  @override
  String get practiceTimerChannelName => '練習タイマー';

  @override
  String get practiceTimerChannelDescription => '時間を決めた練習が終わったときに穏やかにお知らせします。';

  @override
  String get appUpdatesChannelName => 'アプリの更新';

  @override
  String get appUpdatesChannelDescription =>
      'Patternsに大切な新しい回復ツールが追加されたときにお知らせします。';

  @override
  String get updateAnnouncementTitle => 'Patternsがより良くなりました';

  @override
  String get updateAnnouncementBody =>
      '新しい回復ツール、進捗の振り返り、より穏やかなホーム画面をご利用いただけます。';

  @override
  String get practiceWindowCompleteTitle => '練習時間が終了しました';

  @override
  String get practiceWindowCompleteBody => '何が起きたかに気づく時間を取ってください。';

  @override
  String get erpWindowCompleteTitle => 'ERP練習時間が終了しました';

  @override
  String get erpWindowCompleteBody => '何が起きたかを振り返る時間を取ってください。';

  @override
  String get navToday => '今日';

  @override
  String get navHome => 'ホーム';

  @override
  String get navJournal => 'ジャーナル';

  @override
  String get navTrack => '記録';

  @override
  String get navTracker => 'トラッカー';

  @override
  String get navRecovery => '回復';

  @override
  String get navInsights => '分析';

  @override
  String get navSettings => '設定';

  @override
  String get exportReportTitle => 'レポートを書き出す';

  @override
  String get exportReportDescription =>
      'ジャーナル、OCD記録、分析を1つのPDFに保存します。保存先と共有するかどうかは自分で選べます。';

  @override
  String get exportTimeWindow => '期間';

  @override
  String get exportStart => '開始';

  @override
  String get exportEnd => '終了';

  @override
  String get exportIncludeSections => '含めるセクション';

  @override
  String get exportAnalyticsSummary => '分析の概要';

  @override
  String get exportJournalEntries => 'ジャーナル記録';

  @override
  String get exportOcdEvents => 'OCDイベント';

  @override
  String get exportYbocsSelfChecks => 'Y-BOCSセルフチェック';

  @override
  String exportEntrySummary(int total, int journal, int ocd, int selfChecks) {
    return 'この期間の記録：$total件（ジャーナル $journal件、OCD $ocd件、セルフチェック $selfChecks件）';
  }

  @override
  String get exportLargeReport => 'このレポートは大きいため、作成に少し時間がかかる場合があります。';

  @override
  String get exportPrivacyWarning => '暗号化されていないPDFが作成されます。安全な場所に保存してください。';

  @override
  String get exportSavePdf => 'PDFを保存';

  @override
  String get exportSelectSectionError => '書き出すセクションを1つ以上選択してください。';

  @override
  String get exportNoEntriesError => 'この期間とセクションに一致する記録はありません。';

  @override
  String get exportReportSaved => 'レポートを保存しました';

  @override
  String get exportReportFailed => 'レポートを作成できませんでした';

  @override
  String get rangeSevenDays => '7日';

  @override
  String get rangeThirtyDays => '30日';

  @override
  String get rangeNinetyDays => '90日';

  @override
  String get rangeYear => '1年';

  @override
  String get rangeAll => 'すべて';

  @override
  String get rangeCustom => 'カスタム';

  @override
  String get rangeLastSevenDays => '過去7日間';

  @override
  String get rangeLastThirtyDays => '過去30日間';

  @override
  String get rangeLastNinetyDays => '過去90日間';

  @override
  String get rangeLastYear => '過去1年間';

  @override
  String get rangeAllTime => '全期間';

  @override
  String get pdfPersonalReport => '個人レポート';

  @override
  String pdfGenerated(String date) {
    return '作成日時：$date';
  }

  @override
  String get pdfDisclaimer =>
      'このレポートには、自己理解のためにPatternsで作成した個人的な記録が含まれます。医療上の助言ではなく、資格を持つ専門家によるケアの代わりにはなりません。';

  @override
  String get pdfJournalCount => 'ジャーナル記録';

  @override
  String get pdfOcdCount => 'OCDイベント';

  @override
  String get pdfAverageDistress => '苦痛の平均';

  @override
  String get pdfObsessions => '強迫観念';

  @override
  String get pdfCompulsions => '強迫行為';

  @override
  String get pdfNoJournalEntries => 'この期間のジャーナル記録はありません。';

  @override
  String get pdfNoOcdEvents => 'この期間のOCDイベントはありません。';

  @override
  String get pdfObsession => '強迫観念';

  @override
  String get pdfCompulsion => '強迫行為';

  @override
  String pdfDistressScore(int score) {
    return '苦痛 $score/10';
  }

  @override
  String get pdfThought => '思考';

  @override
  String get pdfUrge => '衝動';

  @override
  String pdfResponse(String text) {
    return '対応：$text';
  }

  @override
  String pdfActionTaken(String text) {
    return '取った行動：$text';
  }

  @override
  String get pdfYbocsDescription =>
      'Yale-Brown Obsessive Compulsive Scaleをアプリ内で自己評価したものです。合計40点で、強迫観念と強迫行為はそれぞれ20点です。';

  @override
  String get pdfMostRecentTotal => '最新の合計';

  @override
  String get pdfTakenOn => '実施日';

  @override
  String get pdfObsessionsSubtotal => '強迫観念の小計';

  @override
  String get pdfCompulsionsSubtotal => '強迫行為の小計';

  @override
  String get pdfChangeAcrossRange => '期間内の変化';

  @override
  String get pdfSelfChecksInRange => '期間内のセルフチェック';

  @override
  String get pdfThemesFlagged => '選択したテーマ';

  @override
  String get pdfSingleSelfCheck => 'この期間のセルフチェックは1回です';

  @override
  String pdfChangeSince(String change, String date) {
    return '$dateから$change';
  }

  @override
  String get pdfDate => '日付';

  @override
  String get pdfTotal => '合計';

  @override
  String get pdfBand => '区分';

  @override
  String get severitySubclinical => '臨床域未満';

  @override
  String get severityMild => '軽度';

  @override
  String get severityModerate => '中等度';

  @override
  String get severitySevere => '重度';

  @override
  String get severityExtreme => '最重度';

  @override
  String get backAction => '戻る';

  @override
  String get onboardingSafetyFootnote =>
      'プライバシーを重視した設計です。診断や専門的なケアの代わりではありません。';

  @override
  String get onboardingHeadline => 'OCDと向き合うための静かな場所。';

  @override
  String get onboardingIntroduction => '侵入思考を記録し、強迫行為を遅らせ、少しずつ別の対応を練習します。';

  @override
  String get onboardingPrivacy => 'OCDデータはこの端末内に保存されます。アカウントもクラウド同期もありません。';

  @override
  String get getStartedAction => '始める';

  @override
  String get importExistingDataAction => '既存のデータを読み込む';

  @override
  String get onboardingQuestion => '今、何が役に立ちそうですか？';

  @override
  String get onboardingPickOne => '1つ選んでください。ほかはいつでも試せます。';

  @override
  String get onboardingUrgeTitle => '今、衝動と闘っている';

  @override
  String get onboardingUrgeSubtitle => '衝動と儀式の間に少し時間を置きます。';

  @override
  String get onboardingJournalTitle => '何かを書き留めたい';

  @override
  String get onboardingJournalSubtitle => '頭の中の考えをページに移します。';

  @override
  String get onboardingErpTitle => '強迫行為をしない練習をしたい';

  @override
  String get onboardingErpSubtitle => '短いガイド付きエクスポージャーです。';

  @override
  String get onboardingSelfCheckTitle => '今のOCDの状態を知りたい';

  @override
  String get onboardingSelfCheckSubtitle => 'Y-BOCSセルフチェック。約10分です。';

  @override
  String get onboardingExploreTitle => 'まずは見てみたい';

  @override
  String get onboardingExploreSubtitle => '最初にアプリ内を見て回ります。';

  @override
  String get whatsNewTitle => 'プレッシャーのない練習';

  @override
  String get whatsNewBody =>
      'Patterns 1.10では、穏やかなインサイト、静かなセッション終了、アクセシビリティの改善、任意の言語選択が加わりました。';

  @override
  String get whatsNewLanguagesTitle => '穏やかなインサイト';

  @override
  String get whatsNewLanguagesBody =>
      '計算されたスコア、連続記録、一貫性の割合の代わりに、事実に基づく活動概要を選べます。';

  @override
  String get whatsNewPrivateTitle => '明確な終了点';

  @override
  String get whatsNewPrivateBody =>
      '日記、記録、強迫行為の延期、ERPセッションは、事実に基づく確認と「今はここまで」で終了します。';

  @override
  String get whatsNewReportsTitle => 'より使いやすく、あなたの言語で';

  @override
  String get whatsNewReportsBody =>
      'ラベルと動きを抑える動作を改善し、英語、ブラジルポルトガル語、ドイツ語、日本語、スペイン語、フランス語に対応しました。';

  @override
  String get whatsNewExploreAction => 'Patterns 1.10を見る';

  @override
  String get continueToPatternsAction => 'Patternsに進む';

  @override
  String get whatsNewNotificationNote =>
      '入力内容はそのまま保持されます。言語と穏やかなインサイトの設定は端末内だけに保存され、分析やバックアップには含まれません。';

  @override
  String get formatBold => '太字';

  @override
  String get formatItalic => '斜体';

  @override
  String get formatBulletedList => '箇条書き';

  @override
  String get formatToggleHint => 'ダブルタップして、この書式をオンまたはオフにします。';

  @override
  String get journalEditorLabel => '日記エディター';

  @override
  String get journalEditorHint => '日記の文章を入力します。書式設定コントロールはエディターの後にあります。';

  @override
  String timerRemaining(String time) {
    return '残り時間：$time';
  }

  @override
  String recoveryScoreSemantics(int score) {
    return '回復スコア：100点中$score点。';
  }

  @override
  String get privacySafetyTitle => 'プライバシーと安全';

  @override
  String get privacyLocalContent => '日記、OCDの記録、苦痛度、振り返り、アプリ設定はこの端末内に保存されます。';

  @override
  String get privacyPurchases =>
      'Patterns Proとチップはアプリストアが処理します。Patternsが支払いカード情報を受け取ることはありません。';

  @override
  String get privacyExports =>
      '手動で書き出すと、暗号化されていないJSONバックアップまたはPDFレポートが、選択した保存先または共有先にのみ作成されます。';

  @override
  String get privacyAnalytics =>
      '匿名の利用状況分析は、あなたが有効にしない限りオフです。有効にすると、機能利用イベント、ランダムなインストールID、プラットフォーム、アプリのバージョン、イベント時刻が自社サービスに送信されます。日記、OCDデータ、生成した概要、地域設定、言語選択は含まれません。オフにすると、保留中のイベントと端末内の分析IDが削除されます。';

  @override
  String get privacyClinicalBoundary =>
      'Patternsは個人の振り返りとERP練習のためのセルフヘルプツールです。OCDの診断や治療、専門家によるケアの代替、緊急支援は提供しません。';

  @override
  String get viewPrivacyPolicyAction => 'プライバシーポリシーを表示';

  @override
  String get closeAction => '閉じる';

  @override
  String get proPaywallTitle => 'Patterns Pro';

  @override
  String get proPaywallIncludedTools => '計画、練習、指標、振り返りのすべてのProツールも含まれます。';

  @override
  String get proPaywallAlreadyPurchased => 'すでにProを購入済みですか？再度請求されることはありません。';

  @override
  String get proPaywallTryAgainAction => 'もう一度試す';

  @override
  String get proPaywallRestorePurchasesAction => '購入を復元';

  @override
  String get proPaywallRestoreShortAction => '復元';

  @override
  String get proPaywallUnlockAction => 'Proをアンロック';

  @override
  String proPaywallUnlockWithPrice(String price) {
    return 'Proをアンロック · $price';
  }

  @override
  String get proPaywallPurchasesUnavailable => 'このデバイスではアプリ内購入を利用できません。';

  @override
  String get proPaywallProductUnavailable =>
      '現在Patterns Proを利用できません。しばらくしてからもう一度お試しください。';

  @override
  String get proPaywallProductLoadFailed =>
      'Patterns Proを読み込めませんでした。しばらくしてからもう一度お試しください。';

  @override
  String get proPaywallPurchaseStartFailed => '購入を開始できませんでした。';

  @override
  String get proPaywallPurchaseFailed => '購入を完了できませんでした。もう一度お試しください。';

  @override
  String get proPaywallRestoreNotFound =>
      'このアカウントでは以前の購入が見つかりませんでした。別のアカウントでProを購入した場合は、そのアカウントでサインインしてもう一度お試しください。';

  @override
  String get proPaywallRestoreFailed => '購入を復元できませんでした。もう一度お試しください。';

  @override
  String get proPaywallWelcomeBack => 'おかえりなさい';

  @override
  String get proPaywallAllSet => '準備ができました';

  @override
  String get proPaywallRestoredBody => 'このデバイスでPatterns Proを復元しました。';

  @override
  String get proPaywallUnlockedBody =>
      'Patterns Proをアンロックしました。すべてのリカバリーツールを利用できます。';

  @override
  String get proPaywallContinueAction => '続ける';

  @override
  String get proPaywallLoadingLabel => 'Patterns Proを読み込み中';

  @override
  String get proHeadlineSettings => '記録から一歩進み、リカバリーを練習する';

  @override
  String get proHeadlineTodayNextStep => '今日の練習を続ける';

  @override
  String get proHeadlineRecoveryMetrics => 'リカバリー活動を確認する';

  @override
  String get proHeadlineExposureHierarchy => '明確なエクスポージャー階層を作る';

  @override
  String get proHeadlineExposureMaterials => '練習用の資料をまとめておく';

  @override
  String get proHeadlineStructuredPrograms => 'リカバリーを日課にする';

  @override
  String get proHeadlineActionPlanner => 'OCDが現れる前に対応を計画する';

  @override
  String get proHeadlineImplementationIntentions => '次の選択をしやすくする';

  @override
  String get proHeadlineUrgeSurfing => '衝動の波が過ぎるのを待つ練習をする';

  @override
  String get proHeadlineResponsePrevention => '選んだ対応を記録する';

  @override
  String get proHeadlineUncertaintyTraining => '「かもしれない」を受け入れる練習をする';

  @override
  String get proHeadlineBehavioralExperiments => 'OCDの予測を確かめる';

  @override
  String get proHeadlineReflectionJournal => '練習で学んだことを記録する';

  @override
  String get proBenefitGeneralPlans => 'エクスポージャー階層と練習計画を作る';

  @override
  String get proBenefitGeneralResponsePrevention => '反応妨害に特化したツールを使う';

  @override
  String get proBenefitGeneralReview => 'リカバリー活動と振り返りを確認する';

  @override
  String get proBenefitMetricsActivity => '練習活動を時系列で確認する';

  @override
  String get proBenefitMetricsNonjudgmental => '一日ごとに評価せず、記録された活動を確認する';

  @override
  String get proBenefitMetricsPatterns => '事実に基づくリカバリーの傾向を確認する';

  @override
  String get proBenefitExposureLadder => '取り組みやすいものから難しいものへ並べる';

  @override
  String get proBenefitExposureMaterials => 'スクリプト、ループ音声、画像、リンクをすぐ使えるようにする';

  @override
  String get proBenefitExposureRepeatable => '計画を繰り返せる練習にする';

  @override
  String get proBenefitProgramsStructure => '落ち着いた週ごとの流れに沿って進める';

  @override
  String get proBenefitProgramsTasks => '練習課題を一か所にまとめる';

  @override
  String get proBenefitProgramsReview => '続ける中で役立ったことを確認する';

  @override
  String get proBenefitPlanningAhead => '難しい場面の前に対応を選ぶ';

  @override
  String get proBenefitPlanningIfThen => '実用的な「もし〜なら」計画を作る';

  @override
  String get proBenefitPlanningReturn => '不確かさが強まったときに計画へ戻る';

  @override
  String get proBenefitInMomentTools => 'その場で集中して使える練習ツールを使う';

  @override
  String get proBenefitInMomentPrivacy => 'センシティブな詳細を書かずに選択を記録する';

  @override
  String get proBenefitInMomentRepetition => '繰り返せる練習で耐える力を育てる';

  @override
  String get proBenefitReflectionCompare => '予測と実際に起きたことを比べる';

  @override
  String get proBenefitReflectionCapture => '練習後の学びを記録する';

  @override
  String get proBenefitReflectionPatterns => '時間の中で役立つ傾向に気づく';

  @override
  String get proRestoreChecking => '購入を確認しています…';

  @override
  String get proRestoreSucceeded =>
      'Patterns Proを復元しました。すべてのリカバリーツールを再び利用できます。';

  @override
  String get tipJarTitle => 'Patternsを支援';

  @override
  String get tipJarBody =>
      'Patternsは独立して運営され、広告はありません。役に立ったと感じた場合は、少額のチップで支援できます。チップは任意で、機能が追加されることはありません。';

  @override
  String get tipJarLoadingLabel => 'チップの選択肢を読み込み中';

  @override
  String get tipJarPurchasesUnavailable => 'このデバイスではアプリ内購入を利用できません。';

  @override
  String get tipJarOptionsUnavailable =>
      'チップの選択肢が見つかりませんでした。しばらくしてからもう一度お試しください。';

  @override
  String get tipJarLoadFailed => 'チップの選択肢を読み込めませんでした。しばらくしてからもう一度お試しください。';

  @override
  String get tipJarPurchaseFailed => 'チップを完了できませんでした。もう一度お試しください。';

  @override
  String get tipJarTryAgainAction => 'もう一度試す';

  @override
  String get tipSmallTitle => '小さなチップ';

  @override
  String get tipSmallDescription => 'Patternsの開発を支援する任意の小さなチップです。機能は追加されません。';

  @override
  String get tipMediumTitle => '中くらいのチップ';

  @override
  String get tipMediumDescription => 'Patternsの開発を支援する任意のチップです。機能は追加されません。';

  @override
  String get tipLargeTitle => '大きなチップ';

  @override
  String get tipLargeDescription => 'Patternsの開発を支援する任意の大きなチップです。機能は追加されません。';

  @override
  String tipChoiceSemantics(String title, String price, String description) {
    return '$title、$price。$description';
  }

  @override
  String get tipChoiceHint => 'この任意のチップを送ります';

  @override
  String get tipThanksTitle => 'ありがとうございます';

  @override
  String get tipThanksBody =>
      'ご支援に感謝します。皆さまの支援により、Patternsは広告なしで独立した運営を続けられます。';

  @override
  String get tipThanksAction => 'どういたしまして';

  @override
  String get desktopProTitle => 'Patterns Desktop Proをアンロック';

  @override
  String get desktopProSubtitle => 'オフラインで使えるデスクトップ向けリカバリーツールの買い切りライセンスです。';

  @override
  String get desktopFeatureHierarchyTitle => '階層ビルダー';

  @override
  String get desktopFeatureHierarchyDescription => 'エクスポージャーの段階と階層を作成して記録します。';

  @override
  String get desktopFeatureErpTitle => 'ERP練習ログ';

  @override
  String get desktopFeatureErpDescription => '反応妨害と時間を決めた練習を記録します。';

  @override
  String get desktopFeatureUrgeTitle => 'Urge Surfing';

  @override
  String get desktopFeatureUrgeDescription => 'ライブタイマーで衝動の変化を記録します。';

  @override
  String get desktopFeatureActivityTitle => 'リカバリー活動';

  @override
  String get desktopFeatureActivityDescription => '事実に基づく活動と週ごとの傾向を確認します。';

  @override
  String get desktopOneTimeLicense => '買い切りライセンス';

  @override
  String desktopOneTimePrice(String price) {
    return '$price、買い切り';
  }

  @override
  String get desktopPurchaseLicenseAction => 'ライセンスを購入';

  @override
  String get desktopCheckoutUnavailable => 'このビルドでは購入ページを利用できません。';

  @override
  String get desktopAlreadyPurchased => '購入済みですか？ライセンスキーを入力してください';

  @override
  String get desktopLicensePrompt => 'Lemon Squeezyのライセンスキーを入力：';

  @override
  String get desktopLicenseLabel => 'ライセンスキー';

  @override
  String get desktopLicenseHint => '領収書に記載されたライセンスキーを貼り付ける';

  @override
  String get desktopLicenseActivating => 'ライセンスを有効化しています…';

  @override
  String get desktopActivateLicenseAction => 'ライセンスを有効化';

  @override
  String get desktopLicenseBackAction => '戻る';

  @override
  String get desktopLicenseInvalid => '領収書に記載された完全なライセンスキーを入力してください。';

  @override
  String get desktopLicenseRejected =>
      'Patterns Desktop Proのライセンスとして確認できませんでした。キーを確認してもう一度お試しください。';

  @override
  String get desktopLicenseUnavailable =>
      'ライセンスサービスに接続できませんでした。接続を確認してもう一度お試しください。';

  @override
  String get desktopLicenseNotConfigured => 'このビルドではライセンスを有効化できません。';

  @override
  String get journalTitle => 'ジャーナル';

  @override
  String get journalSearchAction => 'ジャーナルを検索';

  @override
  String get journalChooseDateAction => '日付を選択';

  @override
  String get journalSearchHint => 'エントリーを検索';

  @override
  String get journalClearSearchAction => '検索を消去';

  @override
  String get journalNoMatchesTitle => '一致する項目はありません';

  @override
  String journalNoMatchesBody(String query) {
    return '「$query」に一致するエントリーはありません。';
  }

  @override
  String get journalEmptyTitle => 'ジャーナルのエントリーはまだありません';

  @override
  String get journalEmptyBody => 'まずは数行、静かに書くことから始められます。';

  @override
  String get journalLoadError => 'ジャーナルを読み込めませんでした。もう一度お試しください。';

  @override
  String get journalLoadingLabel => 'ジャーナルのエントリーを読み込み中';

  @override
  String get journalSavingStatus => '保存中…';

  @override
  String get journalSavedStatus => '保存済み';

  @override
  String get journalUnsavedStatus => '未保存';

  @override
  String get journalClearDayAction => 'この日の記録を消去';

  @override
  String get journalSaveAction => '保存';

  @override
  String get journalStartWritingPlaceholder => '書き始める…';

  @override
  String get journalFormatSelectionHint => '書式を設定するテキストを選択';

  @override
  String get journalClearedMessage => 'この日の記録を消去しました。';

  @override
  String get journalNothingToSaveMessage =>
      'まだ保存する内容がありません。書けそうなときに、一行から始めてください。';

  @override
  String get journalClearDayTitle => 'この日の記録を消去しますか？';

  @override
  String journalClearDayBody(String date) {
    return '$dateに保存された内容をすべて消去します。後からいつでも、この日にもう一度書くことができます。';
  }

  @override
  String get journalKeepEntryAction => '残す';

  @override
  String get journalTodayEntry => '今日のエントリー';

  @override
  String get journalOpenEntryAction => 'エントリーを開く';

  @override
  String journalOpenEntryHint(String date) {
    return '$dateのジャーナルエントリーを開きます。';
  }

  @override
  String get journalWorkspaceTitle => 'ジャーナルワークスペース';

  @override
  String get journalSubtitle => '振り返り、気持ちを書き出すための場所です。';

  @override
  String get journalNewEntryAction => '新しいエントリー';

  @override
  String get journalEarlierSection => '以前';

  @override
  String get journalNoEntryForDate => 'この日付のエントリーはありません。';

  @override
  String get journalCreateEntryAction => 'エントリーを作成';

  @override
  String journalEntryTimestamp(String date, String time) {
    return '$date $time';
  }

  @override
  String get journalDeleteEntryAction => 'エントリーを削除';

  @override
  String get journalDeleteEntryTitle => 'エントリーを削除しますか？';

  @override
  String get journalDeleteEntryBody => 'このジャーナルエントリーは完全に削除されます。';

  @override
  String get journalDeletedMessage => 'ジャーナルエントリーを削除しました。';

  @override
  String get journalEditAction => '編集';

  @override
  String journalEditingDate(String date) {
    return '編集中：$date';
  }

  @override
  String get journalUnsavedChangesStatus => '未保存の変更';

  @override
  String get journalEntrySavedMessage => 'ジャーナルエントリーを保存しました';

  @override
  String journalReadOnlyLabel(String date) {
    return '$dateの読み取り専用ジャーナルエントリー';
  }

  @override
  String get journalThemeContamination => '汚染';

  @override
  String get journalThemeUncertainty => '不確かさ';

  @override
  String get journalThemeChecking => '確認';

  @override
  String get journalThemeRelationship => '人間関係';

  @override
  String get journalThemeHealth => '健康';

  @override
  String get todayGreetingMorning => 'おはようございます';

  @override
  String get todayGreetingAfternoon => 'こんにちは';

  @override
  String get todayGreetingEvening => 'こんばんは';

  @override
  String get todayEncouragement => '一度にひとつ、選んでいきましょう。';

  @override
  String get todayContinuePractice => '練習を続ける';

  @override
  String get todaySeeAllAction => 'すべて見る';

  @override
  String get todayQuickActions => 'クイックアクション';

  @override
  String get todayChooseActivity => '何をしますか？';

  @override
  String get todayWriteSomethingTitle => '書き留める';

  @override
  String get todayWriteSomethingBody => '頭に浮かんだことを文字にしてみましょう。';

  @override
  String get todayDelayUrgeTitle => '衝動への反応を遅らせる';

  @override
  String get todayDelayUrgeBody => '反応する前に少し間を置きます。';

  @override
  String get todayPracticeErpTitle => '練習する（ERP）';

  @override
  String get todayPracticeErpBody => '短いガイド付きエクササイズです。';

  @override
  String get todayFirstJournalTitle => '別の場面を書き留める';

  @override
  String get todayFirstJournalBody => '考えに名前を付けると、観察しやすくなることがあります。';

  @override
  String get todayFirstErpTitle => 'もう一度練習する';

  @override
  String get todayFirstErpBody => '別の短いガイド付きERP練習を試します。';

  @override
  String get todayFirstDelayTitle => '2分間遅らせてみる';

  @override
  String get todayFirstDelayBody => '衝動が強いとき、行動する前に少し間を置きます。';

  @override
  String get todayStartPracticeAction => '練習を始める';

  @override
  String get todayStartDelayAction => '遅延を始める';

  @override
  String get todayProTitle => 'Patterns Proで続ける';

  @override
  String get todayProBody => '計画を立て、練習し、時間の経過とともに活動を振り返ります。';

  @override
  String get todayHideSevenDays => '7日間非表示';

  @override
  String get todayPracticeProgress => '練習の推移';

  @override
  String get todaySteadyPractice => '継続した練習';

  @override
  String get todayStartGently => 'ゆっくり始める';

  @override
  String get todayPracticeActiveBody => '記録した活動から、長期的な様子が少しずつ見えてきます。';

  @override
  String get todayPracticeEmptyBody => 'ジャーナル、記録、練習に応じて変化します。';

  @override
  String get todayProgressDisclaimer =>
      'これは記録された練習頻度を示すもので、診断や臨床評価ではありません。困難な週には数値が低くなることがあります。';

  @override
  String get todayProgressStartedTitle => '活動の記録がまとまり始めています';

  @override
  String get todayProgressPendingBody => '複数の日に活動が記録されると、推移の数値が表示されます。';

  @override
  String get todayScoreNew => '新規';

  @override
  String get todayScoreStrong => '多い';

  @override
  String get todayScoreSteady => '安定';

  @override
  String get todayScoreBuilding => '蓄積中';

  @override
  String get todayScoreStarting => '開始';

  @override
  String get todayBeginCheckIn => '短いチェックインから始める';

  @override
  String get todayNoChange => '前の期間から変化はありません';

  @override
  String todayPointsUp(int points) {
    return '前の期間より$pointsポイント増加';
  }

  @override
  String todayPointsDown(int points) {
    return '前の期間より$pointsポイント減少';
  }

  @override
  String get todayNextStep => '次のステップ';

  @override
  String get todayNextSelfCheckTitle => '現在の状態を記録する';

  @override
  String get todayNextSelfCheckBody => 'セルフチェックで、後から比較するための基準を記録できます。';

  @override
  String get todayNextSelfCheckAction => 'セルフチェックを行う';

  @override
  String get todayNextHierarchyTitle => '練習を準備する';

  @override
  String get todayNextHierarchyBody => '取り組みやすい段階から難しい段階へ、曝露の階層を作ります。';

  @override
  String get todayNextHierarchyAction => '階層を作る';

  @override
  String get todayNextPracticeTitle => '今日の練習を選ぶ';

  @override
  String get todayNextPracticeBody => '今日取り組めるERPエクササイズをひとつ選びます。';

  @override
  String get todayNextPracticeAction => '練習を始める';

  @override
  String get todayNextReflectTitle => '練習を振り返る';

  @override
  String get todayNextReflectBody => '今日の練習中に気づいたことを記録します。';

  @override
  String get todayNextReflectAction => '振り返る';

  @override
  String get todayNextJournalTitle => '今日を振り返る';

  @override
  String get todayNextJournalBody => '練習で気づいたことを一行書きます。';

  @override
  String get todayNextJournalAction => 'ジャーナルを開く';

  @override
  String get todayCompulsionDelay => '強迫行為の遅延';

  @override
  String get todayStartErp => 'ERP練習を始める';

  @override
  String get todayResistUrgeBody => '何をするか決める前に、衝動とともに少し待ちます。';

  @override
  String get todayBuildToleranceBody => '自分のペースで取り組める段階を練習します。';

  @override
  String get todayResumeAction => '再開';

  @override
  String get todayStartAction => '開始';

  @override
  String get todayJournalBody => 'プライベートなジャーナルに書いて振り返ります。';

  @override
  String get todayExposureTools => '曝露ツール';

  @override
  String get todayExposureToolsBody => '階層、素材、不確かさの練習。';

  @override
  String get todayInsightsBody => '記録した活動を振り返ります。';

  @override
  String get todaySelfCheckTitle => '自分のパターンを理解する';

  @override
  String get todaySelfCheckDuration => '任意 · 約10分';

  @override
  String get todayInsightsPlaceholder => '活動を記録すると、ここにインサイトが表示されます。';

  @override
  String get todayDailyCheckInComplete => '今日のチェックインを記録済み';

  @override
  String get todayDailyCheckIn => '今日のチェックイン';

  @override
  String get todayDailyCompleteBody => '今日のジャーナルエントリーが記録されています。';

  @override
  String get todayDailyBody => '準備ができたら、短いジャーナルを書きます。';

  @override
  String get todayOpenAction => '開く';

  @override
  String get todayCheckInAction => '記録する';

  @override
  String get todayRecoveryScore => '回復スコア';

  @override
  String todayActivitiesLastSevenDays(int count) {
    return '過去7日間の活動：$count件';
  }

  @override
  String get todayActivityRecorded => '記録した活動から算出';

  @override
  String get todayPracticesRecorded => '記録した練習';

  @override
  String get todayPracticeStreak => '連続練習';

  @override
  String todaySessionsCount(int count) {
    return '$countセッション';
  }

  @override
  String todayDaysCount(int count) {
    return '$count日';
  }

  @override
  String get todayPickUpBody => '以前に記録した時間から続けます。';

  @override
  String get todayPracticeUrgesBody => '衝動に反応する前に待つ練習をします。';

  @override
  String get todayReadCheckIn => '今日のチェックインを読む';

  @override
  String get todayOpenJournalMore => 'ジャーナルを開いて読む、または追記する';

  @override
  String get todayShortJournal => '短いジャーナルエントリーを書く';

  @override
  String get todayExplore => '見る';

  @override
  String get todayReflectProcess => '書いて振り返る';

  @override
  String get todayRecoveryTools => '回復ツール';

  @override
  String get todaySupportPractice => '練習を支える';

  @override
  String get todayTrackBody => '考えや衝動を記録する';

  @override
  String get todaySeePatterns => '記録したパターンを見る';

  @override
  String todayScoreA11y(int score, String label) {
    return '練習の推移：100点中$score、$label';
  }

  @override
  String todayTimerA11y(String elapsed, String planned) {
    return '練習タイマー：$plannedのうち$elapsed経過';
  }

  @override
  String todayDayActiveA11y(String day) {
    return '$day：活動を記録済み';
  }

  @override
  String todayDayInactiveA11y(String day) {
    return '$day：活動の記録なし';
  }

  @override
  String get trackerTitle => '記録';

  @override
  String get trackerPauseUrgeAction => '反応する前に少し待つ';

  @override
  String get trackerFilterGroupLabel => '記録した出来事を絞り込む';

  @override
  String get trackerFilterAll => 'すべて';

  @override
  String get trackerFilterObsessions => '強迫観念';

  @override
  String get trackerFilterCompulsions => '強迫行為';

  @override
  String get trackerLoadingLabel => '記録した出来事を読み込んでいます';

  @override
  String get trackerLoadError => '記録した出来事を読み込めませんでした。もう一度お試しください。';

  @override
  String get trackerEditTitle => '出来事を編集';

  @override
  String get trackerAddTitle => '出来事を記録';

  @override
  String get trackerTypeGroupLabel => '出来事の種類';

  @override
  String get trackerTypeObsession => '強迫観念';

  @override
  String get trackerTypeCompulsion => '強迫行為';

  @override
  String get trackerThoughtLabel => 'その考えは何と言っていましたか？';

  @override
  String get trackerUrgeLabel => 'どのような衝動でしたか？';

  @override
  String get trackerThoughtHint => '考えやイメージを書いてください。';

  @override
  String get trackerUrgeHint => '衝動や強迫行為を書いてください。';

  @override
  String get trackerActionLabel => 'OCDによって何をしたくなりましたか？';

  @override
  String get trackerActionHint => '短いメモで十分です。';

  @override
  String get trackerResponseLabel => '代わりに行ったこと';

  @override
  String get trackerResponseHint => '一部だけ待てた場合も含め、選んだ対応を記録してください。';

  @override
  String get trackerSavingAction => '保存中…';

  @override
  String get trackerUpdateAction => '出来事を更新';

  @override
  String get trackerSaveAction => '出来事を保存';

  @override
  String get trackerContentRequired => '準備ができたら、何があったかを少し書いてください。';

  @override
  String get trackerSaveError => '出来事を保存できませんでした。もう一度お試しください。';

  @override
  String get trackerUpdateError => '出来事を更新できませんでした。もう一度お試しください。';

  @override
  String get trackerEditTooltip => '出来事を編集';

  @override
  String get trackerDeleteTooltip => '出来事を削除';

  @override
  String trackerDistressValue(int value) {
    return '苦痛度$value/10';
  }

  @override
  String trackerDistressShortValue(int value) {
    return '$value/10';
  }

  @override
  String get trackerNoStrategy => '対応の記録なし';

  @override
  String trackerEventSummary(
    String type,
    String date,
    int distress,
    String content,
    String response,
  ) {
    return '$type。$date。苦痛度$distress/10。$content。対応：$response';
  }

  @override
  String get trackerDeleteTitle => '出来事を削除しますか？';

  @override
  String get trackerDeleteBody => 'この端末のローカル履歴から出来事が削除されます。';

  @override
  String get trackerDeleteAction => '削除';

  @override
  String get trackerDeletedMessage => '出来事を削除しました';

  @override
  String get trackerDeleteError => '出来事を削除できませんでした。もう一度お試しください。';

  @override
  String get trackerDistressLabel => '苦痛度、0から10';

  @override
  String get trackerEmptyTitle => 'まだ出来事はありません';

  @override
  String get trackerEmptyBody => '役立つと感じることだけを記録してください。短いメモで十分です。';

  @override
  String get trackerEmptyAction => 'OCDの出来事を記録';

  @override
  String get insightsTitle => 'インサイト';

  @override
  String get insightsExportReport => 'レポートを書き出す';

  @override
  String get insightsObsessionsLogged => '記録した強迫観念';

  @override
  String get insightsThemesFound => '見つかったテーマ';

  @override
  String get insightsCompulsions => '強迫行為';

  @override
  String get insightsAverageIntensityShort => '平均強度';

  @override
  String get insightsOutOfTenShort => '/10';

  @override
  String get insightsPracticeProgress => '練習の経過';

  @override
  String get insightsScoreNeedsMoreActivity =>
      '単一の出来事ではなく経過を示すため、複数の日に数回練習するとスコアが表示されます。下のセッションはすでに数えられています。';

  @override
  String get insightsScoreEmpty => '数回練習すると、ここにスコアが表示されます。今はまだ測るものがありません。';

  @override
  String insightsComparedPreviousDays(int count) {
    return '直前の$count日間との比較';
  }

  @override
  String get insightsComparedPreviousRange => '前の期間との比較';

  @override
  String get insightsPracticeProgressBoundary =>
      '練習の頻度を表すもので、診断や臨床的な状態を示すものではありません。つらい週に数値が低くなることもあります。';

  @override
  String get insightsMoodOverTime => '気分の推移';

  @override
  String get insightsMoodGood => '良い';

  @override
  String get insightsMoodOkay => '普通';

  @override
  String get insightsMoodLow => '低い';

  @override
  String get insightsYbocsOverTime => 'Y-BOCSの推移';

  @override
  String get insightsYbocsEmpty => 'セルフチェックを行うと、記録した合計点がここから線になります。';

  @override
  String get insightsOutOfFortyShort => '/40';

  @override
  String insightsYbocsSingleResult(String severity) {
    return '$severityの範囲です。数週間後にもう一度セルフチェックを行うと、記録点が追加されます。';
  }

  @override
  String insightsYbocsSeverityRange(String severity, String range) {
    return '$severity（$range）';
  }

  @override
  String insightsAcrossSelfChecks(int count) {
    return '$count回のセルフチェックでの比較';
  }

  @override
  String get insightsYbocsBoundary =>
      'これは一時点の記録であり、診断ではありません。合計点は変動することがあり、1回高くても経過全体を決めるものではありません。';

  @override
  String get insightsAverageUrgeIntensity => '衝動の平均強度';

  @override
  String get insightsErpPractice => 'ERP練習';

  @override
  String insightsSessions(int count) {
    return 'セッション';
  }

  @override
  String get insightsConsistency => '継続性';

  @override
  String insightsActiveDays(int active, int total) {
    return '$total日中$active日';
  }

  @override
  String insightsActivityMapSummary(int active, int total) {
    return '$total日中$active日に活動を記録';
  }

  @override
  String get insightsTopThemes => '主なテーマ';

  @override
  String get insightsThemesEmpty => 'OCDが何に集中しているかを記録すると、テーマが表示されます。';

  @override
  String insightsThemeShare(String theme, int percent) {
    return '$theme、記録したテーマの$percentパーセント';
  }

  @override
  String get insightsChangeRange => '期間を変更';

  @override
  String get insightsOverviewTab => '概要';

  @override
  String get insightsObsessionsTab => '強迫観念';

  @override
  String get insightsCompulsionsTab => '強迫行為';

  @override
  String get insightsErpTab => 'ERP';

  @override
  String insightsDeltaIncrease(String value, String comparison) {
    return '↑ $value増加、$comparison';
  }

  @override
  String insightsDeltaDecrease(String value, String comparison) {
    return '↓ $value減少、$comparison';
  }

  @override
  String insightsDeltaUnchanged(String comparison) {
    return '→ 変化なし、$comparison';
  }

  @override
  String get insightsNoData => 'まだデータはありません';

  @override
  String get insightsLoading => 'インサイトを読み込んでいます';

  @override
  String get insightsLoadError => 'インサイトを読み込めませんでした。もう一度お試しください。';

  @override
  String insightsChartPoint(String date, String value) {
    return '$date：$value';
  }

  @override
  String insightsChartSummary(String title, String values) {
    return '$title。記録点：$values';
  }

  @override
  String get ybocsSeveritySubclinical => '臨床閾値未満';

  @override
  String get ybocsSeverityMild => '軽度';

  @override
  String get ybocsSeverityModerate => '中等度';

  @override
  String get ybocsSeveritySevere => '重度';

  @override
  String get ybocsSeverityExtreme => '極めて重度';

  @override
  String get insightsThemeContamination => '汚染';

  @override
  String get insightsThemeHarm => '加害';

  @override
  String get insightsThemeChecking => '確認';

  @override
  String get insightsThemeReassurance => '安心の確認';

  @override
  String get insightsThemeHealth => '健康';

  @override
  String get insightsThemeRelationship => '人間関係';

  @override
  String get insightsThemeSymmetry => '対称性';

  @override
  String get insightsThemeMoral => '道徳';

  @override
  String get insightsThemeRumination => '反すう';

  @override
  String get insightsThemeUncertainty => '不確かさ';

  @override
  String get insightsThemeOther => 'その他';

  @override
  String get recoveryTitle => '回復';

  @override
  String get recoverySubtitle => '今取り組んでいる段階に合わせて、ツールと練習をまとめています。';

  @override
  String get recoveryImmediateHelpTitle => 'つらい時のサポート';

  @override
  String recoveryToolTitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': 'つらい時のツールキット',
      'copingLibrary': '対処法ライブラリ',
      'compulsionDelay': '強迫行為を待つ',
      'ybocsSelfCheck': 'OCDセルフチェック',
      'recoveryMetrics': '回復の記録',
      'exposureHierarchy': '曝露の段階表',
      'exposureMaterials': '曝露の素材',
      'structuredPrograms': '構造化プログラム',
      'actionPlanner': '行動プラン',
      'implementationIntentions': 'もし〜ならプラン',
      'guidedErp': 'ガイド付きERP',
      'urgeSurfing': '衝動の波に乗る',
      'responsePrevention': '反応妨害',
      'uncertaintyTraining': '不確かさの練習',
      'behavioralExperiments': '行動実験',
      'reflectionJournal': '振り返り日記',
      'other': '回復ツール',
    });
    return '$_temp0';
  }

  @override
  String recoveryToolSubtitle(String tool) {
    String _temp0 = intl.Intl.selectLogic(tool, {
      'emergencyToolkit': '今ここに戻るための短いサポート。',
      'copingLibrary': '落ち着いて、いったん整える。',
      'compulsionDelay': '反応する前に間をつくる。',
      'ybocsSelfCheck': 'Y-BOCSのチェックイン。',
      'recoveryMetrics': '記録した活動を確認する。',
      'exposureHierarchy': '段階表をつくる。',
      'exposureMaterials': 'スクリプトやリンクをまとめる。',
      'structuredPrograms': '週ごとのガイドに沿う。',
      'actionPlanner': '対応を先に決める。',
      'implementationIntentions': 'もし〜ならプランをつくる。',
      'guidedErp': 'プランを練習する。',
      'urgeSurfing': '波が過ぎるのを見守る。',
      'responsePrevention': '代わりにしたことを記録する。',
      'uncertaintyTraining': '「たぶん」に居場所をつくる。',
      'behavioralExperiments': 'OCDの予測を確かめる。',
      'reflectionJournal': '気づいたことを記録する。',
      'other': '回復ツールを開く。',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageTitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': '確認する',
      'plan': '計画する',
      'practice': '練習する',
      'review': '振り返る',
      'other': 'ツール',
    });
    return '$_temp0';
  }

  @override
  String recoveryStageSubtitle(String stage) {
    String _temp0 = intl.Intl.selectLogic(stage, {
      'assess': '今の状態を確認します。',
      'plan': '練習の準備をします。',
      'practice': '一つ練習します。',
      'review': '振り返って学びます。',
      'other': '役立ちそうなものを選びます。',
    });
    return '$_temp0';
  }

  @override
  String get recoveryProBadge => 'Patterns Pro';

  @override
  String recoveryOpenToolHint(String title) {
    return '$titleを開く';
  }

  @override
  String recoveryLockedToolHint(String title) {
    return '$titleにはPatterns Proが必要です';
  }

  @override
  String get delayNameUrgeValidation => '準備ができたら、向き合う衝動を入力してください。';

  @override
  String get delayOutcomeValidation => '準備ができたら、最終的にどうしたかを選んでください。';

  @override
  String get delaySaveError => '練習を保存できませんでした。もう一度お試しください。';

  @override
  String get delayStopEarlyTitle => '早めに終了しますか？';

  @override
  String get delayStopEarlyBody => '終了しても大丈夫です。待った時間はそのまま記録できます。';

  @override
  String get delayKeepGoingAction => '続ける';

  @override
  String get delayStopAction => '終了する';

  @override
  String get delaySetupTitle => '衝動をいったん止める';

  @override
  String get delayUrgeQuestion => 'どの衝動と向き合っていますか？';

  @override
  String get delayUrgeHint => '例：鍵の確認、手洗い、オンライン検索';

  @override
  String get delayUrgeBeforeLabel => '今の衝動の強さは？';

  @override
  String get delayDurationQuestion => 'どのくらい待ちますか？';

  @override
  String get delayDurationGroupLabel => '待つ時間';

  @override
  String get delayBeginAction => '始める';

  @override
  String get delayCountdownTitle => '衝動と一緒にいます';

  @override
  String get delayCountdownBody => '行動せずに衝動に気づきます。次にどうするかは自分で選べます。';

  @override
  String get delayReflectionTitle => '何が起きましたか？';

  @override
  String delayReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': '予定した時間が終わりました。以下の記録は任意です。',
      'early': 'タイマーを早めに終了しました。以下の記録は任意です。',
      'other': 'タイマーが終わりました。以下の記録は任意です。',
    });
    return '$_temp0';
  }

  @override
  String get delayUrgeAfterLabel => '今の衝動の強さは？';

  @override
  String get delayOutcomeQuestion => '衝動に対してどうしましたか？';

  @override
  String get delayOutcomeGroupLabel => '記録する結果';

  @override
  String get delayNoteLabel => '気づいたことはありますか？（任意）';

  @override
  String get delayNoteHint => '短いメモで十分です。';

  @override
  String get delaySavingAction => '保存中…';

  @override
  String get delaySaveAction => '練習を保存';

  @override
  String delayMinutes(int count) {
    return '$count分';
  }

  @override
  String get delayCustomAction => 'カスタム';

  @override
  String get delayCustomTitle => '待つ時間を指定';

  @override
  String delayOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': 'しなかった',
      'delayed': '先延ばしにした',
      'performed': '行った',
      'other': '未選択',
    });
    return '$_temp0';
  }

  @override
  String delayUrgeValue(int value) {
    return '衝動の強さ 10段階中$value';
  }

  @override
  String delayCustomMinutesValue(int count) {
    return '待つ時間：$count分';
  }

  @override
  String erpFlowText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'outcomeValidation': '準備ができたら、練習中に何が起きたかを選んでください。',
      'saveError': 'ERP練習を保存できませんでした。もう一度お試しください。',
      'stopTitle': '早めに終了しますか？',
      'stopBody': '終了しても大丈夫です。練習した時間はそのまま記録できます。',
      'keepGoing': '続ける',
      'stop': '終了する',
      'anxietyBefore': '今の衝動や不安の強さは？',
      'duration': '時間',
      'start': '練習を始める',
      'countdownCue': 'しない練習',
      'resisting': '行わない反応',
      'countdownBody': 'タイマーが終わる前に、予測が間違いだと証明する必要はありません。',
      'stopEarly': '早めに終了',
      'reflectionTitle': '振り返る',
      'reflectionBody': '以下の記録は任意です。役立つと感じることだけを記録してください。',
      'anxietyAfter': '今の強さは？',
      'outcomeQuestion': 'どうしましたか？',
      'whatHappened': '実際には何が起きましたか？',
      'whatHappenedHint': '練習中や練習後に気づいたことは？',
      'learning': '次回のための気づき',
      'learningHint': '次にOCDが求めてきた時、何を覚えておきたいですか？',
      'exposure': '曝露',
      'prediction': '予測',
      'commitment': '取り組むこと',
      'saving': '保存中…',
      'save': '練習を保存',
      'other': 'ERP練習',
    });
    return '$_temp0';
  }

  @override
  String erpReflectionStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': '予定した時間が終わりました。',
      'early': 'タイマーを早めに終了しました。',
      'other': 'タイマーが終わりました。',
    });
    return '$_temp0';
  }

  @override
  String erpOutcome(String outcome) {
    String _temp0 = intl.Intl.selectLogic(outcome, {
      'resisted': '反応をしなかった',
      'delayed': '反応を先延ばしにした',
      'performed': '反応をした',
      'other': '未選択',
    });
    return '$_temp0';
  }

  @override
  String erpIntensityValue(int value) {
    return '強さ 10段階中$value';
  }

  @override
  String erpPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'ガイド付きERP',
      'subtitle': '計画を再利用して練習し、起きたことを記録します。',
      'myPlans': 'ERP計画',
      'newAction': '新規',
      'plansError': '現在、ERP計画を読み込めません。',
      'recentPractice': '最近の練習',
      'historyError': '現在、練習履歴を読み込めません。',
      'archiveTitle': 'この計画をアーカイブしますか？',
      'archiveBody': '実行中の計画から外れますが、過去の練習は履歴に残ります。',
      'keepAction': '残す',
      'archiveAction': 'アーカイブ',
      'exposureValidation': '準備ができたら、練習したい状況を入力してください。',
      'commitmentValidation': '計画を保存するには、行わない練習をする反応を選んでください。',
      'saveError': 'ERP計画を保存できませんでした。もう一度お試しください。',
      'updated': 'ERP計画を更新しました。',
      'created': 'ERP計画を作成しました。',
      'editTitle': 'ERP計画を編集',
      'createTitle': 'ERP計画を作成',
      'exerciseType': '練習の種類',
      'exposureTarget': '曝露の対象',
      'ocdPrediction': 'OCDの予測',
      'preventionCommitment': '反応妨害の取り組み',
      'defaultDuration': '既定の時間',
      'saving': '保存中…',
      'saveAction': '計画を保存',
      'createAction': '計画を作成',
      'emptyTitle': '最初のERP計画を作成',
      'emptyBody': '曝露、予測、行わない練習をする反応を一度書けば、必要なときに計画を再利用できます。',
      'moreActions': '計画のその他の操作',
      'editAction': '計画を編集',
      'archivePlanAction': '計画をアーカイブ',
      'practiceGuide': '練習ガイド',
      'historyEmpty': '完了した練習がここに表示されます。',
      'customDuration': '時間を指定',
      'other': 'ERP計画',
    });
    return '$_temp0';
  }

  @override
  String erpPlanResist(String response) {
    return '行わない反応：$response';
  }

  @override
  String erpPlanRatingChange(int before, int after) {
    return '$before → $after';
  }

  @override
  String get erpFirstRunPrediction => '反応しなければ不快感は変わらない、とOCDは言っています。';

  @override
  String erpTemplateTitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': '確認を遅らせる',
      'delayReassurance': '安心を求めるのを遅らせる',
      'delayGoogling': '検索を遅らせる',
      'delayRumination': '反すうを遅らせる',
      'delayWashing': '洗うのを遅らせる',
      'other': 'ガイド付きERP',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateSubtitle(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': '短い時間、確認せずにおく練習をします。',
      'delayReassurance': '誰かに確かさを求める前に待ちます。',
      'delayGoogling': '確かさや証拠を探すのを先延ばしにします。',
      'delayRumination': '頭の中の問題解決に従わず、気づきます。',
      'delayWashing': 'もう一度洗ったり、掃除や消毒をしたりする前に待ちます。',
      'other': '反応を遅らせる練習をします。',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateIntro(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking':
          '鍵、スイッチ、メッセージ、症状、間違いなどをもう一度確認するようOCDが迫る場面のために、再利用できる計画を作ります。',
      'delayReassurance': '質問、告白、説明をしたり、誰かに大丈夫だと確認してもらったりしたい衝動のために計画を作ります。',
      'delayGoogling': '確かになるまで症状、意味、危険、規則、体験談を検索するようOCDが迫る場面のために計画を作ります。',
      'delayRumination': '思い返す、証明する、見直す、解決するといった心の強迫行為のために計画を作ります。',
      'delayWashing': '何かが汚染されたように感じて、洗う、掃除する、消毒する、やり直す衝動のために計画を作ります。',
      'other': '繰り返し使えるERP練習の計画を作ります。',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateWhy(String template) {
    String _temp0 = intl.Intl.selectLogic(template, {
      'delayChecking': 'ERPでは、すぐに儀式的行為をせず、不確かさがある状態を練習します。',
      'delayReassurance': '安心を得ることはその場では役立つように感じられますが、遅らせることで、分からない状態を練習できます。',
      'delayGoogling': '検索を先延ばしにすると、確かさを求める循環を中断し、問いを未回答のままにする練習ができます。',
      'delayRumination': '反すうは考えることのように見えますが、ERPでは結論を出さずに循環から離れる練習をします。',
      'delayWashing': '待つことで、すぐに儀式的行為をせず、汚染された感じがある状態を練習できます。',
      'other': 'ERPでは、すぐに儀式的行為をせず、不確かさのための余地を作ります。',
    });
    return '$_temp0';
  }

  @override
  String erpTemplatePrompt(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayCheckingExposure': '確認せずにおくもの、または一度だけ確認するものは？',
      'delayCheckingPrediction': '再確認しなければ何が起きるとOCDは予測していますか？',
      'delayCheckingCommitment': 'どの確認行為をしない練習をしますか？',
      'delayReassuranceExposure': 'どのような安心を求めたいですか？',
      'delayReassurancePrediction': '尋ねなければ何が起きるとOCDは言っていますか？',
      'delayReassuranceCommitment': 'どのメッセージ、告白、質問を控えますか？',
      'delayGooglingExposure': 'どの検索や問いを未回答のままにしますか？',
      'delayGooglingPrediction': '今すぐ何を知る必要があるとOCDは言っていますか？',
      'delayGooglingCommitment': 'どの検索、記事、掲示板を避けますか？',
      'delayRuminationExposure': 'どの思考の循環を終わらせずにおきますか？',
      'delayRuminationPrediction': '何を解決または証明する必要があるとOCDは言っていますか？',
      'delayRuminationCommitment': 'どの心の見直しや議論を控えますか？',
      'delayWashingExposure': 'どの通常の衛生上の範囲に従いますか？',
      'delayWashingPrediction': 'もう一度洗わなければ何が起きるとOCDは予測していますか？',
      'delayWashingCommitment': 'どの追加の洗浄、掃除、消毒を控えますか？',
      'other': 'どの反応をしない練習をしますか？',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateInstruction(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': '始める前に確認のルールを一つ決めます。',
      'delayChecking2': '通常の安全確認に含まれる場合は、計画した確認を一度だけ行います。',
      'delayChecking3': 'タイマー中は再確認を控えます。',
      'delayChecking4': '衝動と交渉せず、そこにあることに気づきます。',
      'delayReassurance1': '始める前に、求めたい安心の内容を決めます。',
      'delayReassurance2': 'タイマー中はメッセージを送らず、質問もしません。',
      'delayReassurance3': '確かさを求めず、不快感がある状態にします。',
      'delayReassurance4': 'できる範囲で穏やかに元の行動に戻ります。',
      'delayGoogling1': 'ほかのものを開く前に、検索したい内容を決めます。',
      'delayGoogling2': '検索欄またはブラウザーのタブを閉じます。',
      'delayGoogling3': 'ほかを読む前にタイマーを始めます。',
      'delayGoogling4': '今は問いを未回答のままにします。',
      'delayRumination1': '見直す、解決する、証明する、確認するなど、循環に名前を付けます。',
      'delayRumination2': '考えを終わらせずにおきます。',
      'delayRumination3': '日常の一つの作業や感覚に注意を戻します。',
      'delayRumination4': '循環に引き戻されるたびに、穏やかにやり直します。',
      'delayWashing1': '始める前に通常の衛生上の範囲を決めます。',
      'delayWashing2': '難しくても可能に感じる待ち時間から始めます。',
      'delayWashing3': 'タイマー中は手を洗面台や消毒剤から離します。',
      'delayWashing4': '完璧にしようとせず、不快感がある状態にします。',
      'other': '選んだ計画に従います。',
    });
    return '$_temp0';
  }

  @override
  String erpTemplateCue(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'delayChecking1': '一度だけ確認',
      'delayChecking2': '再確認しない',
      'delayChecking3': '衝動に気づく',
      'delayReassurance1': '質問を控える',
      'delayReassurance2': '不確かさを残す',
      'delayReassurance3': '穏やかに戻る',
      'delayGoogling1': '検索を閉じる',
      'delayGoogling2': 'タイマー開始',
      'delayGoogling3': '未回答のままにする',
      'delayRumination1': '循環に名前を付ける',
      'delayRumination2': '終わらせずにおく',
      'delayRumination3': '作業に戻る',
      'delayWashing1': '範囲を決める',
      'delayWashing2': '洗うのを遅らせる',
      'delayWashing3': '不快感を許す',
      'other': '計画に従う',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '構造化プログラム',
      'subtitle': '自分のペースで、週ごとのガイド付き計画に取り組みます。',
      'themeGroup': 'OCDのテーマ別',
      'themeGroupEmpty': '練習したい内容に合う場合はテーマを選んでください。',
      'themeGroupMatched': '前回のセルフチェックで記録したテーマには印が付いています。',
      'generalGroup': '一般的な練習',
      'generalCaption': '複数のテーマで使えるスキルです。',
      'enrollError': 'このプログラムを開けませんでした。もう一度お試しください。',
      'started': '開始済み',
      'notStarted': '未開始',
      'openHint': 'プログラムの詳細を開く',
      'selfCheckMatch': 'セルフチェックと一致',
      'tapToStart': 'タップして開始',
      'progressLoadError': 'プログラムの記録を読み込めませんでした。もう一度お試しください。',
      'activityRecorded': 'タスクの選択は端末内に記録されます。',
      'taskSaveError': 'タスクの変更を保存できませんでした。もう一度お試しください。',
      'weekComplete': 'すべてのタスクが完了として記録されています',
      'weekNotComplete': '残っているタスクがあります',
      'weekToggleHint': 'この週を展開または折りたたむ',
      'taskToggleHint': 'このタスクの記録を付ける、または外す',
      'other': 'プログラム',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramProgress(int done, int total, int percent) {
    return '$total件中$done件、$percentパーセント';
  }

  @override
  String structuredProgramSummary(int count, String subtitle) {
    return '$count週間・$subtitle';
  }

  @override
  String structuredProgramComplete(int count) {
    return '$count件のタスクがすべて完了として記録されています。';
  }

  @override
  String structuredProgramTaskProgress(int done, int total) {
    return '$total件中$done件を完了として記録';
  }

  @override
  String structuredProgramCompactProgress(int done, int total) {
    return '$done/$total';
  }

  @override
  String exposureHierarchyText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'エクスポージャー階層',
      'newAction': '新規',
      'subtitle': '取り組めそうなエクスポージャーを段階に分け、一つずつ練習します。',
      'loadError': '階層を読み込めませんでした。もう一度お試しください。',
      'archiveTitle': 'この階層をアーカイブしますか？',
      'archiveBody': 'この階層は使用中の一覧から外れます。保存したステップはこの端末に残ります。',
      'keepAction': '残す',
      'archiveAction': 'アーカイブ',
      'archiveSuccess': '階層をアーカイブしました。',
      'archiveError': '階層をアーカイブできませんでした。もう一度お試しください。',
      'emptyTitle': '最初の階層を作る',
      'emptyBody': '取り組めそうなエクスポージャーを易しいものから難しいものへ並べ、自分のペースを選びます。',
      'buildAction': '階層を作る',
      'newTitle': '新しい階層',
      'nameLabel': '名前',
      'nameHint': '例：ドアノブに触れる',
      'themeLabel': 'テーマ（任意）',
      'themeHint': '例：汚染',
      'generalTheme': '一般',
      'stepsTitle': '易しい順のステップ',
      'addAction': '追加',
      'createAction': '階層を作成',
      'saving': '保存中…',
      'titleValidation': 'この階層に名前を付けてください。',
      'stepValidation': 'エクスポージャーのステップを少なくとも一つ追加してください。',
      'createSuccess': '階層を保存しました。',
      'createError': '階層を保存できませんでした。もう一度お試しください。',
      'stepHint': 'どのようなエクスポージャーを練習できますか？',
      'difficulty': '難易度',
      'anxiety': '予想される不安',
      'materialAction': '素材',
      'statusNotStarted': '未開始',
      'statusInProgress': '進行中',
      'statusDone': '完了',
      'statusError': 'ステップの状態を保存できませんでした。もう一度お試しください。',
      'moveUp': 'ステップを上へ移動',
      'moveDown': 'ステップを下へ移動',
      'removeStep': 'ステップを削除',
      'openHierarchy': '階層を開く',
      'archiveHierarchy': '階層をアーカイブ',
      'other': 'エクスポージャー階層',
    });
    return '$_temp0';
  }

  @override
  String exposureHierarchySummary(int done, int count, String theme) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件中$done件完了 · $theme',
      zero: '$theme',
    );
    return '$_temp0';
  }

  @override
  String exposureStepLabel(int number) {
    return 'ステップ$number';
  }

  @override
  String exposureRating(int value) {
    return '10段階中$value';
  }

  @override
  String exposureStepMetrics(int difficulty, int anxiety) {
    return '難易度 10段階中$difficulty · 予想される不安 10段階中$anxiety';
  }

  @override
  String exposureProgress(int percent) {
    return '$percent％のステップを完了として記録';
  }

  @override
  String exposureMaterialsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'エクスポージャー素材',
      'newAction': '新規',
      'subtitle': 'エクスポージャーで使う台本、ループ録音、画像、リンクをまとめて保存します。',
      'loadError': '素材を読み込めませんでした。もう一度お試しください。',
      'typeScript': '台本',
      'typeLoopTape': 'ループ録音',
      'typeImage': '画像',
      'typeLink': 'リンク',
      'deleteTitle': 'この素材を削除しますか？',
      'deleteBody': '保存ファイルがある場合は、そのファイルを含めてこの端末から削除します。',
      'cancel': 'キャンセル',
      'deleteAction': '削除',
      'deleteTooltip': '素材を削除',
      'deleteSuccess': '素材を削除しました。',
      'deleteError': '素材を削除できませんでした。もう一度お試しください。',
      'emptyTitle': '素材をまとめる',
      'emptyBody': '自分で選んだエクスポージャーのために、台本、ループ録音、画像、リンクを保存します。',
      'addAction': '素材を追加',
      'readScript': '台本を読む',
      'openLink': 'リンクを開く',
      'viewImage': '画像を見る',
      'linkError': 'リンクを開けませんでした。',
      'imageMissing': 'この画像はこの端末で利用できなくなっています。',
      'recordingMissing': 'この録音はこの端末で利用できなくなっています。',
      'stop': '停止',
      'playLoop': 'ループ再生',
      'microphoneNeeded': 'ループを録音するにはマイクへのアクセスが必要です。端末の設定で変更できます。',
      'nameValidation': 'この素材に名前を付けてください。',
      'scriptValidation': '台本の文章を追加してください。',
      'linkValidation': 'リンクを貼り付けてください。',
      'imageValidation': '画像を選んでください。',
      'recordingValidation': '保存する前にループを録音してください。',
      'saveSuccess': '素材を保存しました。',
      'saveError': '素材を保存できませんでした。もう一度お試しください。',
      'titleLabel': 'タイトル',
      'titleHint': '見分けやすい短い名前',
      'saveAction': '素材を保存',
      'scriptLabel': '台本',
      'scriptHint': 'エクスポージャー中に読む文章',
      'linkLabel': 'リンク',
      'pickImage': '画像を選ぶ',
      'changeImage': '画像を変更',
      'rerecord': '録音し直す',
      'recorderHint': '繰り返し再生する短い音声を録音します。',
      'record': '録音',
      'recording': '録音中',
      'other': 'エクスポージャー素材',
    });
    return '$_temp0';
  }

  @override
  String exposureMaterialEditorTitle(String type) {
    return '新しい$type';
  }

  @override
  String exposureRecordingSeconds(int seconds) {
    return '録音中 · $seconds秒';
  }

  @override
  String responsePreventionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '反応妨害',
      'logAction': '記録',
      'subtitle': 'きっかけ、選んだ反応、その時の苦痛度を記録します。',
      'loadError': '反応の記録を読み込めませんでした。もう一度お試しください。',
      'deleteTitle': 'この反応の記録を削除しますか？',
      'deleteBody': 'この記録を端末から完全に削除します。',
      'cancel': 'キャンセル',
      'deleteAction': '削除',
      'deleteTooltip': '反応の記録を削除',
      'deleteSuccess': '反応の記録を削除しました。',
      'deleteError': '反応の記録を削除できませんでした。もう一度お試しください。',
      'outcomeResisted': '実行しなかった',
      'outcomeDelayed': '遅らせた',
      'outcomePartial': '一部実行した',
      'outcomePerformed': '実行した',
      'emptyTitle': '反応を記録する',
      'emptyBody': 'きっかけの後に選んだことと、その時に気づいた苦痛度を記録します。',
      'emptyAction': '反応を記録',
      'editorTitle': '反応を記録',
      'situationLabel': 'きっかけは何でしたか？',
      'situationHint': 'きっかけと、OCDが促した反応',
      'outcomeQuestion': '何をしましたか？',
      'distressLabel': 'その時の苦痛度',
      'noteLabel': 'メモ（任意）',
      'noteHint': '覚えておきたいこと',
      'saveAction': '記録を保存',
      'situationValidation': 'きっかけについて短く入力してください。',
      'saveSuccess': '反応の記録を保存しました。',
      'saveError': '反応の記録を保存できませんでした。もう一度お試しください。',
      'other': '反応妨害',
    });
    return '$_temp0';
  }

  @override
  String responsePreventionDistress(int value) {
    return '苦痛度$value/10';
  }

  @override
  String responsePreventionLogSummary(
    String outcome,
    String date,
    int distress,
    String situation,
  ) {
    return '$outcome · $date · 苦痛度$distress/10 · $situation';
  }

  @override
  String urgeSurfText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '衝動の波に乗る',
      'subtitle': '衝動を変えたり反応したりする必要を置かず、選んだ時間だけ観察します。',
      'startAction': '始める',
      'historyTitle': '過去の記録',
      'emptyHistory': '保存した記録はまだありません。記録したセッションがここに表示されます。',
      'loadError': '保存した記録を読み込めませんでした。もう一度お試しください。',
      'triggerFallback': '衝動',
      'setupTitle': '始める前に',
      'triggerLabel': 'どのような衝動ですか？（任意）',
      'triggerHint': '例：もう一度手を洗いたい衝動',
      'initialUrgeLabel': '開始時の衝動',
      'durationQuestion': 'どのくらい観察しますか？',
      'begin': '開始',
      'surfingTitle': '衝動を観察する',
      'surfingBody': '考えや感覚に気づき、次に何をするかを選びます。いつでも止められます。',
      'currentUrgeLabel': '現在の衝動',
      'doneAction': '今はここまで',
      'reflectionTitle': '気づいたことを記録',
      'waveTitle': '記録した衝動の強さ',
      'finalUrgeLabel': '終了時の衝動',
      'noteLabel': 'メモ（任意）',
      'noteHint': '何に気づきましたか？',
      'saveAction': '記録を保存',
      'finishAction': '終了',
      'saveSuccess': '記録を保存しました。',
      'finishSuccess': '練習を終了しました。',
      'saveError': '記録を保存できませんでした。もう一度お試しください。',
      'timerComplete': '観察時間が終了しました。',
      'other': '衝動の波に乗る',
    });
    return '$_temp0';
  }

  @override
  String urgeSurfRating(int value) {
    return '衝動の強さ$value/10';
  }

  @override
  String urgeSurfDuration(int minutes) {
    return '$minutes分';
  }

  @override
  String urgeSurfRecordedDuration(int minutes, int seconds) {
    return '$minutes分$seconds秒';
  }

  @override
  String urgeSurfHistorySummary(
    int initial,
    int peak,
    int finalLevel,
    String duration,
  ) {
    return '開始時$initial/10 · 記録した最高値$peak/10 · 終了時$finalLevel/10 · $duration';
  }

  @override
  String urgeSurfSessionSemantics(String trigger, String date, String summary) {
    return '$trigger · $date · $summary';
  }

  @override
  String urgeSurfWaveSummary(int initial, int peak) {
    return '開始時$initial/10 · 記録した最高値$peak/10';
  }

  @override
  String urgeSurfTimerDisplay(int minutes, String seconds) {
    return '$minutes:$seconds';
  }

  @override
  String urgeSurfTimeRemaining(int minutes, int seconds) {
    return '残り$minutes分$seconds秒';
  }

  @override
  String emergencyToolkitText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '今この時のサポート',
      'pauseTitle': '反応する前に立ち止まる',
      'pauseBody': '衝動にすぐ反応する必要はありません。下からセルフヘルプの練習を一つ選び、ゆっくり進めてください。',
      'boundary': 'これらのツールは緊急支援や医療ではありません。差し迫った危険がある場合は、地域の緊急サービスに連絡してください。',
      'breathe': '呼吸する',
      'breatheSubtitle': '一定のリズムで呼吸する',
      'delay': '衝動を待つ',
      'delaySubtitle': 'タイマーで間をつくる',
      'surf': '衝動の波に乗る',
      'surfSubtitle': '行動せずに衝動に気づく',
      'coping': '対処法',
      'copingSubtitle': 'グラウンディング、受容など',
      'remindersTitle': 'いくつかの確認',
      'reminderThought': '考えに反応する必要はない。行動せずに気づくことができる。',
      'reminderUrge': '衝動は時間とともに変化することがある。次にすることは自分で選べる。',
      'reminderUncertainty': '今この時、不確かさのための余地をつくることができる。',
      'breatheIn': '息を吸う',
      'hold': '止める',
      'breatheOut': '息を吐く',
      'breathingHint': '円に合わせて、4秒吸い、止め、4秒吐き、もう一度止めます。',
      'other': 'サポートツール',
    });
    return '$_temp0';
  }

  @override
  String ybocsText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'OCDセルフチェック',
      'introBody':
          'Yale-Brown Obsessive Compulsive Scale（Y-BOCS）に基づき、気づいたパターンと生活への影響を確認するガイド付きセルフチェックです。',
      'spotTitle': 'パターンを確認',
      'spotBody': '経験したことのある強迫観念や強迫行為を選びます。',
      'impactTitle': '影響を記録',
      'impactBody': '生活への影響について10問に答えます。',
      'resultIntroTitle': '結果を確認',
      'resultIntroBody': '記録されたテーマ、小計、重症度の範囲を確認します。',
      'begin': '始める',
      'retakeAction': 'もう一度行う',
      'privacyDuration': '所要時間は約10分です。エクスポートしない限り、回答はこの端末に保存されます。',
      'disclaimer':
          'このセルフチェックは体験を言葉にするためのものです。OCDの診断や緊急支援ではありません。OCDを診断できるのは資格を持つ専門家だけです。',
      'historyTitle': '履歴',
      'historyBody': '以前に記録した合計点がここに表示されます。',
      'deleteTitle': '評価を削除しますか？',
      'deleteBody': 'この端末からこの評価を完全に削除します。',
      'cancel': 'キャンセル',
      'deleteAction': '削除',
      'deleteTooltip': '評価を削除',
      'deleteSuccess': '評価を削除しました。',
      'deleteError': '評価を削除できませんでした。もう一度お試しください。',
      'checklistTitle': '思い当たるものはありますか？',
      'checklistBody': '現在または過去に経験したものを選んでください。当てはまらないものは飛ばせます。',
      'obsessions': '強迫観念',
      'obsessionsDescription': '望まない考え、イメージ、衝動',
      'compulsions': '強迫行為',
      'compulsionsDescription': '苦痛への反応として行う行動や心の中の行為',
      'continueAction': '続ける',
      'seeResults': '結果を見る',
      'next': '次へ',
      'resultsTitle': '結果',
      'retake': 'やり直す',
      'saved': '保存済み',
      'saveHistory': '履歴に保存',
      'saving': '保存中…',
      'saveSuccess': '履歴に保存しました。',
      'saveError': '評価を保存できませんでした。もう一度お試しください。',
      'breakdownTitle': '記録された小計',
      'typesTitle': '記録された種類',
      'typesNone': 'このセルフチェックでは強迫観念または強迫行為の種類は記録されませんでした。',
      'typesBoth': 'このセルフチェックでは強迫観念と強迫行為の両方が記録されました。',
      'typesObsessions': 'このセルフチェックでは強迫観念が記録されました。',
      'typesCompulsions': 'このセルフチェックでは強迫行為が記録されました。',
      'themesTitle': '記録されたテーマ',
      'themesBody': '選択した項目を含むチェックリストのカテゴリーです。',
      'nextStepsTitle': 'この結果について',
      'nextStepsBody':
          'この結果は自己申告による一時点の記録で、診断や緊急支援ではありません。生活に影響がある場合は、資格を持つ専門家に相談できます。差し迫った危険がある場合は、地域の緊急サービスに連絡してください。',
      'other': 'Y-BOCSセルフチェック',
    });
    return '$_temp0';
  }

  @override
  String ybocsSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '続ける · $count件選択',
      zero: '続ける',
    );
    return '$_temp0';
  }

  @override
  String ybocsQuestionProgress(int current, int total) {
    return '$total問中$current問目';
  }

  @override
  String ybocsScoreOutOf(int score, int maximum) {
    return '$maximum点中$score点';
  }

  @override
  String ybocsHistorySummary(String severity, int score, String date) {
    return '$severity · 40点中$score点 · $date';
  }

  @override
  String ybocsSeveritySummary(
    String severity,
    String score,
    String description,
  ) {
    return '$severity · $score · $description';
  }

  @override
  String ybocsSubtotalSummary(String label, String score) {
    return '$label · $score';
  }

  @override
  String ybocsCategorySelectedCount(int count) {
    return '$count件選択';
  }

  @override
  String structuredProgramTaskChanged(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'completed': 'タスクを完了として記録しました。',
      'notCompleted': 'タスクの完了記録を外しました。',
      'other': 'タスクを更新しました。',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': '4週間の強迫行為延期',
      'uncertainty3wk': '不確かさへの耐性',
      'other': '構造化プログラム',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramSubtitle(String program) {
    String _temp0 = intl.Intl.selectLogic(program, {
      'delay4wk': '週ごとに強迫行為を遅らせる練習',
      'uncertainty3wk': '分からないまま過ごす練習',
      'other': 'ガイド付き練習計画',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'delayW1': '第1週・気づいて名前を付ける',
      'delayW2': '第2週・間隔を延ばす',
      'delayW3': '第3週・長く待つ',
      'delayW4': '第4週・毎日の練習',
      'uncertaintyW1': '第1週・答えを開いたままにする',
      'uncertaintyW2': '第2週・そうかもしれないし、違うかもしれない',
      'uncertaintyW3': '第3週・そのままにする',
      'other': 'プログラムの週',
    });
    return '$_temp0';
  }

  @override
  String structuredProgramTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'w1a': 'すぐに行動せず、3回の衝動を記録する',
      'w1b': '1分間の強迫行為延期を3回行う',
      'w2a': '強迫行為を5分間遅らせる',
      'w2b': '衝動サーフィンを1回試す',
      'w3a': '15分間遅らせる',
      'w3b': '安心を求める衝動を1回控える',
      'w4a': '毎日1回の曝露を行う',
      'w4b': '気づいたことを振り返る',
      'u1a': '一つの問いを未回答のままにする',
      'u1b': '確認を1回控える',
      'u2a': '「そうかもしれないし、違うかもしれない」と3回答える',
      'u2b': '心配についてのオンライン検索を遅らせる',
      'u3a': '確かさを求めずに1日過ごす',
      'u3b': '気づいたことを振り返る',
      'other': 'プログラムのタスク',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTitle(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': '汚染と洗浄',
      'checking': '確認と疑い',
      'harm': '加害・タブー思考',
      'relationship': '関係への疑い',
      'justRight': 'ぴったり感と対称性',
      'other': 'OCDのテーマ',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackBlurb(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': '何かが汚い、感染性がある、触れるのが危険だという恐れと、その後の洗浄や掃除のための練習です。',
      'checking': '鍵、コンロ、スイッチ、メッセージなど、十分に確かに感じられず戻ってしまうもののための練習です。',
      'harm': '加害や、暴力的・性的・冒とく的に感じるテーマの侵入思考と、その後の強迫行為や回避のための練習です。',
      'relationship': '関係が正しいか、十分に感じているか、疑いにどんな意味があるかという繰り返す疑いのための練習です。',
      'justRight': 'ぴったり感じるまで、均等、整列、反復が必要に感じられることのための練習です。',
      'other': 'OCDのテーマに沿った練習トラックです。',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTheme(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'contamination': '汚染',
      'checking': '確認',
      'harm': '加害・タブー思考',
      'relationship': '関係への疑い',
      'justRight': 'ぴったり感',
      'other': 'OCDのテーマ',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackChecklistNote(String track) {
    String _temp0 = intl.Intl.selectLogic(track, {
      'relationship':
          'Y-BOCSチェックリストは関係性OCDの研究より前に作られたため、このテーマはカテゴリーに含まれていません。この練習トラックは利用できます。',
      'other': 'このテーマはY-BOCSチェックリストのカテゴリーには含まれていません。',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackWeek(String week) {
    String _temp0 = intl.Intl.selectLogic(week, {
      'ct1': '第1週・触れてから待つ',
      'ct2': '第2週・3回ではなく1回洗う',
      'ct3': '第3週・家まで持ち帰る',
      'ck1': '第1週・一度だけ見る',
      'ck2': '第2週・頭の中で再生しない',
      'ck3': '第3週・未解決のままにする',
      'hm1': '第1週・そこにあるままにする',
      'hm2': '第2週・尋ねるのをやめる',
      'hm3': '第3週・心の中で裁判をしない',
      'rl1': '第1週・試すのをやめる',
      'rl2': '第2週・安心を求めない',
      'rl3': '第3週・「かもしれない」と過ごす',
      'jr1': '第1週・ずれたままにする',
      'jr2': '第2週・繰り返さない',
      'jr3': '第3週・十分とする',
      'other': 'トラックの週',
    });
    return '$_temp0';
  }

  @override
  String ocdTrackTask(String task) {
    String _temp0 = intl.Intl.selectLogic(task, {
      'ct1a': '少し汚く感じるものに触れ、5分間手を洗わずにおく',
      'ct1b': '洗わずに、前後の衝動を記録する',
      'ct2a': '通常どおり一度洗い、2回目に戻らない',
      'ct2b': '家の一つの表面を1週間掃除せずにおく',
      'ct3a': '普段なら後で洗いたくなる場所に行き、帰宅時に洗わない',
      'ct3b': 'OCDの予測と実際に起きたことを並べて書く',
      'ck1a': '一つのものを一度だけ確認し、二度目を見ずに離れる',
      'ck1b': '部屋を最後に見回さずに一度外出する',
      'ck2a': '記憶を再生したい衝動が来たら、疑いを未解決のままにする',
      'ck2b': '送信前後に読み直さず、一つのメッセージを送る',
      'ck3a': '一日、何も二度確認しに戻らずに過ごす',
      'ck3b': '実際に起きたこととOCDの予測を記録する',
      'hm1a': '一つの侵入思考を、反論したり押しのけたりせず1分間そこに置く',
      'hm1b': '心の見直しが始まる前に気づき、そのままにする',
      'hm2a': '自分が良い人か尋ねず、答えの検索もしない',
      'hm2b': 'その思考のために避けていた状況にとどまる',
      'hm3a': '自分についての証拠として感情を確認せずに1日過ごす',
      'hm3b': '自分を採点せず、その週がどうだったかを書く',
      'rl1a': '自分が行う相性テストに一つ気づき、一度省く',
      'rl1b': '関係への疑いを10分間未回答のままにする',
      'rl2a': '関係が正しいか、パートナー、友人、インターネットに1日尋ねない',
      'rl2b': '一緒に何かをし、その間の感情を監視しない',
      'rl3a': '問いが来たら「そうかもしれないし、違うかもしれない」と答える',
      'rl3b': '将来を決めずに、その週を振り返る',
      'jr1a': '一つの物を少しずらしたままにし、その感覚を置いておく',
      'jr1b': '終わった感じがしなくても、一度だけ行う',
      'jr2a': 'ぴったり感じさせるために行動を繰り返さない',
      'jr2b': '表現をそろえるために戻らず、文章を書く',
      'jr3a': 'いくつかのことを意図的に未完了のままにして1日過ごす',
      'jr3b': 'ぴったりしない感覚を変えずに、起きたことを記録する',
      'other': 'トラックのタスク',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionPrompt(String question) {
    String _temp0 = intl.Intl.selectLogic(question, {
      'o_time': '強迫観念にどのくらい時間を取られていますか？',
      'o_interfere': '強迫観念は生活をどのくらい妨げていますか？',
      'o_distress': '強迫観念によってどのくらい苦痛を感じますか？',
      'o_resist': '強迫観念にどのくらい抵抗しようとしていますか？',
      'o_control': '強迫観念をどのくらい制御できますか？',
      'c_time': '儀式や確認などの強迫行為にどのくらい時間を使っていますか？',
      'c_interfere': '強迫行為は生活をどのくらい妨げていますか？',
      'c_distress': '強迫行為ができないと、どのくらい不安または動揺を感じますか？',
      'c_resist': '強迫行為にどのくらい抵抗しようとしていますか？',
      'c_control': '強迫行為をどのくらい制御できますか？',
      'other': 'セルフチェックの質問',
    });
    return '$_temp0';
  }

  @override
  String ybocsQuestionOption(String option) {
    String _temp0 = intl.Intl.selectLogic(option, {
      'o_time_0': 'まったくない',
      'o_time_1': '少し：1日1時間未満、または時々ある',
      'o_time_2': '中程度：1日1〜3時間、または頻繁に入り込む',
      'o_time_3': '多い：1日3〜8時間、または非常に頻繁に入り込む',
      'o_time_4': 'ほぼ常に：1日8時間を超える',
      'o_interfere_0': 'まったくない',
      'o_interfere_1': '少し：行動にはほとんど影響しない',
      'o_interfere_2': 'ある程度：妨げになるが、まだ対処できる',
      'o_interfere_3': '大きい：日常を明らかに妨げる',
      'o_interfere_4': 'ほとんど何もできないほど大きい',
      'o_distress_0': 'ない',
      'o_distress_1': '少し：それほどつらくない',
      'o_distress_2': '中程度：つらいが対処できる',
      'o_distress_3': '大きい：とてもつらい',
      'o_distress_4': 'ほぼ常に続く、生活を大きく妨げる苦痛',
      'o_resist_0': 'いつも抵抗しようとする、またはほとんど起こらない',
      'o_resist_1': 'たいてい抵抗しようとする',
      'o_resist_2': 'ある程度抵抗しようとする',
      'o_resist_3': 'あまり抵抗せず、ほとんどに従う',
      'o_resist_4': '自ら完全に従う',
      'o_control_0': '完全に制御できる：簡単に振り払える',
      'o_control_1': 'かなり制御できる：たいてい止めたり注意をそらしたりできる',
      'o_control_2': 'ある程度制御できる：できる時とできない時がある',
      'o_control_3': 'ほとんど制御できない：止められることは少ない',
      'o_control_4': '制御できない：完全に不随意に感じる',
      'c_time_0': 'まったくない',
      'c_time_1': '少し：1日1時間未満、または時々ある',
      'c_time_2': '中程度：1日1〜3時間、または頻繁に儀式を行う',
      'c_time_3': '多い：1日3〜8時間、または非常に頻繁に儀式を行う',
      'c_time_4': 'ほぼ常に：1日8時間を超える',
      'c_interfere_0': 'まったくない',
      'c_interfere_1': '少し：行動にはほとんど影響しない',
      'c_interfere_2': 'ある程度：妨げになるが、まだ対処できる',
      'c_interfere_3': '大きい：日常を明らかに妨げる',
      'c_interfere_4': 'ほとんど何もできないほど大きい',
      'c_distress_0': 'まったくない',
      'c_distress_1': '少し落ち着かない',
      'c_distress_2': '中程度の不安',
      'c_distress_3': '強い不安',
      'c_distress_4': '圧倒され、生活を大きく妨げる不安',
      'c_resist_0': 'いつも抵抗しようとする、またはほとんど起こらない',
      'c_resist_1': 'たいてい抵抗しようとする',
      'c_resist_2': 'ある程度抵抗しようとする',
      'c_resist_3': 'あまり抵抗せず、ほとんどに従う',
      'c_resist_4': '自ら完全に従う',
      'c_control_0': '完全に制御できる：簡単に止められる',
      'c_control_1': 'かなり制御できる：たいてい止めたり遅らせたりできる',
      'c_control_2': 'ある程度制御できる：できる時とできない時がある',
      'c_control_3': 'ほとんど制御できない：止めたり遅らせたりできることは少ない',
      'c_control_4': '制御できない：最後まで行わなければならない',
      'other': '回答の選択肢',
    });
    return '$_temp0';
  }

  @override
  String ybocsCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'aggressive': '攻撃・危害に関するもの',
      'contamination': '汚染',
      'sexual': '性的なもの',
      'hoarding_obs': 'ため込み・保存',
      'religious': '宗教的・道徳的な過剰な良心',
      'symmetry_obs': '対称性・正確さ',
      'somatic': '身体・病気',
      'misc_obs': 'その他の強迫観念',
      'washing': '洗浄・清掃',
      'checking': '確認',
      'repeating': '繰り返しの儀式',
      'counting': '数えること',
      'ordering': '順序・配置',
      'misc_comp': 'その他の強迫行為',
      'other': 'その他のテーマ',
    });
    return '$_temp0';
  }

  @override
  String ybocsSymptomLabel(String symptom) {
    String _temp0 = intl.Intl.selectLogic(symptom, {
      'agg_harm_self': '自分を傷つけるかもしれないという恐れ',
      'agg_harm_others': '他の人を傷つけるかもしれないという恐れ',
      'agg_violent': '暴力的または恐ろしいイメージが頭に浮かぶ',
      'agg_blurt': '侮辱や卑わいな言葉を口走るという恐れ',
      'agg_impulse': '望まない衝動に従うという恐れ',
      'agg_responsible': '恐ろしい出来事の責任を負うという恐れ',
      'con_dirt': '汚れや細菌への懸念',
      'con_bodily': '排泄物や分泌物への嫌悪',
      'con_chemicals': '家庭用薬品や洗剤への懸念',
      'con_ill': '汚染によって病気になるという恐れ',
      'con_spread': '他の人に汚染を広げるという恐れ',
      'con_sticky': '粘着物や残留物が気になる',
      'sex_forbidden': '禁じられた、または望まない性的な考えやイメージ',
      'sex_others': '自分を苦しめる、他の人に関する性的な考え',
      'sex_orientation': '性的指向についての望まない疑い',
      'sex_aggressive': '他の人への攻撃的な性的思考',
      'hoard_discard': '必要になるかもしれない物を捨てる恐れ',
      'hoard_value': '物に手放せない価値があると感じる',
      'rel_sacrilege': '冒とくや神聖を汚すことへの懸念',
      'rel_rightwrong': '正誤や道徳への過度の懸念',
      'rel_punish': '神や運命から罰を受ける恐れ',
      'sym_even': '物を均等、対称、または「ちょうどよい」状態にする必要',
      'sym_exact': '正確さ、秩序、精密さの必要',
      'sym_incomplete': '正しく感じるまで続く不完全感',
      'som_illness': '病気への過度の懸念',
      'som_body': '身体の一部や外見への過度の懸念',
      'misc_know': '物事を知る、または覚えている必要',
      'misc_saywrong': '間違ったことを言う恐れ',
      'misc_lucky': '幸運・不運と感じる数字、言葉、色',
      'misc_sounds': '止められない侵入的な音、言葉、音楽',
      'misc_lose': '物をなくす恐れ',
      'wash_hands': '過度または儀式的な手洗い',
      'wash_shower': '過度のシャワー、入浴、身だしなみ',
      'wash_clean': '家庭用品の過度の清掃',
      'wash_avoid': '汚染されていると感じる物を避ける',
      'chk_locks': '鍵、電化製品、蛇口、コンロを確認する',
      'chk_harm': '誰かを傷つけなかった、または傷つけないと確認する',
      'chk_mistake': '間違いをしていないと確認する',
      'chk_body': '病気の兆候がないか身体を確認する',
      'rep_reread': '読み直しや書き直し',
      'rep_routine': 'ドアを通る、上り下りするなどの日常動作を繰り返す',
      'rep_untilright': '「ちょうどよい」と感じるまで繰り返す',
      'cnt_count': '物、歩数、行動を数える',
      'cnt_numbers': '決まった回数だけ行う',
      'ord_arrange': '対称または正確になるまで物を並べる',
      'ord_align': '物を繰り返し揃えたり真っすぐにしたりする',
      'mc_mental': '黙とう、言葉、振り返りなどの心の中の儀式',
      'mc_reassure': '安心を求めたり告白したりすることを繰り返す',
      'mc_touch': '物に触れたり、たたいたり、こすったりする必要',
      'mc_lists': '過度にリストを作る',
      'mc_avoid': '衝動を避けるために状況を回避する',
      'other': 'その他の症状',
    });
    return '$_temp0';
  }

  @override
  String ybocsSeverityBlurb(String severity) {
    String _temp0 = intl.Intl.selectLogic(severity, {
      'subclinical': 'この合計点はY-BOCSの臨床閾値未満の範囲です。結果は一時点の記録で、診断ではありません。',
      'mild': 'この合計点はY-BOCSの軽度範囲です。結果は一時点の記録で、診断ではありません。',
      'moderate': 'この合計点はY-BOCSの中等度範囲です。結果は一時点の記録で、診断ではありません。',
      'severe': 'この合計点はY-BOCSの重度範囲です。生活への影響を資格を持つ専門家に相談することを検討してください。',
      'extreme':
          'この合計点はY-BOCSの最重度範囲です。資格を持つ専門家への相談を検討してください。差し迫った危険がある場合は、地域の緊急サービスに連絡してください。',
      'other': 'この記録された合計点は一時点の記録で、診断ではありません。',
    });
    return '$_temp0';
  }

  @override
  String behavioralExperimentText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '行動実験',
      'newAction': '新規',
      'subtitle': 'OCDの予測と、予定した行動の後に観察したことを比べます。',
      'loadError': '行動実験を読み込めませんでした。もう一度お試しください。',
      'deleteTitle': 'この行動実験を削除しますか？',
      'deleteBody': 'この行動実験を端末から完全に削除します。',
      'cancel': 'キャンセル',
      'deleteAction': '削除',
      'deleteTooltip': '行動実験を削除',
      'deleteSuccess': '行動実験を削除しました。',
      'deleteError': 'この行動実験を削除できませんでした。もう一度お試しください。',
      'statusPlanned': '予定',
      'statusCompleted': '完了',
      'outcomeLabel': '実際に起きたこと',
      'learningLabel': '自分のメモ',
      'recordAction': '起きたことを記録',
      'emptyTitle': '行動実験を計画する',
      'emptyBody': 'OCDの予測と小さな行動を書き、後で観察したことを記録します。',
      'emptyAction': '新しい行動実験',
      'outcomeEditorTitle': '起きたことを記録',
      'newEditorTitle': '新しい行動実験',
      'predictedLabel': 'OCDの予測',
      'testActionLabel': '予定した行動',
      'outcomeInputLabel': '実際に何が起きましたか？',
      'outcomeInputHint': '結果を評価せず、観察したことを記録します',
      'learningInputLabel': 'メモしておきたいことはありますか？（任意）',
      'learningInputHint': '覚えておきたいこと',
      'predictionInputLabel': 'OCDは何が起きると予測していますか？',
      'predictionInputHint': '例：もう一度確認しなければ、家が水浸しになる',
      'confidenceQuestion': 'その予測はどのくらい確かに感じますか？',
      'experimentInputLabel': '予測を確かめるために何をしますか？',
      'experimentInputHint': '例：通常の確認を1回して出かけ、その後を観察する',
      'saveOutcome': '観察を保存',
      'saveExperiment': '行動実験を保存',
      'outcomeValidation': '観察したことを短く入力してください。',
      'planValidation': 'OCDの予測と、予定している行動の両方を入力してください。',
      'outcomeSaveSuccess': '観察を保存しました。',
      'planSaveSuccess': '行動実験を保存しました。実行後に起きたことを記録できます。',
      'saveError': 'この行動実験を保存できませんでした。入力した内容は残っています。もう一度お試しください。',
      'other': '行動実験',
    });
    return '$_temp0';
  }

  @override
  String behavioralExperimentConfidence(String percent) {
    return '確信度$percent';
  }

  @override
  String behavioralExperimentCardSummary(
    String status,
    String date,
    String confidence,
    String prediction,
    String experiment,
  ) {
    return '$status・$date・$confidence。予測：$prediction。予定した行動：$experiment。';
  }

  @override
  String exposureReflectionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '曝露の振り返り',
      'newAction': '新規',
      'subtitle': '曝露の後に気づいたことを記録します。役立つと感じる内容だけを追加してください。',
      'loadError': '現在、振り返りを表示できません。もう一度お試しください。',
      'deleteTitle': 'この振り返りを削除しますか？',
      'deleteBody': 'この端末から振り返りが完全に削除されます。',
      'cancel': 'キャンセル',
      'deleteAction': '削除',
      'deleteTooltip': '振り返りを削除',
      'deleteSuccess': '振り返りを削除しました。',
      'deleteError': 'この振り返りを削除できませんでした。もう一度お試しください。',
      'emptyTitle': '曝露を振り返る',
      'emptyBody': '何が起きたか、OCDが何を予測したか、覚えておきたいことを記録します。必須なのは最初の質問だけです。',
      'emptyAction': '新しい振り返り',
      'editorTitle': '新しい振り返り',
      'whatHappenedLabel': '何が起きましたか？',
      'whatHappenedHint': '行った曝露や練習',
      'predictionLabel': 'OCDは何を予測しましたか？',
      'predictionHint': 'OCDが起きるかもしれないと告げた結果',
      'actualLabel': '何を観察しましたか？',
      'actualHint': '曝露中または曝露後に起きたこと',
      'learningLabel': '覚えておきたいことはありますか？（任意）',
      'learningHint': '後で役立つかもしれない内容',
      'nextTimeLabel': '変えてみたいことはありますか？（任意）',
      'nextTimeHint': '思い浮かばなければ空欄のままで構いません',
      'saveAction': '振り返りを保存',
      'validation': 'まず、何が起きたかを短く入力してください。その他の質問は任意です。',
      'saveSuccess': '振り返りを保存しました。',
      'saveError': 'この振り返りを保存できませんでした。入力した内容は残っています。もう一度お試しください。',
      'other': '曝露の振り返り',
    });
    return '$_temp0';
  }

  @override
  String exposureReflectionCardSummary(String date, String whatHappened) {
    return '$date。何が起きたか：$whatHappened。';
  }

  @override
  String implementationIntentionText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': 'もし〜ならプラン',
      'newAction': '新規',
      'subtitle': 'ある状況と、そのとき試したい対応を組み合わせます。',
      'loadError': '現在、もし〜ならプランを表示できません。もう一度お試しください。',
      'deleteTitle': 'このもし〜ならプランを削除しますか？',
      'deleteBody': 'この端末からプランが完全に削除されます。',
      'cancel': 'キャンセル',
      'deleteAction': '削除',
      'deleteTooltip': 'もし〜ならプランを削除',
      'deleteSuccess': 'もし〜ならプランを削除しました。',
      'deleteError': 'このもし〜ならプランを削除できませんでした。もう一度お試しください。',
      'emptyTitle': 'もし〜ならプランを作る',
      'emptyBody': '状況と、その状況になったときに試したい対応を記録します。',
      'emptyAction': '新しいもし〜ならプラン',
      'editorTitle': '新しいもし〜ならプラン',
      'triggerLabel': 'もし…',
      'triggerHint': '状況（例：安心を求めたい衝動に気づいたとき）',
      'responseLabel': 'そのとき私は…',
      'responseHint': '試したい対応（例：今気づいていることを書き留める）',
      'saveAction': 'もし〜ならプランを保存',
      'validation': '状況と、試したい対応の両方を入力してください。',
      'saveSuccess': 'もし〜ならプランを保存しました。',
      'saveError': 'このもし〜ならプランを保存できませんでした。入力した内容は残っています。もう一度お試しください。',
      'other': 'もし〜ならプラン',
    });
    return '$_temp0';
  }

  @override
  String implementationIntentionStatement(String trigger, String response) {
    return 'もし$triggerなら、$response。';
  }

  @override
  String uncertaintyTrainingText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '不確かさの練習',
      'subtitle': '分からないままにしておく練習をします。',
      'loadError': '現在、練習回数を表示できません。各練習はそのまま開けます。',
      'whyLabel': 'この練習について',
      'willingnessLabel': '分からないままにしておく意思はどのくらいありましたか？',
      'noteLabel': 'メモ（任意）',
      'noteHint': '何に気づきましたか？',
      'saveAction': 'この練習を記録',
      'saveSuccess': '練習を記録しました。',
      'saveError': 'この練習を記録できませんでした。入力したメモは残っています。もう一度お試しください。',
      'other': '不確かさの練習',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseTitle(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe': 'そうかもしれないし、違うかもしれない',
      'unanswered': '答えを出さない',
      'resist': '確かさ探しをいったん止める',
      'other': '不確かさの練習',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseIntro(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe': 'OCDが確かさを求めたときは、「そうかもしれないし、違うかもしれない」と答え、していたことに注意を戻してみます。',
      'unanswered': '繰り返し浮かぶ質問を解決せず、答えを出さないままにします。',
      'resist': '確認する、検索する、安心を求める衝動に気づき、この練習では従わないことを選びます。',
      'other': '不確かさがあるままにしておく練習です。',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExerciseWhy(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe': '安心材料を付け加えず、質問を未解決のままにしておく練習です。',
      'unanswered': '質問に答えを出さず、開いたままにしておく練習です。',
      'resist': '確かさを探さないことを意図的に練習し、その実施を記録します。',
      'other': '不確かさがある状態に余地を作るためのセルフヘルプ練習です。',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyExercisePrompt(String exercise) {
    String _temp0 = intl.Intl.selectLogic(exercise, {
      'maybe': '心配事を一つ選び、「そうかもしれないし、違うかもしれない」と答えます。結論を出そうとせず、今あるものに気づきます。',
      'unanswered': '普段なら答えを出す質問を一つ選び、この練習では答えを出さないままにします。',
      'resist': '確かさを求める衝動を一つ見つけ、この練習では答えを出さないままにします。',
      'other': '不確かさを未解決のままにする小さな方法を一つ選びます。',
    });
    return '$_temp0';
  }

  @override
  String uncertaintyPracticeCount(int count) {
    return '$count回の練習';
  }

  @override
  String uncertaintyExerciseSummary(String title, String intro) {
    return '$title。$intro';
  }

  @override
  String uncertaintyExerciseSummaryWithCount(
    String title,
    String intro,
    int count,
  ) {
    return '$title。$intro 記録した練習は$count回です。';
  }

  @override
  String uncertaintyWillingness(int value) {
    return '意思の度合い：10段階中$value';
  }

  @override
  String actionPlanText(String key) {
    String _temp0 = intl.Intl.selectLogic(key, {
      'title': '行動プラン',
      'newAction': '新規',
      'subtitle': '状況と、そのときに試したい対応を記録します。',
      'loadError': '現在、行動プランを表示できません。もう一度お試しください。',
      'deleteTitle': 'この行動プランを削除しますか？',
      'deleteBody': 'この端末からプランが完全に削除されます。',
      'cancel': 'キャンセル',
      'deleteAction': '削除',
      'deleteTooltip': '行動プランを削除',
      'deleteSuccess': '行動プランを削除しました。',
      'deleteError': 'この行動プランを削除できませんでした。もう一度お試しください。',
      'statePlanned': '予定',
      'stateCompleted': '完了として記録',
      'toggleMarkComplete': '行動プランを完了として記録',
      'toggleMarkIncomplete': '行動プランを未完了として記録',
      'toggleSuccessComplete': '行動プランを完了として記録しました。',
      'toggleSuccessIncomplete': '行動プランを未完了として記録しました。',
      'toggleError': 'この行動プランを更新できませんでした。以前の状態を表示しています。もう一度お試しください。',
      'emptyTitle': '行動プランを作る',
      'emptyBody': '状況と、その状況になったときに試したい対応を記録します。',
      'emptyAction': '新しい行動プラン',
      'editorTitle': '新しい行動プラン',
      'situationLabel': 'OCDが現れたとき',
      'situationHint': '例：症状について検索したい衝動に気づいたとき',
      'actionLabel': '試したい対応',
      'actionHint': '例：検索するか決める前に15分待つ',
      'dateLabel': '日付（任意）',
      'pickDate': '日付を選択',
      'clearDate': '日付を削除',
      'notesLabel': 'メモ（任意）',
      'notesHint': '覚えておきたいこと',
      'saveAction': '行動プランを保存',
      'validation': '状況と、試したい対応の両方を入力してください。',
      'saveSuccess': '行動プランを保存しました。',
      'saveError': 'この行動プランを保存できませんでした。入力した内容は残っています。もう一度お試しください。',
      'other': '行動プラン',
    });
    return '$_temp0';
  }

  @override
  String actionPlanCardSummary(String status, String situation, String action) {
    return '$status。状況：$situation。予定した対応：$action。';
  }

  @override
  String actionPlanDateSummary(String date) {
    return '予定日：$date。';
  }
}
