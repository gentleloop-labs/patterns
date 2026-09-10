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
}
