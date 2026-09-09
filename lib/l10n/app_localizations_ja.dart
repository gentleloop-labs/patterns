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
}
