const posts = [
  {
    id: "2026-08-27-carousel-ocd-loop",
    date: "Aug 27",
    type: "Carousel",
    accent: "yellow",
    title: "Why the relief never lasts",
    slides: [
      { label: "The OCD loop", title: "Why the relief never lasts", body: "OCD is not just the thought. It is the cycle that forms around it.", visual: "cycle" },
      { label: "01 / Obsession", title: "A thought, image, urge, or doubt lands", body: "It feels important, threatening, or impossible to leave unanswered.", visual: "thought" },
      { label: "02 / Distress", title: "Your internal alarm gets loud", body: "Anxiety, guilt, disgust, or uncertainty can make the moment feel urgent.", visual: "alarm" },
      { label: "03 / Compulsion", title: "You do something to feel certain or safe", body: "Checking, avoiding, reviewing, confessing, researching, or asking for reassurance can all serve this function.", visual: "compulsions" },
      { label: "04 / Brief relief", title: "The discomfort drops - for now", body: "That short relief teaches the brain to request the same ritual the next time doubt appears.", visual: "relief" },
      { label: "The next response", title: "You do not have to solve the thought", body: "ERP works on the response: meeting the trigger while reducing the compulsion, ideally with an OCD-trained clinician.", visual: "choice" },
    ],
  },
  {
    id: "2026-08-27-carousel-hidden-compulsions",
    date: "Aug 27",
    type: "Carousel",
    accent: "green",
    title: "Compulsions do not always look like rituals",
    slides: [
      { label: "OCD, out of sight", title: "Compulsions do not always look like rituals", body: "Some happen silently. Some look like careful thinking. The function matters more than the form.", visual: "hidden" },
      { label: "Mental review", title: "Replaying a memory until it feels resolved", body: "The review promises certainty, but each replay creates another detail to question.", visual: "replay" },
      { label: "Internal checking", title: "Scanning your feelings for the 'right' reaction", body: "Checking attraction, guilt, certainty, memory, or bodily sensations can become a ritual.", visual: "scan" },
      { label: "Reassurance", title: "Asking the same question in a new way", body: "Friends, forums, search results, and even self-talk can provide relief that does not hold.", visual: "questions" },
      { label: "Avoidance", title: "Organizing life around not being triggered", body: "Avoiding people, places, objects, words, or decisions can quietly reinforce the alarm.", visual: "avoidance" },
      { label: "A useful question", title: "What job is this action doing?", body: "Is it practical problem-solving, or is it trying to remove all doubt right now? That pattern is useful to bring to a clinician.", visual: "function" },
    ],
  },
  {
    id: "2026-08-27-static-compulsion-delay",
    date: "Aug 27",
    type: "Product",
    accent: "yellow",
    title: "Put a pause between the urge and the action",
    static: true,
    slides: [
      { label: "Patterns / Compulsion Delay", title: "Put 5 minutes between the urge and the action", body: "Name the urge, choose a delay, and notice what happens. Every moment you wait is practice - not a pass or fail.", visual: "delayApp" },
    ],
  },
  {
    id: "2026-08-28-carousel-reassurance-loop",
    date: "Aug 28",
    type: "Carousel",
    accent: "coral",
    title: "Why reassurance never feels finished",
    slides: [
      { label: "The reassurance loop", title: "Why one more answer never feels finished", body: "The problem is not that you have not found the perfect answer. It is what OCD asks the answer to do.", visual: "questions" },
      { label: "01", title: "Doubt asks for certainty", body: "Am I safe? Did I mean it? What if I missed something? The question feels urgent.", visual: "thought" },
      { label: "02", title: "You ask, search, compare, or confess", body: "The action is aimed at making the uncertainty disappear completely.", visual: "search" },
      { label: "03", title: "Relief arrives briefly", body: "Then OCD finds an exception: 'But what if they misunderstood what I asked?'", visual: "relief" },
      { label: "A different practice", title: "Let the answer remain incomplete", body: "In ERP, the response may be 'maybe, maybe not' followed by returning to the activity you chose.", visual: "maybe" },
      { label: "Important", title: "Support without joining the ritual", body: "An OCD-trained clinician can help you and the people close to you set kind, consistent reassurance boundaries.", visual: "boundary" },
    ],
  },
  {
    id: "2026-08-28-carousel-delay-tool",
    date: "Aug 28",
    type: "Carousel",
    accent: "yellow",
    title: "How Compulsion Delay works in Patterns",
    slides: [
      { label: "Inside Patterns", title: "How Compulsion Delay works", body: "A small, structured pause when doing nothing feels impossible.", visual: "delayApp" },
      { label: "Step 01", title: "Name the urge", body: "Keep it concrete: 'checking the lock again' or 'asking for reassurance.'", visual: "nameUrge" },
      { label: "Step 02", title: "Rate its intensity once", body: "Use the 0-10 scale as context, not a number you have to get exactly right.", visual: "suds" },
      { label: "Step 03", title: "Choose a realistic wait", body: "Start with 1, 5, or 15 minutes. A delay is still a change in the loop.", visual: "timer" },
      { label: "Step 04", title: "Let the timer hold the boundary", body: "The aim is not to force the urge away. It is to practise not answering it immediately.", visual: "wave" },
      { label: "Step 05", title: "Record what happened without judgment", body: "Resisted, delayed, or did it: the result is information you can reflect on later.", visual: "outcomes" },
    ],
  },
  {
    id: "2026-08-28-static-private-by-design",
    date: "Aug 28",
    type: "Product",
    accent: "yellow",
    title: "Your OCD data stays on your phone",
    static: true,
    slides: [
      { label: "Patterns / Privacy", title: "Your OCD data stays on your phone", body: "No account. No cloud sync. No ads. Your journal, OCD records, and ERP notes remain on your device.", visual: "privacyApp" },
    ],
  },
  {
    id: "2026-08-29-carousel-what-erp-is",
    date: "Aug 29",
    type: "Carousel",
    accent: "blue",
    title: "ERP is not 'just face your fears'",
    slides: [
      { label: "OCD treatment", title: "ERP is not 'just face your fears'", body: "Exposure and Response Prevention is planned practice with two parts - and both matter.", visual: "erp" },
      { label: "Exposure", title: "Meet a trigger gradually and on purpose", body: "That can involve a situation, object, thought, image, or uncertainty from a planned hierarchy.", visual: "exposure" },
      { label: "Response prevention", title: "Reduce the ritual that follows", body: "The learning changes when you stay with the trigger without the usual checking, avoiding, or neutralizing.", visual: "response" },
      { label: "Not flooding", title: "ERP should be collaborative, not forced", body: "A trained clinician helps choose manageable steps and adapts the work to the person.", visual: "ladder" },
      { label: "Not reassurance", title: "The goal is not to prove the fear impossible", body: "The practice is learning that uncertainty and discomfort can be present without a compulsion.", visual: "maybe" },
      { label: "Patterns' role", title: "A practice companion, not a therapist", body: "Patterns can organize exercises and reflections. It does not diagnose OCD or replace qualified care.", visual: "toolkit" },
    ],
  },
  {
    id: "2026-08-29-carousel-exposure-ladder",
    date: "Aug 29",
    type: "Carousel",
    accent: "green",
    title: "Build an exposure ladder, not a leap",
    slides: [
      { label: "ERP planning", title: "Build an exposure ladder, not a leap", body: "A hierarchy turns one overwhelming fear into a sequence of workable practices.", visual: "ladder" },
      { label: "Step 01", title: "Choose one OCD pattern", body: "Start with a specific trigger-compulsion loop rather than 'fix all of my OCD.'", visual: "focus" },
      { label: "Step 02", title: "List possible exposures", body: "Include easier, medium, and harder versions. Do not order them yet.", visual: "list" },
      { label: "Step 03", title: "Estimate distress from 0 to 10", body: "SUDS ratings help sort the ladder. They are estimates, not promises.", visual: "suds" },
      { label: "Step 04", title: "Begin with a manageable rung", body: "The practice should be meaningful and doable, with a clear response-prevention plan.", visual: "firstRung" },
      { label: "Build with support", title: "The ladder belongs in a treatment plan", body: "Work with an OCD-trained clinician when possible, especially for complex, severe, or safety-related concerns.", visual: "boundary" },
    ],
  },
  {
    id: "2026-08-29-carousel-track-without-ritual",
    date: "Aug 29",
    type: "Carousel",
    accent: "yellow",
    title: "Track the loop without feeding it",
    slides: [
      { label: "Using an OCD tracker", title: "Track the loop without feeding it", body: "A useful log captures context. It should not become another place to review until you feel certain.", visual: "trackerApp" },
      { label: "Keep it short", title: "What happened?", body: "Describe the trigger or intrusive experience in one or two plain sentences.", visual: "note" },
      { label: "Name the response", title: "What did you do next?", body: "Include visible actions, mental rituals, avoidance, reassurance, or a response-prevention choice.", visual: "compulsions" },
      { label: "Add context", title: "Rate distress once", body: "A 0-10 estimate is enough. Re-rating until it feels exact can pull tracking into the loop.", visual: "suds" },
      { label: "Then leave", title: "Save the entry and return to your day", body: "Review trends at a planned time, not every time anxiety asks for proof of progress.", visual: "exit" },
      { label: "Patterns", title: "See patterns, not verdicts", body: "Your records can add context for reflection or a therapy session. They are not a diagnosis or recovery score.", visual: "insights" },
    ],
  },
  {
    id: "2026-08-30-carousel-mental-compulsions",
    date: "Aug 30",
    type: "Carousel",
    accent: "coral",
    title: "The ritual can happen entirely in your head",
    slides: [
      { label: "Mental compulsions", title: "The ritual can happen entirely in your head", body: "No one else can see it, but it can consume hours and keep the same OCD loop running.", visual: "hidden" },
      { label: "Replaying", title: "Reviewing the memory one more time", body: "Searching for the exact detail that will finally settle what happened.", visual: "replay" },
      { label: "Checking", title: "Testing how you feel", body: "Monitoring attraction, certainty, guilt, arousal, disgust, love, or any 'correct' internal reaction.", visual: "scan" },
      { label: "Neutralizing", title: "Replacing a 'bad' thought with a 'good' one", body: "Repeating words, images, prayers, or counter-thoughts until the distress shifts.", visual: "neutralize" },
      { label: "Analyzing", title: "Trying to think your way to zero uncertainty", body: "Rumination can feel productive while returning to the same question without a durable answer.", visual: "maze" },
      { label: "Spot the function", title: "Is this reflection - or relief-seeking?", body: "Notice whether the thinking serves a practical decision or is trying to make discomfort disappear right now.", visual: "function" },
    ],
  },
  {
    id: "2026-08-30-carousel-recovery-progress",
    date: "Aug 30",
    type: "Carousel",
    accent: "green",
    title: "Recovery is not always feeling calm",
    slides: [
      { label: "OCD recovery", title: "Recovery is not always feeling calm", body: "A difficult day can still contain meaningful practice.", visual: "progress" },
      { label: "It can look like", title: "Delaying a compulsion by two minutes", body: "You changed the automatic sequence, even if the urge stayed loud.", visual: "timer" },
      { label: "It can look like", title: "Letting a question remain unanswered", body: "You chose uncertainty instead of another round of checking or reassurance.", visual: "maybe" },
      { label: "It can look like", title: "Returning to what matters while anxious", body: "Functioning with discomfort is different from waiting for discomfort to disappear.", visual: "values" },
      { label: "It can look like", title: "Telling your clinician the full pattern", body: "Especially the mental rituals, avoidance, and themes that shame has kept hidden.", visual: "conversation" },
      { label: "A gentler metric", title: "Count the practice, not perfection", body: "Patterns records attempts and trends as context. It does not grade your recovery.", visual: "insights" },
    ],
  },
  {
    id: "2026-08-30-static-patterns-insights",
    date: "Aug 30",
    type: "Product",
    accent: "yellow",
    title: "See patterns, not judgments",
    static: true,
    slides: [
      { label: "Patterns / Private insights", title: "See patterns. Not judgments.", body: "Review practice, urges, and distress trends without turning recovery into a perfect score.", visual: "insightsApp" },
    ],
  },
  {
    id: "2026-08-31-carousel-when-thought-feels-urgent",
    date: "Aug 31",
    type: "Carousel",
    accent: "blue",
    title: "When an intrusive thought feels urgent",
    slides: [
      { label: "In the moment", title: "When an intrusive thought feels urgent", body: "Urgency is part of the alarm. It does not mean the question must be solved now.", visual: "alarm" },
      { label: "01 / Notice", title: "Name what is happening", body: "'I am having an intrusive thought, and I feel an urge to get certainty.'", visual: "thought" },
      { label: "02 / Spot", title: "Find the action OCD is requesting", body: "Check? Search? Confess? Avoid? Replay? Ask someone to decide for you?", visual: "compulsions" },
      { label: "03 / Pause", title: "Create a small delay", body: "A short planned wait can interrupt the demand for an immediate response.", visual: "timer" },
      { label: "04 / Allow", title: "Let some uncertainty come with you", body: "The aim is not to win an argument with the thought. It is to stop treating it like an emergency.", visual: "maybe" },
      { label: "05 / Return", title: "Choose the next ordinary action", body: "Go back to the task, person, or value that was in front of you before OCD took the microphone.", visual: "values" },
    ],
  },
  {
    id: "2026-08-31-carousel-urge-surfing",
    date: "Aug 31",
    type: "Carousel",
    accent: "green",
    title: "An urge is a wave, not a deadline",
    slides: [
      { label: "Urge surfing", title: "An urge is a wave, not a deadline", body: "Urge surfing is a way to observe an urge changing without immediately acting on it.", visual: "wave" },
      { label: "Step 01", title: "Rate the urge once", body: "Give it a rough 0-10 number. Precision is not the goal.", visual: "suds" },
      { label: "Step 02", title: "Notice where it shows up", body: "Tight chest, restless hands, heat, pressure, racing thoughts - observe without interpreting.", visual: "bodyMap" },
      { label: "Step 03", title: "Describe the wave", body: "Is it rising, cresting, holding, or shifting? The goal is observation, not forcing it down.", visual: "wave" },
      { label: "Step 04", title: "Do not debate the obsession", body: "Return attention to the experience of the urge rather than proving the thought true or false.", visual: "noDebate" },
      { label: "Step 05", title: "Reflect after the timer", body: "Record what you chose and what changed. Patterns includes guided urge surfing as a Pro tool.", visual: "outcomes" },
    ],
  },
  {
    id: "2026-08-31-carousel-therapy-notes",
    date: "Aug 31",
    type: "Carousel",
    accent: "yellow",
    title: "What to bring to an OCD therapy session",
    slides: [
      { label: "Make the hour useful", title: "What to bring to an OCD therapy session", body: "You do not need a perfect report. A few concrete patterns can give the conversation somewhere to begin.", visual: "conversation" },
      { label: "Bring examples", title: "Recent triggers or intrusive experiences", body: "What happened, when it happened, and what made the moment feel important.", visual: "note" },
      { label: "Bring the response", title: "Visible and mental compulsions", body: "Include checking, reviewing, reassurance, avoidance, neutralizing, and anything else done for relief.", visual: "compulsions" },
      { label: "Bring the impact", title: "Time, distress, and avoided life", body: "What did the loop cost in sleep, work, relationships, concentration, or daily routines?", visual: "impact" },
      { label: "Bring the practice", title: "What you tried and what happened", body: "Delays, exposures, response prevention, and where the plan became difficult.", visual: "progress" },
      { label: "Patterns", title: "Private notes you can choose to share", body: "Log events and reflections on your device, then bring the useful context - not every detail - to your clinician.", visual: "trackerApp" },
    ],
  },
];

const appAssets = {
  delay: "../../../app-store/patterns-screenshots/exports/app-store-1242x2688/02-delay-the-urge.png",
  privacy: "../../../app-store/patterns-screenshots/exports/app-store-1242x2688/05-nothing-leaves-your-phone.png",
  insights: "../../../app-store/patterns-screenshots/exports/app-store-1242x2688/06-see-patterns-not-judgments.png",
  tracker: "../../../assets/screenshots/ocd_tracker.png",
};

const visualMarkup = {
  cycle: `<div class="cycle"><span>Obsession</span><b>+</b><span>Distress</span><b>+</b><span>Compulsion</span><b>+</b><span>Brief relief</span></div>`,
  thought: `<div class="thought-card"><span>WHAT IF...</span><p>I missed something important?</p><i></i><i></i><i></i></div>`,
  alarm: `<div class="alarm"><i></i><div><span>LOUD</span><b>does not mean</b><span>URGENT</span></div></div>`,
  compulsions: `<div class="tag-cloud"><span>Checking</span><span>Reviewing</span><span>Reassurance</span><span>Avoiding</span><span>Confessing</span><span>Neutralizing</span></div>`,
  relief: `<div class="relief-chart"><span>Distress</span><svg viewBox="0 0 700 250"><path d="M20 45 C120 55 150 210 275 205 S360 40 475 55 S575 220 680 205"/><line x1="20" y1="220" x2="680" y2="220"/></svg><p>Relief falls. The loop returns.</p></div>`,
  choice: `<div class="fork"><div class="urge-node">URGE</div><div class="fork-line"></div><div class="fork-options"><span>Automatic ritual</span><span class="active">Pause + choose</span></div></div>`,
  hidden: `<div class="iceberg"><div class="water"></div><span class="above">Visible rituals</span><div class="below"><span>Rumination</span><span>Mental review</span><span>Internal checking</span><span>Neutralizing</span></div></div>`,
  replay: `<div class="replay"><span>Did I?</span><span>But what if...</span><span>Check again</span><b>↻</b></div>`,
  scan: `<div class="scanner"><div class="scan-line"></div><span>Do I feel certain enough?</span></div>`,
  questions: `<div class="question-stack"><span>Are you sure?</span><span>But did you understand?</span><span>What if this time is different?</span></div>`,
  avoidance: `<div class="avoidance"><span>My day</span><div class="blocked">TRIGGER</div><svg viewBox="0 0 700 210"><path d="M35 105 C180 105 165 25 330 25 S500 185 665 105"/></svg></div>`,
  function: `<div class="function-check"><p>What is this action trying to achieve?</p><div><span>Practical next step</span><span>Zero uncertainty</span></div></div>`,
  search: `<div class="search-loop"><div>Search again...</div><span>12 tabs</span><span>0 lasting certainty</span></div>`,
  maybe: `<div class="maybe"><span>MAYBE</span><b>and I can continue</b><span>MAYBE NOT</span></div>`,
  boundary: `<div class="boundary"><div>Care</div><span></span><div>Compulsion</div><p>Kind support can still hold a boundary.</p></div>`,
  delayApp: `<div class="app-window portrait"><img src="${appAssets.delay}" alt="Patterns Compulsion Delay tool" /></div>`,
  nameUrge: `<div class="app-form"><label>WHICH URGE ARE YOU SITTING WITH?</label><div>Checking the lock again</div><span>Re-checking</span><span>Seeking reassurance</span></div>`,
  suds: `<div class="suds"><div><span>DISTRESS / URGE</span><b>7<small>/10</small></b></div><i><em></em></i><p>Useful context. Not a test.</p></div>`,
  timer: `<div class="timer"><span>05:00</span><div><i></i></div><p>Pause before responding</p></div>`,
  wave: `<div class="wave"><svg viewBox="0 0 760 300"><path d="M20 240 C140 240 165 55 320 55 S500 240 740 240"/><line x1="20" y1="260" x2="740" y2="260"/></svg><span>rise</span><span>crest</span><span>shift</span></div>`,
  outcomes: `<div class="outcomes"><span>Resisted</span><span>Delayed it</span><span>Did it</span><p>Information, not judgment.</p></div>`,
  privacyApp: `<div class="app-window portrait"><img src="${appAssets.privacy}" alt="Patterns privacy-first design" /></div>`,
  erp: `<div class="erp-equation"><span>EXPOSURE</span><b>+</b><span>RESPONSE PREVENTION</span><b>=</b><span>NEW LEARNING</span></div>`,
  exposure: `<div class="exposure"><div>Trigger</div><span>Stay present</span><div>Uncertainty</div></div>`,
  response: `<div class="response"><span>Urge</span><b>→</b><span class="crossed">Ritual</span><b>→</b><span>New response</span></div>`,
  ladder: `<div class="ladder"><span>2/10</span><span>4/10</span><span>6/10</span><span>8/10</span></div>`,
  toolkit: `<div class="toolkit"><span>Guided ERP</span><span>Compulsion Delay</span><span>Exposure Ladder</span><span>Urge Surfing</span></div>`,
  focus: `<div class="focus"><span>ONE LOOP</span><p>Trigger → urge → response</p></div>`,
  list: `<div class="simple-list"><p>□ Easier practice</p><p>□ Medium practice</p><p>□ Harder practice</p></div>`,
  firstRung: `<div class="first-rung"><span>Start here</span><div></div><div></div><div></div></div>`,
  trackerApp: `<div class="app-window landscape"><img src="${appAssets.tracker}" alt="Patterns OCD tracker" /></div>`,
  note: `<div class="note"><span>WHAT HAPPENED?</span><p>A thought showed up while I was leaving home...</p><i></i><i></i></div>`,
  exit: `<div class="exit"><span>SAVE</span><b>→</b><span>RETURN TO YOUR DAY</span></div>`,
  insights: `<div class="insight-chart"><div><b>Practice</b><span>context, not a grade</span></div><svg viewBox="0 0 700 200"><path d="M20 150 C150 180 220 70 350 115 S560 40 680 80"/></svg></div>`,
  neutralize: `<div class="neutralize"><span>BAD THOUGHT</span><b>⇄</b><span>GOOD THOUGHT</span><p>Repeat until it feels right</p></div>`,
  maze: `<div class="maze"><span>ONE MORE ANALYSIS</span><div></div><b>?</b></div>`,
  progress: `<div class="progress"><span>Practice</span><span>Uncertainty tolerated</span><span>Life resumed</span></div>`,
  values: `<div class="values"><span>OCD asks for certainty</span><b>→</b><span>I choose the next valued action</span></div>`,
  conversation: `<div class="conversation"><span>"Here is the pattern I keep getting stuck in."</span><i></i><i></i></div>`,
  insightsApp: `<div class="app-window portrait"><img src="${appAssets.insights}" alt="Patterns private insights" /></div>`,
  bodyMap: `<div class="body-map"><i></i><span>Tight chest</span><span>Restless hands</span><span>Racing thoughts</span></div>`,
  noDebate: `<div class="no-debate"><span>PROVE IT</span><b>×</b><span>OBSERVE IT</span></div>`,
  impact: `<div class="impact"><span>Time</span><span>Sleep</span><span>Work</span><span>Relationships</span><span>Avoidance</span></div>`,
};

function dots(index, count) {
  return Array.from({ length: count }, (_, i) => `<i class="${i === index ? "active" : ""}"></i>`).join("");
}

function render() {
  const query = new URLSearchParams(location.search);
  const postIndex = Math.max(0, Number(query.get("post") || 1) - 1);
  const post = posts[postIndex] || posts[0];
  const slideIndex = Math.max(0, Math.min(post.slides.length - 1, Number(query.get("slide") || 1) - 1));
  const slide = post.slides[slideIndex];
  const root = document.getElementById("slide");
  root.className = `slide ${post.accent} ${post.static ? "static-post" : "carousel-post"}`;
  root.innerHTML = `
    <header>
      <div class="brand"><img src="../../../assets/logo.png" alt="" /><span>Patterns</span></div>
      <div class="meta">${post.date} · ${post.type} · ${String(slideIndex + 1).padStart(2, "0")}/${String(post.slides.length).padStart(2, "0")}</div>
    </header>
    <section class="copy">
      <p class="label">${slide.label}</p>
      <h1>${slide.title}</h1>
      <p class="body-copy">${slide.body}</p>
    </section>
    <section class="visual">${visualMarkup[slide.visual] || visualMarkup.cycle}</section>
    <footer>
      <div class="dots">${dots(slideIndex, post.slides.length)}</div>
      <span>${post.static ? "patternsocd.com" : slideIndex === post.slides.length - 1 ? "Save for later" : "Swipe"}</span>
    </footer>
  `;
}

render();
