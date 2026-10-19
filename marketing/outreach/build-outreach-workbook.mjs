import fs from "node:fs/promises";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const outputDir = "/Users/batman/gentleloop-labs/patterns/outputs/patterns-outreach-2026-09-04";
const previewDir = "/tmp/patterns-outreach-previews";
await fs.mkdir(outputDir, { recursive: true });
await fs.mkdir(previewDir, { recursive: true });

const wb = Workbook.create();
const brief = wb.worksheets.add("Start Here");
const targetsSheet = wb.worksheets.add("Targets");
const queueSheet = wb.worksheets.add("30-Day Queue");
const pitchesSheet = wb.worksheets.add("Pitch Library");
const kitSheet = wb.worksheets.add("Press Kit");
const sourcesSheet = wb.worksheets.add("Sources");

const C = {
  ink: "#17213A",
  muted: "#5F6B7A",
  navy: "#23395D",
  teal: "#2A7F72",
  mint: "#DDF3EC",
  blue: "#DDEBFA",
  sand: "#F5EBD8",
  rose: "#F9E0E3",
  lavender: "#E9E3F5",
  line: "#D5DCE5",
  white: "#FFFFFF",
  bg: "#F7F9FC",
  amber: "#F5B942",
  red: "#B84242",
  green: "#2E7D5A",
};
const fontFamily = "Aptos";

function styleTitle(sheet, range, title, subtitle) {
  sheet.mergeCells(range);
  const r = sheet.getRange(range);
  r.values = [[`${title}\n${subtitle}`]];
  r.format = {
    fill: C.navy,
    font: { name: fontFamily, size: 20, bold: true, color: C.white },
    wrapText: true,
    verticalAlignment: "center",
  };
  r.format.rowHeight = 56;
}

function styleHeader(range) {
  range.format = {
    fill: C.navy,
    font: { name: fontFamily, size: 10, bold: true, color: C.white },
    wrapText: true,
    verticalAlignment: "center",
  };
  range.format.rowHeight = 30;
}

function bodyFont(sheet, range) {
  sheet.getRange(range).format.font = { name: fontFamily, size: 10, color: C.ink };
}

function setWidths(sheet, widths) {
  for (const [col, width] of Object.entries(widths)) sheet.getRange(`${col}:${col}`).format.columnWidth = width;
}

const targets = [
  [1,"Tier 1","Apple App Store Featuring","Store editorial","App Store Connect → Apps → Patterns → Featuring → Nominations","Editorial story / collection","Official direct path to store-level discovery; 1.9 is fresh enough to nominate.","Lived experience shaped a private OCD app designed to support practice without becoming another checking ritual.",5,5,5,5,0,"Not contacted","https://developer.apple.com/help/app-store-connect/manage-featuring-nominations/nominate-your-app-for-featuring/","Submit at least 3 weeks ahead; use 2026-10-10 through OCD Awareness Week."],
  [2,"Tier 1","TapSmart","App review","tomjrolfe@intelligenti.com","Review / apps roundup","App reviews and roundups are explicitly its bread and butter; iOS audience is download-ready.","A private, no-account OCD journal with a one-time unlock and transparent on-device data model.",5,4,5,5,0,"Not contacted","https://www.tapsmart.com/tapsmart-apps/contributions-faq/","Send media pack and review access; outlet states ~150k monthly users."],
  [3,"Tier 1","The Verge — Installer","Download newsletter","installer@theverge.com (validate in a current issue before send)","Newsletter mention","Installer is built around useful things to download, watch, read, and explore.","An OCD app deliberately designed to be put down: local-first tracking without a cloud account.",4,5,4,5,0,"Not contacted","https://www.theverge.com/pages/installer-newsletter-sign-up","Very high upside, low odds; email route is reproduced in current issues but should be rechecked."],
  [4,"Tier 1","AppBrain Featured Apps","Android discovery","https://www.appbrain.com/product/featured → Submit Your App","Featured-app card","Free, scheduled Android homepage placement; outlet claims 3M+ monthly visitors.","Schedule the feature for World Mental Health Day or OCD Awareness Week.",5,5,5,5,0,"Not contacted","https://www.appbrain.com/product/featured","Requires claimed developer account and reasonable rating; claim is outlet-stated."],
  [5,"Tier 1","TechRadar — apps/wellbeing","Consumer tech press","news@techradar.com; ideally personalize to a current apps/wellbeing writer","Hands-on review / interview","Recent coverage includes wellness apps and mental-health-app privacy risk.","What a mental-health app can keep off the cloud—and why that matters for intrusive thoughts.",4,5,4,5,0,"Not contacted","https://www.techradar.com/how-to/contact-us","Do not pitch a founder-written 'independent' review; offer interview/demo and experts."],
  [6,"Tier 1","SELF — Jessica Firger","Health editorial","jessica_firger@condenast.com","Commissioned personal essay","Current guidelines accept condition-specific service and health personal essays under ~1,000 words.","I built an OCD tracker—then realized tracking itself can become a compulsion.",5,5,4,5,0,"Not contacted","https://www.self.com/story/how-to-pitch-a-story-to-self","Disclose founder interest immediately; article must solve a reader problem, not sell the app."],
  [7,"Tier 1","Made of Millions","OCD advocacy media","https://www.madeofmillions.com/contact","Interview / collaboration article","OCD-aware advocacy nonprofit seeks writers and advocates; states 3M+ sufferers reached yearly.","How lived experience, privacy, and anti-reassurance design changed the product.",5,4,5,5,0,"Not contacted","https://www.madeofmillions.com/contact","Pitch community value and transparency; reach figure is outlet-stated."],
  [8,"Tier 1","Psych Central OCD Resource Directory","High-intent health resource","Article feedback + healthline.readers@rvohealth.com","Resource-list update","Its 2021 directory still lists Live OCD Free; readers are already looking for OCD apps.","Offer Patterns as an additional current resource, with limitations and privacy evidence.",5,5,3,5,0,"Not contacted","https://psychcentral.com/ocd/ocd-resources","Ask for editorial evaluation, not a swap; no guarantee the inbox routes to the editor."],
  [9,"Tier 1","MacStories / AppStories","Apple app press","voorhees@macstories.net","App Radar / App Debuts / podcast mention","Managing editor John Voorhees covers apps and indie software extensively.","A health app whose trust story is visible in source code and a local-first architecture.",4,4,4,4,0,"Not contacted","https://www.macstories.net/author/johnvoorhees/","Apple-only readership, but high credibility and app affinity."],
  [10,"Tier 1","International OCD Foundation","OCD community editorial","https://iocdf.org/get-involved/share-your-story/stories/","Personal story / quarterly newsletter","Formal year-round route; publishes one story weekly; exact audience fit.","What building for my own OCD taught me about tracking, uncertainty, and when to stop measuring.",5,4,5,5,0,"Not contacted","https://iocdf.org/get-involved/share-your-story/stories/","≤1,000 words; no medical advice; do not assume a product link."],
  [11,"Tier 1","The Mighty","Lived-experience editorial","https://themighty.com/submit-a-story/","Contributor story","Explicitly allows stories about independent businesses when useful and non-promotional.","The tracker paradox: when a self-help habit becomes another ritual.",5,4,4,4,0,"Not contacted","https://themighty.com/mighty-contributor-faqs/","400–1,200 words; large backlog and often 6+ months, so not an immediate spike."],
  [12,"Tier 1","Mind / ORCHA App Library","Health app assessment","suppliersuccess@orchahealth.com","App assessment / library listing","Formal developer intake for mental-health apps; emphasizes safety, privacy, and usability.","Ask whether a local-first self-guided OCD companion is in scope and what evidence is required.",5,4,5,4,0,"Not contacted","https://mind.orchahealth.com/en-GB","Ask fees, geography, evidence, and timeline before applying."],
  [13,"Tier 2","Product Hunt","Product discovery","https://www.producthunt.com/launch (self-post)","Launch page","Direct product discovery and social proof; official guidance favors maker-led launches.","Patterns 1.9: private OCD journaling and ERP practice without an account or subscription.",3,5,5,4,0,"Not contacted","https://help.producthunt.com/en/articles/479557-how-to-post-a-product","Broad tech audience; coordinate supporters ethically and never ask for upvotes."],
  [14,"Tier 2","9to5Mac","Apple news","tips@9to5mac.com","App news / hands-on mention","Large Apple-focused audience and active app coverage.","Local-first mental-health data and an indie, one-time-purchase alternative to subscriptions.",3,5,4,4,0,"Not contacted","https://9to5mac.com/contact/","Needs a crisp timely reason: 1.9 + October awareness hook."],
  [15,"Tier 2","OCD-UK — Compulsive Reading","OCD member magazine","magazine@ocduk.org","Member-magazine article","Exact audience; magazine seeks first-person OCD and ERP contributions.","When measurement helps in ERP—and when it turns into another compulsion.",5,3,5,5,0,"Not contacted","https://www.ocduk.org/the-ocd-magazine-get-involved/","Ask for current theme/deadline first; old page cites ~1,250 words."],
  [16,"Tier 2","TIME — Jamie Ducharme","National health press","Use TIME tips/contact route; reference author profile","Reported health story source","Health correspondent covers mental health; high upside if framed as a broader design/privacy story.","The overlooked risk of turning mental-health tracking into compulsive checking.",4,5,2,5,0,"Not contacted","https://time.com/author/jamie-ducharme/","Offer Aftaab as a source plus independent OCD clinicians/researchers; do not demand an app feature."],
  [17,"Tier 2","OCD Whisperer","OCD podcast/community","info@theocdwhisperer.com / guest request","Podcast interview","Niche audience and accepts lived-experience/advocacy conversations.","Building a tool for OCD without feeding reassurance or certainty-seeking.",5,3,4,4,0,"Not contacted","https://theocdwhisperer.com/","Prepare three non-promotional takeaways and share the episode."],
  [18,"Tier 2","OCD Insights","OCD podcast","https://www.ocdinsights.com/podcast guest form","Podcast interview","Dedicated OCD audience; guest form includes lived experience and advocates.","What product design gets wrong about compulsive tracking.",5,3,4,4,0,"Not contacted","https://www.ocdinsights.com/podcast","Lead with listener value; app mention is secondary."],
  [19,"Tier 2","YourStory","India startup press","https://yourstory.com/submit-a-story","Founder profile / product story","Has covered India-based mental-health startups and offers a Pitch To Us route.","An India-built, lived-experience OCD app choosing privacy and one-time pricing.",4,4,4,4,0,"Not contacted","https://yourstory.com/submit-a-story","Use only if Aftaab wants an India-founder angle and can share verifiable traction."],
  [20,"Tier 2","Inc42","India startup press","https://pages.inc42.com/contact-us/","Startup story / news tip","Formal route for startup stories and PR/news.","Why a bootstrapped mental-health app rejected accounts, cloud storage, and subscriptions.",3,4,4,4,0,"Not contacted","https://pages.inc42.com/contact-us/","Verify obfuscated email on page; stronger with India angle and traction/new partnership."],
  [21,"Tier 2","MindApps","Independent app evaluation","https://mindapps.org/ → submit/review form","Structured app review","Users arrive specifically to compare mental-health apps; durable trust placement.","Submit full privacy, safety, pricing, and limitations packet.",5,3,4,3,0,"Not contacted","https://mindapps.org/","May be slower than press; high intent but impact unknown."],
  [22,"Tier 2","Healthify NZ App Library","Health app library","https://healthify.nz/app-library → contact","Clinical/editorial app review","Healthcare-provider-reviewed library has mental-health and OCD categories.","Ask whether international apps are eligible for independent review.",4,3,3,3,0,"Not contacted","https://healthify.nz/app-library","Confirm geography and submission policy before sending a full packet."],
  [23,"Tier 2","Your Anxiety Toolkit","Anxiety/OCD podcast","https://kimberleyquinlan-lmft.com/be-on-the-show/","Podcast guest","Large, highly relevant audience and explicit guest application.","Five design rules for using trackers without feeding OCD reassurance loops.",5,4,3,2,1,"Not contacted","https://kimberleyquinlan-lmft.com/be-on-the-show/","Booked 6+ months; listen first and apply only with prior podcast/video examples."],
  [24,"Tier 2","The OCD Stories","OCD podcast","https://theocdstories.com/ contact","Podcast guest","Very large OCD-specific back catalog and audience.","A candid lived-experience founder conversation about self-help tools and uncertainty.",5,4,2,3,2,"Not contacted","https://theocdstories.com/","Sponsored by direct competitor NOCD; product coverage is unlikely/conflicted."],
  [25,"Tier 2","Cult of Mac","Apple reviews","Review-request email link on official policy page","App review / Awesome Apps","Explicit review policy and Apple app coverage.","A calm, local-first iPhone companion for sensitive OCD journaling.",3,4,3,4,0,"Not contacted","https://www.cultofmac.com/news/cult-of-macs-reviews-policy","Use the current linked address rather than guessing from cached text."],
  [26,"Tier 3","iGeeksBlog","Apple how-to/reviews","info@igeeksblog.com / contact page","App review / roundup","Apple-focused readership and app coverage.","Privacy-first OCD journaling on iPhone with no account.",3,3,4,4,0,"Not contacted","https://www.igeeksblog.com/contact-us/","Verify editorial versus commercial route."],
  [27,"Tier 3","Android Authority","Android press","news@androidauthority.com / contact page","App news / review","Large Android readership and direct news contact.","A local-first Android OCD journal with a free core and no account.",3,4,3,4,0,"Not contacted","https://www.androidauthority.com/contact/","Broad outlet; needs timeliness or data, not a generic app announcement."],
  [28,"Tier 3","Android Central","Android press","Staff/contact route on About page","App feature / review","Active Android app coverage.","Private-by-design alternative to cloud-based mental-health trackers.",3,4,3,4,0,"Not contacted","https://www.androidcentral.com/about","Target a current apps writer; do not bulk-email staff."],
  [29,"Tier 3","MobileBurn","Mobile app discovery","https://mobileburn.com/submit/","Submitted review","Formal app submission route.","Independent review request with store links and media kit.",3,2,5,3,0,"Not contacted","https://mobileburn.com/submit/","Smaller/unverified reach; use as third daily slot, not lead bet."],
  [30,"Tier 3","Touch Reviews","App review site","https://touchreviews.net/request-review/","Review request","Formal review request route and direct app-download audience.","iOS review request emphasizing privacy and OCD-specific workflows.",3,2,5,3,0,"Not contacted","https://touchreviews.net/request-review/","Reach not independently verified."],
  [31,"Tier 3","App Review Central","App review site","https://www.appreviewcentral.net/app-submission/","App of the Day / review","Low-friction submission can create a searchable mention.","Submit polished screenshots, one-sentence hook, and store links.",3,2,5,3,0,"Not contacted","https://www.appreviewcentral.net/app-submission/","Treat as a low-cost experiment, not a core press win."],
  [32,"Tier 3","AppRater","App review site","https://apprater.net/ → Submit App","Review / weekly email","Current app-submission route and newsletter presence.","A private OCD journal built by someone who lives with OCD.",3,2,5,3,0,"Not contacted","https://apprater.net/","Audience size/quality unverified."],
  [33,"Tier 3","Indie App Catalog","Indie app media","https://indieappcatalog.com/news/submit","News article submission","Allows developers to submit an app-news article.","Why Patterns 1.9 made analytics consent clearer and kept content local.",3,2,5,3,0,"Not contacted","https://indieappcatalog.com/news/submit","Use an honest byline/disclosure; not earned independent review."],
  [34,"Tier 3","AlternativeTo","Software directory","AlternativeTo account → Suggest new application","Directory listing","Durable discovery and comparison traffic; formal self-submission.","List as an alternative in OCD journaling / mental-health tracking categories.",3,3,5,3,0,"Not contacted","https://alternativeto.net/faq/","Optional $5 priority review moves queue only; no ranking benefit."],
  [35,"Tier 3","Indie Hackers","Founder community","Founder-authored post; disclose relationship","Founder story","Good for backlinks, feedback, and possible secondary press discovery.","I built an OCD app, then designed against the metrics loop I had created.",2,3,5,4,0,"Not contacted","https://www.indiehackers.com/","Developer-heavy audience; downloads may be low."],
  [36,"Tier 3","Hacker News — Show HN","Tech community","https://news.ycombinator.com/showhn.html","Show HN post","Open-source/local-first architecture can earn discussion and journalist discovery.","Show HN: Patterns, a local-first OCD journal built with Flutter and SQLite.",2,4,5,3,0,"Not contacted","https://news.ycombinator.com/showhn.html","Read rules; be present for questions; health-user fit is indirect."],
  [37,"Tier 3","HackerNoon","Contributed tech media","Contributor portal","Technical article","Can host a deep technical story with a transparent founder byline.","Building private mobile-health analytics without collecting sensitive content.",2,3,4,3,0,"Not contacted","https://hackernoon.com/start-writing","Technical reach, weak direct user fit."],
  [38,"Tier 3","Flutter Awesome","Flutter showcase","Submit GitHub/project through site","Open-source project listing","Patterns is open source and built with Flutter; easy technical discovery.","A production local-first Flutter app for sensitive journaling and offline PDF export.",2,2,4,3,0,"Not contacted","https://flutterawesome.com/","Primarily developer traffic."],
  [39,"Tier 3","MobileAppDaily","Mobile industry publication","editor@mobileappdaily.com","App review / contributed article","Mobile-focused site with a visible editorial route.","Designing privacy and restraint into a sensitive self-help app.",2,3,4,3,0,"Not contacted","https://www.mobileappdaily.com/help/guest-article-submissions","Likely B2B-heavy; avoid paid-review upsell unless separately approved."],
  [40,"Tier 3","TechCrunch","Startup press","tips@techcrunch.com","News tip","Huge reach but app alone is not news.","Pitch only with major launch, research, partnership, or material verified growth.",2,5,3,3,0,"Not contacted","https://techcrunch.com/pages/contact-us/","Do not spend an early slot without a hard news peg."],
  [41,"Tier 3","Mental Movement","Mental-health editorial","hello@mentalmovement.co.uk","Personal story","Accepts personal mental-health stories of roughly 500–1,500 words.","The moment I realized my tracker could become another OCD ritual.",4,2,4,3,0,"Not contacted","https://www.mentalmovement.co.uk/pitch-personal-stories/","Confirm whether a transparent app link is allowed."],
  [42,"Tier 3","MyndStories","Mental-health stories","content@myndstories.com","Personal essay / interview","Invites impact-driven mental-health stories and interviews.","Building the tool I needed while refusing to treat lived experience as a growth hack.",4,2,4,3,0,"Not contacted","https://myndstories.com/write-for-us","Ask about commercial-link policy before drafting."],
  [43,"Tier 3","NAMI — Share Your Story","Mental-health nonprofit","https://www.nami.org/stay-connected/share-your-story/","Personal essay","High credibility and lived-experience readership.","A non-promotional essay about OCD, tracking, and learning to tolerate uncertainty.",4,3,4,3,1,"Not contacted","https://www.nami.org/stay-connected/share-your-story/","400–700 words; product mention/link uncertain, so credibility not acquisition."],
  [44,"Tier 3","Google Play Promotional Content","Store discovery","Play Console → Promotional content (only if eligible)","Promotional card / store featuring","Official Android discovery opportunity when eligible.","Tie a meaningful 1.9 event/update to October, not a generic promotion.",4,5,2,4,0,"Not contacted","https://support.google.com/googleplay/android-developer/answer/12932541","Eligibility is conditional; do not claim an editorial nomination route exists for all apps."],
  [45,"Tier 3","Psycurate","Mental-health tool directory","https://psycurate.com/ contact/submit","Directory / article pitch","New privacy-oriented mental-health-tools project may be receptive.","Local-first OCD journaling with explicit non-clinical boundaries.",3,2,3,4,0,"Not contacted","https://psycurate.com/","Very new/unproven reach; validate editorial independence."],
  [46,"Tier 3","Taplist","App discovery","https://www.taplist.so/ submit route","Listing / feature","Claims a builder/app audience and fast discovery.","Indie privacy-first app with clear founder story.",2,2,4,3,0,"Not contacted","https://www.taplist.so/","Reach claims unverified; do not pay without evidence."],
  [47,"Exclude","ADAA Personal Stories","Mental-health nonprofit","Do not use for acquisition","Personal story","Excellent audience fit, but current rules prohibit references to products and websites.","None for this campaign.",5,3,5,4,3,"Do not contact now","https://adaa.org/understand-anxiety-depression/share-your-story","Use only for a truly non-promotional story with no Patterns reference."],
  [48,"Exclude","Mind — general personal stories","Mental-health nonprofit","Do not use; use Mind/ORCHA instead","Personal story","General story route removes promotional/commercial links.","None for acquisition.",4,3,4,3,3,"Do not contact now","https://www.mind.org.uk/information-support/your-stories/telling-your-story-blogging-or-vlogging-for-mind/","Separate app-library route is already ranked #12."],
  [49,"Exclude","Rethink Mental Illness stories","Mental-health nonprofit","Do not use for acquisition","Personal story","Story policy does not allow product endorsement/advertising.","None for acquisition.",4,2,4,3,3,"Do not contact now","https://www.rethink.org/get-involved/campaign-with-us/share-your-story/","Potential mission relationship later, not cold acquisition."],
  [50,"Monitor","Psyche","Psychology editorial","Monitor pitching page","Commissioned article","Strong editorial fit, but pitching is currently closed.","Revisit the tracking-as-compulsion essay when submissions reopen.",4,4,1,3,1,"Closed — monitor","https://psyche.co/pitch","Do not send while closed."],
];

// Start Here
brief.showGridLines = false;
brief.tabColor = C.teal;
styleTitle(brief, "A1:H2", "PATTERNS EARNED-MEDIA CAMPAIGN", "Research-backed target list · 2–3 outreach actions per weekday · prepared 4 Sep 2026");
brief.getRange("A4:H4").values = [["Campaign objective","Earn a credible article, review, store feature, or resource mention that can produce and sustain material daily downloads—not vanity backlinks.",null,null,null,null,null,null]];
brief.mergeCells("B4:H4");
brief.getRange("A4:H4").format = { fill: C.mint, font: { name: fontFamily, size: 11, bold: true, color: C.ink }, wrapText: true, verticalAlignment: "center" };
brief.getRange("A4:H4").format.rowHeight = 46;

brief.getRange("A6:H6").values = [["Live campaign snapshot",null,null,null,null,null,null,null]];
brief.mergeCells("A6:H6");
styleHeader(brief.getRange("A6:H6"));
brief.getRange("A7:H9").values = [
  ["Researched targets",null,"Ready / not contacted",null,"Do not contact",null,"Primary event",null],
  [null,null,null,null,null,null,"World Mental Health Day",new Date(2026,9,10)],
  ["Scoring","Fit 35% · impact 30% · access 20% · timing 15% · conflict penalty","Rule","After 20 pitches <10% replies → rewrite opening","Rule","After 40 pitches <5% qualified interest → change story","OCD Awareness Week","Second full week of October"],
];
brief.mergeCells("A7:B7"); brief.mergeCells("C7:D7"); brief.mergeCells("E7:F7"); brief.mergeCells("G7:H7");
brief.getRange("A8").formulas = [[`=COUNTA(Targets!C2:C${targets.length + 1})`]];
brief.getRange("C8").formulas = [[`=COUNTIF(Targets!O2:O${targets.length + 1},"Not contacted")`]];
brief.getRange("E8").formulas = [[`=COUNTIF(Targets!O2:O${targets.length + 1},"Do not contact now")`]];
brief.mergeCells("A8:B8"); brief.mergeCells("C8:D8"); brief.mergeCells("E8:F8");
brief.getRange("A7:H9").format.wrapText = true;
brief.getRange("A7:H7").format = { fill: C.blue, font: { name: fontFamily, bold: true, color: C.navy }, verticalAlignment: "center" };
brief.getRange("A8:F8").format = { font: { name: fontFamily, size: 20, bold: true, color: C.teal }, verticalAlignment: "center" };
brief.getRange("H8").format.numberFormat = "d mmm yyyy";
brief.getRange("A9:H9").format = { fill: C.bg, font: { name: fontFamily, size: 9, color: C.muted }, wrapText: true, verticalAlignment: "center" };
brief.getRange("A9:H9").format.rowHeight = 44;

brief.getRange("A11:H11").values = [["DO THESE FIRST — 4 SEP 2026",null,null,null,null,null,null,null]];
brief.mergeCells("A11:H11"); styleHeader(brief.getRange("A11:H11"));
brief.getRange("A12:H15").values = [
  ["Priority","Target","Exact action","Why now","Owner","Status","Deadline","Source"],
  [1,"Apple App Store Featuring","Submit 1.9 App Enhancement nomination for 10–18 Oct; use the draft in Pitch Library.","Apple recommends ≥3 weeks; this window is closing.","Aftaab","Not started",new Date(2026,8,4),"Apple featuring help"],
  [2,"AppBrain Featured Apps","Claim developer account and request an Oct 10/awareness-week feature day.","Free, scheduled, Android-intent traffic.","Aftaab","Not started",new Date(2026,8,4),"AppBrain program"],
  [3,"TapSmart","Email Tom Rolfe with 75-word personal note, press kit, screenshots, and review link.","Explicit review/roundup route and a qualified iOS audience.","Aftaab","Not started",new Date(2026,8,4),"TapSmart FAQ"],
];
styleHeader(brief.getRange("A12:H12"));
brief.getRange("A13:H15").format = { font: { name: fontFamily, size: 10, color: C.ink }, wrapText: true, verticalAlignment: "center" };
brief.getRange("A13:H15").format.rowHeight = 48;
brief.getRange("G13:G15").format.numberFormat = "d mmm";

brief.getRange("A17:H17").values = [["THE STORY THAT CAN TRAVEL",null,null,null,null,null,null,null]];
brief.mergeCells("A17:H17"); styleHeader(brief.getRange("A17:H17"));
brief.mergeCells("A18:H20");
brief.getRange("A18:H20").values = [["“I live with OCD and built a private tracker—then had to confront the fact that tracking itself can become another checking ritual. Here is what designing against reassurance loops changed.”\n\nSupporting proof: no account, sensitive content stays on-device, optional anonymous analytics are off by default, the app is open source, core tools are free, and Pro is one purchase rather than a subscription."]];
brief.getRange("A18:H20").format = { fill: C.lavender, font: { name: fontFamily, size: 13, italic: true, color: C.ink }, wrapText: true, verticalAlignment: "center" };
brief.getRange("A18:H20").format.rowHeight = 48;

brief.getRange("A22:H22").values = [["PRE-SEND TRUST GATE",null,null,null,null,null,null,null]];
brief.mergeCells("A22:H22"); styleHeader(brief.getRange("A22:H22"));
brief.getRange("A23:H28").values = [
  ["Gate","Why it matters","Current finding","Decision / action",null,null,"Owner","Status"],
  ["Press kit","Editors need usable assets in one click.","No dedicated media kit found in the repository.","Create public folder/page: icon, founder photo, 6 screenshots/platform, 20–30s demo, facts, privacy, links.",null,null,"Aftaab","Required"],
  ["Google privacy URL","Privacy is the main hook.","Play listing shows patterns.maskedsyntax.com as privacy policy.","Point to patternsocd.com/privacy or confirm redirect and consistency.",null,null,"Aftaab","Review"],
  ["Google deletion label","Could undermine trust.","Store says “Data can’t be deleted.”","Verify Play Console declaration and explain local deletion clearly if accurate.",null,null,"Aftaab","Review"],
  ["Apple accessibility","A featuring consideration.","Apple says no accessibility features declared.","Audit supported features and declare only what is genuinely implemented.",null,null,"Aftaab","Review"],
  ["Attribution","Needed to know what caused installs.","No outlet-specific links documented.","Create per-outlet UTM links and record store-click/install baselines before send.",null,null,"Aftaab","Required"],
];
styleHeader(brief.getRange("A23:H23"));
for (const row of [24,25,26,27,28]) brief.mergeCells(`D${row}:F${row}`);
brief.getRange("A24:H28").format = { font: { name: fontFamily, size: 10, color: C.ink }, wrapText: true, verticalAlignment: "center" };
brief.getRange("A24:H28").format.rowHeight = 50;
brief.getRange("H24:H28").format = { fill: C.rose, font: { name: fontFamily, bold: true, color: C.red }, verticalAlignment: "center" };

brief.getRange("A30:H30").values = [["Success is measured, not promised",null,null,null,null,null,null,null]];
brief.mergeCells("A30:H30"); styleHeader(brief.getRange("A30:H30"));
brief.mergeCells("A31:H34");
brief.getRange("A31:H34").values = [["No publication can guarantee hundreds of downloads per day. Track attributed store installs (or store clicks), reply rate, qualified interest, placements, and the 7-day post-publication average. If one placement produces 100+ attributable downloads in a day, pause low-fit outreach for 48 hours, capture the data, and use that proof in the next tier of pitches. One personalized follow-up after 5 business days; a second only when there is genuinely new information."]];
brief.getRange("A31:H34").format = { fill: C.sand, font: { name: fontFamily, size: 11, color: C.ink }, wrapText: true, verticalAlignment: "center" };
setWidths(brief, {A:14,B:22,C:16,D:24,E:16,F:20,G:18,H:22});

// Targets
targetsSheet.showGridLines = false;
targetsSheet.tabColor = C.navy;
const targetHeaders = ["Rank","Tier","Target / outlet","Lane","Contact / route","Format","Why it fits","Best angle","Fit\n1–5","Impact\n1–5","Access\n1–5","Timing\n1–5","Conflict\n0–3","Priority\n0–100","Status","First sent","Next follow-up","Reply / outcome","Placement URL","Attrib. clicks","Attrib. installs","Primary source","Evidence / caution"];
targetsSheet.getRange("A1:W1").values = [targetHeaders];
styleHeader(targetsSheet.getRange("A1:W1"));
const targetRows = targets.map(r => [...r.slice(0,13), null, ...r.slice(13,14), null, null, null, null, null, null, ...r.slice(14)]);
targetsSheet.getRange(`A2:W${targetRows.length + 1}`).values = targetRows;
targetsSheet.getRange("N2").formulas = [["=ROUND(((I2*35)+(J2*30)+(K2*20)+(L2*15))/5-(M2*10),0)"]];
targetsSheet.getRange(`N2:N${targetRows.length + 1}`).fillDown();
targetsSheet.getRange("Q2").formulas = [["=IF(P2=\"\",\"\",P2+7)"]];
targetsSheet.getRange(`Q2:Q${targetRows.length + 1}`).fillDown();
targetsSheet.getRange(`P2:Q${targetRows.length + 1}`).format.numberFormat = "d mmm yyyy";
bodyFont(targetsSheet, `A2:W${targetRows.length + 1}`);
targetsSheet.getRange(`A2:W${targetRows.length + 1}`).format.wrapText = true;
targetsSheet.getRange(`A2:W${targetRows.length + 1}`).format.verticalAlignment = "top";
targetsSheet.getRange(`A2:W${targetRows.length + 1}`).format.rowHeight = 74;
for (let i = 0; i < targets.length; i++) {
  const row = i + 2;
  const tier = targets[i][1];
  const fill = tier === "Tier 1" ? C.mint : tier === "Tier 2" ? C.blue : tier === "Exclude" ? C.rose : tier === "Monitor" ? C.sand : (i % 2 ? C.white : C.bg);
  targetsSheet.getRange(`A${row}:W${row}`).format.fill = fill;
}
targetsSheet.getRange(`N2:N${targetRows.length + 1}`).format = { font: { name: fontFamily, bold: true, color: C.teal }, numberFormat: "0" };
targetsSheet.getRange(`V2:W${targetRows.length + 1}`).format.font = { name: fontFamily, size: 9, color: C.muted };
targetsSheet.freezePanes.freezeRows(1);
targetsSheet.freezePanes.freezeColumns(3);
targetsSheet.tables.add(`A1:W${targetRows.length + 1}`, true, "OutreachTargets");
setWidths(targetsSheet, {A:7,B:10,C:26,D:18,E:34,F:22,G:38,H:40,I:8,J:8,K:8,L:8,M:9,N:10,O:18,P:13,Q:15,R:28,S:28,T:12,U:12,V:38,W:42});

// 30-Day Queue
queueSheet.showGridLines = false;
queueSheet.tabColor = C.amber;
styleTitle(queueSheet, "A1:G2", "30-DAY OUTREACH QUEUE", "Three actions each weekday · first wave front-loaded · one measured follow-up, never a blast");
const queueHeaders = ["Day","Date","Action 1","Action 2","Action 3","Daily objective","Rule / checkpoint"];
queueSheet.getRange("A4:G4").values = [queueHeaders]; styleHeader(queueSheet.getRange("A4:G4"));
const queueActions = [
  ["New — Apple App Store Featuring","New — AppBrain Featured Apps","New — TapSmart","Submit the three most direct discovery opportunities.","Do not send until privacy-link/deletion disclosures are reviewed."],
  ["New — The Verge Installer","New — TechRadar","New — MacStories","Lead with download utility and privacy; each opening references recent work.","No attachments except requested assets; use one press-kit link."],
  ["New — SELF","New — Made of Millions","New — The Mighty","Launch the lived-experience essay lane.","Disclose Aftaab built Patterns in the first paragraph."],
  ["New — Psych Central resource update","New — IOCDF story","New — Mind/ORCHA library","Launch durable high-intent and trust routes.","Do not ask IOCDF for a product endorsement."],
  ["New — Product Hunt","New — 9to5Mac","New — OCD-UK magazine","Open broad discovery + a niche editorial lane.","Ask OCD-UK for current theme/deadline before drafting."],
  ["Follow up — Apple (only if action needed)","Follow up — AppBrain","Follow up — TapSmart","Resolve blockers and send one short follow-up.","A follow-up should add an asset or answer—not 'just checking in.'"],
  ["Follow up — Verge Installer","Follow up — TechRadar","Follow up — MacStories","Close first-week app press loop.","If no reply, mark no-response and move on after this follow-up."],
  ["New — OCD Whisperer","New — OCD Insights","New — YourStory (conditional India angle)","Start podcast and India-founder lanes.","For podcasts, list three audience takeaways before mentioning app."],
  ["Follow up — SELF","Follow up — Made of Millions","Follow up — The Mighty","Second touch on lived-experience pitches.","Rewrite if all three openings were identical."],
  ["Follow up — Psych Central","Follow up — IOCDF","Follow up — Mind/ORCHA","Close trust-route first wave.","ORCHA: ask cost, geography, evidence, and timeline."],
  ["New — TIME / Jamie Ducharme","New — MindApps","New — Healthify NZ","Add one moonshot and two durable review routes.","TIME pitch offers broader sources; it is not a product announcement."],
  ["New — Cult of Mac","New — iGeeksBlog","New — Android Authority","Expand platform press with tailored screenshots.","Send iOS or Android-specific assets, never a generic dump."],
  ["New — Android Central","New — MobileBurn","New — Touch Reviews","Fill qualified mobile-review pipeline.","Use smaller sites as experiments; decline undisclosed pay-to-review."],
  ["Follow up — Product Hunt preparation","Follow up — 9to5Mac","Follow up — OCD-UK","Prepare next wave while closing week-two pitches.","Product Hunt is self-posting; do not ask anyone to game votes."],
  ["New — App Review Central","New — AppRater","New — Indie App Catalog","Create low-cost searchable mentions.","Use disclosure on founder-authored submissions."],
  ["Follow up — OCD Whisperer","Follow up — OCD Insights","Follow up — YourStory","Close first podcast/India wave.","If founder location is not part of the story, skip India outlets."],
  ["New — AlternativeTo","New — Indie Hackers","New — Show HN","Launch directory and open-source founder story.","Answer community comments personally; do not cross-post the same copy."],
  ["Follow up — TIME","Follow up — MindApps","Follow up — Healthify NZ","Close moonshot and app-library wave.","No response from TIME is expected; one follow-up maximum."],
  ["New — HackerNoon","New — Flutter Awesome","New — MobileAppDaily","Use technical story as secondary discovery.","Optimize for credibility/backlinks, not immediate OCD-user installs."],
  ["Follow up — Cult of Mac","Follow up — iGeeksBlog","Follow up — Android Authority","Close platform-press second wave.","Add an October asset or 1.9 detail, not the same email."],
  ["New — Mental Movement","New — MyndStories","New — NAMI (credibility only)","Test smaller lived-experience editors.","Confirm commercial-link policy before writing full drafts."],
  ["Follow up — Android Central","Follow up — MobileBurn","Follow up — Touch Reviews","Close mobile-review wave.","Capture any quote only with explicit publication permission."],
  ["New — TechCrunch (only with hard news)","New — Google Play promo (if eligible)","New — Psycurate (experimental)","Use conditional routes only when their gate is met.","If there is no hard news, replace TechCrunch with a second personalized editor pitch."],
  ["Follow up — App Review Central","Follow up — AppRater","Follow up — Indie App Catalog","Close small-site submissions.","Record which sites ask for money; do not pay without audience evidence."],
  ["Follow up — AlternativeTo","Follow up — Indie Hackers thread","Follow up — Show HN thread","Harvest feedback and listings.","Do not bump community posts artificially."],
  ["Follow up — HackerNoon","Follow up — Flutter Awesome","Follow up — MobileAppDaily","Close technical placements.","Turn any accepted technical piece into a clean press-kit clip."],
  ["Follow up — Mental Movement","Follow up — MyndStories","Check — NAMI decision","Close remaining story submissions.","Avoid medical claims; experience is not clinical evidence."],
  ["Second wave — Apple with material update only","Second wave — top responder","New — Taplist (experimental)","Prepare awareness-week amplification.","Only send a second pitch when the news or asset is genuinely new."],
  ["Awareness-week note — top 3 warm leads","Publish founder post on Patterns site","Share press kit with responders","Convert warm interest before the event window.","Use WHO theme accurately; never imply WHO endorsement."],
  ["Campaign review — pause low-fit sends","Pitch proof from any winning placement","Build next 30-day list from responses","Double down on evidence and stop weak channels.","Judge the 7-day average, not a one-day spike."],
];
let d = new Date(2026,8,4);
const queueRows = [];
for (let i = 0; i < 30; i++) {
  while (d.getDay() === 0 || d.getDay() === 6) d.setDate(d.getDate() + 1);
  queueRows.push([i + 1, new Date(d), ...queueActions[i]]);
  d.setDate(d.getDate() + 1);
}
queueSheet.getRange("A5:G34").values = queueRows;
bodyFont(queueSheet, "A5:G34");
queueSheet.getRange("A5:G34").format.wrapText = true;
queueSheet.getRange("A5:G34").format.verticalAlignment = "top";
queueSheet.getRange("A5:G34").format.rowHeight = 64;
queueSheet.getRange("B5:B34").format.numberFormat = "ddd, d mmm";
for (let row = 5; row <= 34; row++) queueSheet.getRange(`A${row}:G${row}`).format.fill = row % 2 ? C.white : C.bg;
queueSheet.freezePanes.freezeRows(4);
queueSheet.getRange("A4:G34").format.font = { name: fontFamily, size: 10, color: C.ink };
styleHeader(queueSheet.getRange("A4:G4"));
setWidths(queueSheet, {A:7,B:16,C:31,D:31,E:31,F:34,G:42});

// Pitch Library
pitchesSheet.showGridLines = false;
pitchesSheet.tabColor = C.lavender;
styleTitle(pitchesSheet, "A1:F2", "PITCH LIBRARY", "Starting copy—personalize the first two sentences and cite the recipient's recent work before sending");
const pitchHeaders = ["Code","Use for","Subject / title","Draft","Personalize with","CTA"];
pitchesSheet.getRange("A4:F4").values = [pitchHeaders]; styleHeader(pitchesSheet.getRange("A4:F4"));
const pitches = [
  ["A — App review","TapSmart, Verge Installer, MacStories, 9to5Mac, Android press","An OCD app designed to be put down","Hi [Name] — your [specific article/roundup] made me think Patterns may fit [column]. I’m Aftaab, an indie developer who lives with OCD. I built Patterns after running into an uncomfortable design question: a tracker can help you notice patterns, but with OCD it can also become another checking ritual. Patterns is a private, no-account journal and ERP practice companion for iPhone and Android. Personal OCD content stays on-device; optional anonymous usage analytics are off by default. Core tools are free, and Pro is a one-time purchase. Ahead of World Mental Health Day and OCD Awareness Week, I can share a clean review build, source code, screenshots, and a candid interview about the product decisions—including the parts designed to encourage users to stop tracking and return to life. Full disclosure: I build the app and would welcome independent, critical coverage. Press kit: [URL] · iPhone: [URL] · Android: [URL]","Name one recent article and explain the overlap in a single sentence.","Would this fit [specific column/roundup]?"],
  ["B — Personal essay","SELF, The Mighty, IOCDF, OCD-UK, Mental Movement, MyndStories","PITCH: I Built an OCD Tracker—Then Realized Tracking Could Become a Compulsion","I live with OCD, and while building a private tracking app I encountered a paradox that will be familiar to many people who use wellness tools: measurement can clarify a pattern, but it can also become the pattern. I’m proposing a first-person, service-led essay about the moment I noticed the line blur, the practical signs that tracking was turning into reassurance, and the design and personal rules I now use to preserve uncertainty rather than chase certainty. The piece would be approximately 900 words and would include independent clinical sources for general OCD/ERP claims. I would disclose that I build Patterns; the essay would not claim treatment outcomes or ask readers to download it. The reader takeaway is a short framework for deciding what to record, how often, and when to stop.","Match word count, tone, and disclosure rules; cite a recent story.","May I send a full outline or draft?"],
  ["C — Resource update","Psych Central, MindApps, Healthify","Current privacy-first OCD journaling resource for editorial evaluation","Hi [Editor] — I’m writing about [page title], last updated [date]. Its app/resource section currently [specific gap]. I build Patterns, a current iPhone/Android OCD journal and ERP practice companion, and I’d like to offer it for independent evaluation as an additional resource—not request a favorable inclusion. It requires no account; personal OCD content stays on-device; optional anonymous analytics are disabled by default; core tools are free; and Pro is a one-time purchase. The app states clearly that it is self-help, not diagnosis, therapy, or emergency care. Here are the store pages, source code, privacy policy, feature matrix, and limitations: [press-kit URL]. If it does not meet your editorial or evidence standard, I would value knowing which requirement is missing.","Quote the exact gap or stale listing; never disparage another product.","Would your team consider a hands-on evaluation for the next update?"],
  ["D — Podcast guest","OCD Whisperer, OCD Insights, Your Anxiety Toolkit","Guest idea: When tracking recovery becomes another checking ritual","Hi [Host] — I listened to [episode] and especially appreciated [specific point]. I live with OCD and build Patterns, but the useful conversation I’m proposing is larger than the app: how to recognize when journaling, distress ratings, progress graphs, or symptom research are starting to function as reassurance. Three takeaways for listeners: (1) a purpose test before recording anything, (2) friction and stopping rules that keep measurement bounded, and (3) how product teams can design for uncertainty instead of engagement at any cost. I would be transparent about my financial interest, avoid medical advice, and gladly bring an independent clinician into the episode if useful. Previous speaking/video: [links].","Listen first; give the exact episode and moment. Include previous appearances where required.","Would this topic serve your listeners this season?"],
  ["E — Apple nomination","App Store Connect Featuring Nominations","Patterns 1.9 · lived-experience OCD design for World Mental Health Day","Nomination description (≤1,000 chars): Patterns 1.9 is a private OCD journal and ERP practice companion built by an indie developer who lives with OCD. The update adds a full light theme, calmer discovery of advanced tools, more reliable purchases and restores, and clearer controls for default-off anonymous analytics. Personal journal entries, exposures, compulsions, and recovery notes remain on-device; no account is required. For World Mental Health Day and OCD Awareness Week, the story is how lived experience shaped a tool intended to support deliberate practice without turning tracking into another checking ritual. Patterns is a self-help companion, not diagnosis or therapy. Helpful details (≤500 chars): Patterns is independently built, open source, and publishes its sources/editorial policy. Core journaling, tracking, delay timers, self-checks, and basic insights are free; Pro is a one-time purchase. Supplemental URLs: product page, founder story, privacy explainer, press assets, and TestFlight or demo.","Confirm exact version, publication window, locales, accessibility claims, and all five URLs.","Submit for 10–18 Oct 2026 consideration."],
  ["F — India founder","YourStory, Inc42","India-built OCD app bets on privacy and a one-time purchase","Hi [Name] — I’m Aftaab Siddiqui, an India-based indie developer [only keep if accurate] who lives with OCD. I built Patterns around a counterintuitive product choice: sensitive OCD journals do not need accounts or cloud storage, and a self-help companion does not need a recurring subscription to be useful. The current 1.9 release is available on iPhone and Android, keeps personal OCD content on-device, and makes optional anonymous analytics an explicit, default-off choice. The timely story ahead of World Mental Health Day is how lived experience—not a generic wellness trend—shaped the product and its business model. I can share source code, screenshots, exact store data, and an interview. I will not claim clinical outcomes or inflate traction.","Use only if India-based identity is accurate and welcome; add verified traction/news.","Would this fit your founder/product coverage?"],
  ["G — Follow-up","All earned editorial","Re: [original subject]","Hi [Name] — one useful addition to my note below: [new asset, exact October timing, meaningful product update, or relevant data]. The 30-second version is [one-sentence story], and the review/source/privacy materials are here: [URL]. If it is not a fit, no reply needed—I will not keep following up.","Add something genuinely new; otherwise do not send.","Is this worth a closer look for [specific slot]?"],
];
pitchesSheet.getRange(`A5:F${pitches.length + 4}`).values = pitches;
bodyFont(pitchesSheet, `A5:F${pitches.length + 4}`);
pitchesSheet.getRange(`A5:F${pitches.length + 4}`).format.wrapText = true;
pitchesSheet.getRange(`A5:F${pitches.length + 4}`).format.verticalAlignment = "top";
pitchesSheet.getRange(`A5:F${pitches.length + 4}`).format.rowHeight = 210;
for (let row = 5; row <= pitches.length + 4; row++) pitchesSheet.getRange(`A${row}:F${row}`).format.fill = row % 2 ? C.white : C.bg;
pitchesSheet.freezePanes.freezeRows(4);
setWidths(pitchesSheet, {A:18,B:28,C:38,D:105,E:42,F:32});

// Press Kit
kitSheet.showGridLines = false;
kitSheet.tabColor = C.teal;
styleTitle(kitSheet, "A1:G2", "PRESS-KIT & CLAIMS GATE", "Build this once before outreach; accurate restraint is part of the story");
kitSheet.getRange("A4:G4").values = [["Priority","Asset / check","Specification","Source / location","Owner","Status","Notes"]]; styleHeader(kitSheet.getRange("A4:G4"));
const kit = [
  [1,"One-line description","≤25 words; say journal/practice companion, not treatment","patternsocd.com + store copy","Aftaab","Draft","Patterns is a private OCD journal and ERP practice companion for noticing patterns, delaying compulsions, and practicing new responses."],
  [2,"Founder bio + headshot","50 and 120 words; high-res horizontal + square","website /about/aftaab-siddiqui","Aftaab","Needed","State lived experience only as Aftaab is comfortable; never imply he represents everyone with OCD."],
  [3,"App icon","1024×1024 PNG; transparent and solid-background variants","assets/logo.png","Aftaab","Available","Confirm current production icon."],
  [4,"Screenshots","6 clean images per platform; no real user data","store assets / simulator captures","Aftaab","Needed","Include Today, journal, tracker, delay timer, ERP tools, insights."],
  [5,"Short demo","20–30s, captions, no narration required, no personal data","new media asset","Aftaab","Needed","Show one purposeful session and an intentional stop; do not dramatize symptoms."],
  [6,"Fact sheet","Platforms, version, price, free/Pro split, launch date, company/founder","pubspec + store listings","Aftaab","Needed","Current repo/store version 1.9.0; Apple shows $19.99 Pro."],
  [7,"Privacy explainer","One diagram: content stays local; optional events off by default","README + privacy policy","Aftaab","Needed","Name the exact event categories and retention; avoid saying 'zero data' because optional analytics exist."],
  [8,"Safety / limitations","Not diagnosis, therapy, medical device, or emergency care","store copy","Aftaab","Available","Use consistent wording in every pitch."],
  [9,"Source code","Public GitHub link + relevant architecture paths","github.com/gentleloop-labs/patterns","Aftaab","Available","Useful for trust; do not expect general editors to inspect code."],
  [10,"Editorial/sources policy","Public link explaining authoring and factual review","patternsocd.com/editorial-policy","Aftaab","Available","Do not imply unnamed factual reviewers endorse the app."],
  [11,"Store disclosure audit","Google privacy link/deletion label; Apple accessibility declaration","Play Console + App Store Connect","Aftaab","Required","Complete before high-tier privacy pitches."],
  [12,"Attributed links","One URL per target using utm_source / medium / campaign","patternsocd.com/get","Aftaab","Needed","Preserve store deep links and record click baseline."],
  [13,"Real user evidence","Only permissioned, verbatim reviews/testimonials","documented consent","Aftaab","Optional","No invented testimonials, user counts, time savings, or clinical outcomes."],
  [14,"Independent expert list","2–3 OCD clinicians/researchers an editor may contact independently","research","Aftaab","Optional","They need not endorse Patterns; separation improves credibility."],
  [15,"Media contact","Stable domain email and timezone/response expectation","press@patternsocd.com or current support","Aftaab","Needed","Create only if monitored reliably."],
];
kitSheet.getRange(`A5:G${kit.length + 4}`).values = kit;
bodyFont(kitSheet, `A5:G${kit.length + 4}`);
kitSheet.getRange(`A5:G${kit.length + 4}`).format.wrapText = true;
kitSheet.getRange(`A5:G${kit.length + 4}`).format.verticalAlignment = "top";
kitSheet.getRange(`A5:G${kit.length + 4}`).format.rowHeight = 62;
for (let row = 5; row <= kit.length + 4; row++) kitSheet.getRange(`A${row}:G${row}`).format.fill = row % 2 ? C.white : C.bg;
kitSheet.getRange(`F5:F${kit.length + 4}`).format.font = { name: fontFamily, bold: true, color: C.teal };
kitSheet.freezePanes.freezeRows(4);
setWidths(kitSheet, {A:9,B:25,C:43,D:37,E:14,F:14,G:55});

// Sources
sourcesSheet.showGridLines = false;
sourcesSheet.tabColor = C.muted;
styleTitle(sourcesSheet, "A1:F2", "SOURCE LEDGER", "Primary routes and evidence checked 4 Sep 2026; outlet-stated reach is labeled as such");
sourcesSheet.getRange("A4:F4").values = [["ID","Source / claim","URL","Type","Confidence","Use / caveat"]]; styleHeader(sourcesSheet.getRange("A4:F4"));
const sources = [
  [1,"Patterns product positioning, privacy and pricing","https://patternsocd.com/","Primary product","High","Use for verified product facts."],
  [2,"Apple current listing, version, pricing and privacy","https://apps.apple.com/us/app/patterns-ocd-erp-journal/id6762611172","Primary store","High","3 ratings/4.3 and version 1.9.0 on research date."],
  [3,"Google Play current listing and disclosure display","https://play.google.com/store/apps/details?id=com.maskedsyntax.patterns","Primary store","High","Shows 100+ downloads, old privacy URL, and deletion label."],
  [4,"Repository version and architecture","/Users/batman/gentleloop-labs/patterns/pubspec.yaml","Primary internal","High","Version 1.9.0+31; Flutter/SQLite dependencies."],
  [5,"World Mental Health Day 2026 date and theme","https://www.who.int/campaigns/world-mental-health-day/2026","Primary authority","High","10 Oct; 'Lived experiences heard: real voices, real change.'"],
  [6,"Apple featuring nomination steps and 3-week lead","https://developer.apple.com/help/app-store-connect/manage-featuring-nominations/nominate-your-app-for-featuring/","Primary platform","High","Official submission path and up to five supplemental URLs."],
  [7,"Apple editorial considerations","https://developer.apple.com/app-store/getting-featured/","Primary platform","High","UX, design, innovation, uniqueness, accessibility, localization, product page."],
  [8,"TapSmart review route and stated audience","https://www.tapsmart.com/tapsmart-apps/contributions-faq/","Primary outlet","High","Outlet states 150k monthly users and 400k sessions; not independently audited."],
  [9,"TapSmart editor contact","https://www.tapsmart.com/contacts/?amp=1","Primary outlet","High","Tom Rolfe, tomjrolfe@intelligenti.com."],
  [10,"SELF current pitch guidelines","https://www.self.com/story/how-to-pitch-a-story-to-self","Primary outlet","High","March 2026; explicit editor email and formats."],
  [11,"IOCDF story guidelines","https://iocdf.org/get-involved/share-your-story/stories/","Primary authority","High","Year-round, worldwide, ≤1,000 words; no unlicensed medical advice."],
  [12,"OCD Awareness Week timing","https://iocdf.org/wp-content/uploads/2025/12/Full-Report-Americas-OCD-Care-Crisis-12-9-2025.pdf","Primary authority","High","Second full week of October; do not imply endorsement."],
  [13,"Made of Millions contact and stated reach","https://www.madeofmillions.com/contact","Primary outlet","High","Seeks writers/advocates; 3M annual reach is outlet-stated."],
  [14,"The Mighty contributor rules","https://themighty.com/mighty-contributor-faqs/","Primary outlet","High","Independent business stories allowed if useful/non-promotional."],
  [15,"The Mighty submission timing","https://themighty.com/submit-a-story/","Primary outlet","High","Small percentage accepted; often 6+ months."],
  [16,"Psych Central OCD resource directory","https://psychcentral.com/ocd/ocd-resources","Primary outlet","High","2021 article still lists Live OCD Free."],
  [17,"Mind/ORCHA developer intake","https://mind.orchahealth.com/en-GB","Primary library","High","Formal email route; ask cost/evidence/geography."],
  [18,"AppBrain Featured Apps","https://www.appbrain.com/product/featured","Primary platform","High","3M+ monthly visitors/5 apps daily are outlet-stated."],
  [19,"MacStories John Voorhees contact/beat","https://www.macstories.net/author/johnvoorhees/","Primary outlet","High","Managing editor; apps; direct email."],
  [20,"TechRadar pitch guidance","https://www.techradar.com/how-to/how-to-pitch-your-ideas-to-techradar","Primary outlet","High","Founder should offer interview/review, not pose as independent contributor."],
  [21,"TechRadar contact","https://www.techradar.com/how-to/contact-us","Primary outlet","High","news@techradar.com."],
  [22,"OCD-UK magazine contribution route","https://www.ocduk.org/the-ocd-magazine-get-involved/","Primary outlet","Medium","Ask for current theme/deadline; core guidance page is older."],
  [23,"ADAA personal-story restriction","https://adaa.org/understand-anxiety-depression/share-your-story","Primary authority","High","Explicitly prohibits product/site promotion—excluded."],
  [24,"Your Anxiety Toolkit guest form","https://kimberleyquinlan-lmft.com/be-on-the-show/","Primary outlet","High","6+ month lead and no promotion-first pitches."],
  [25,"AppBrain 2026 launch announcement","https://www.appbrain.com/blog/featured-apps-program","Primary platform","High","Confirms program, cadence and claimed reach."],
  [26,"AlternativeTo submission FAQ","https://alternativeto.net/faq/","Primary platform","High","Optional $5 queue priority; no ranking advantage."],
  [27,"YourStory pitch route","https://yourstory.com/submit-a-story","Primary outlet","High","Use only with an accurate India angle."],
  [28,"Inc42 contact route","https://pages.inc42.com/contact-us/","Primary outlet","Medium","Emails are obfuscated in extraction; verify live page."],
  [29,"The Verge Installer description","https://www.theverge.com/pages/installer-newsletter-sign-up","Primary outlet","High","Weekly download/discovery format."],
  [30,"Installer tip email evidence","https://wiretel.in/the-things-were-building-now/","Secondary reproduction","Medium","Validate installer@theverge.com in a current received issue."],
  [31,"TIME Jamie Ducharme beat","https://time.com/author/jamie-ducharme/","Primary outlet","High","Health correspondent covering mental health."],
  [32,"Product Hunt posting guidance","https://help.producthunt.com/en/articles/479557-how-to-post-a-product","Primary platform","High","Maker-led/self-posting route."],
  [33,"Google Play promotional content","https://support.google.com/googleplay/android-developer/answer/12932541","Primary platform","High","Conditional on eligibility."],
  [34,"Cult of Mac review policy","https://www.cultofmac.com/news/cult-of-macs-reviews-policy","Primary outlet","High","Use live linked review-request email."],
];
sourcesSheet.getRange(`A5:F${sources.length + 4}`).values = sources;
bodyFont(sourcesSheet, `A5:F${sources.length + 4}`);
sourcesSheet.getRange(`A5:F${sources.length + 4}`).format.wrapText = true;
sourcesSheet.getRange(`A5:F${sources.length + 4}`).format.verticalAlignment = "top";
sourcesSheet.getRange(`A5:F${sources.length + 4}`).format.rowHeight = 50;
for (let row = 5; row <= sources.length + 4; row++) sourcesSheet.getRange(`A${row}:F${row}`).format.fill = row % 2 ? C.white : C.bg;
sourcesSheet.getRange(`C5:C${sources.length + 4}`).format.font = { name: fontFamily, size: 9, color: C.teal };
sourcesSheet.freezePanes.freezeRows(4);
setWidths(sourcesSheet, {A:7,B:40,C:70,D:20,E:14,F:55});

// Workbook-wide polish.
for (const sheet of [brief, targetsSheet, queueSheet, pitchesSheet, kitSheet, sourcesSheet]) {
  const used = sheet.getUsedRange();
  used.format.verticalAlignment = "top";
}

const inspectBrief = await wb.inspect({ kind: "table", range: "Start Here!A1:H34", include: "values,formulas", tableMaxRows: 34, tableMaxCols: 8, maxChars: 9000 });
const inspectTargets = await wb.inspect({ kind: "table", range: "Targets!A1:W14", include: "values,formulas", tableMaxRows: 14, tableMaxCols: 23, maxChars: 12000 });
const inspectQueue = await wb.inspect({ kind: "table", range: "30-Day Queue!A1:G15", include: "values,formulas", tableMaxRows: 15, tableMaxCols: 7, maxChars: 10000 });
const errors = await wb.inspect({ kind: "match", searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!|#SPILL!|#CALC!", options: { useRegex: true, maxResults: 300 }, summary: "final formula error scan" });
console.log(inspectBrief.ndjson);
console.log(inspectTargets.ndjson);
console.log(inspectQueue.ndjson);
console.log(errors.ndjson);

for (const [name, range, file] of [
  ["Start Here", "A1:H34", "start-here.png"],
  ["Targets", "A1:W16", "targets.png"],
  ["30-Day Queue", "A1:G18", "queue.png"],
  ["Pitch Library", "A1:F11", "pitches.png"],
  ["Press Kit", "A1:G19", "press-kit.png"],
  ["Sources", "A1:F20", "sources.png"],
]) {
  const preview = await wb.render({ sheetName: name, range, scale: 1, format: "png" });
  await fs.writeFile(`${previewDir}/${file}`, new Uint8Array(await preview.arrayBuffer()));
}

const xlsx = await SpreadsheetFile.exportXlsx(wb);
await xlsx.save(`${outputDir}/patterns-outreach-campaign.xlsx`);
console.log(`Saved ${outputDir}/patterns-outreach-campaign.xlsx`);
