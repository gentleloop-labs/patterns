const posts = {
  1: {
    title: "Meet Patterns",
    accent: "yellow",
    slides: [
      {
        classes: "cover",
        eyebrow: "Start here",
        title: "A quieter way to understand your mind.",
        lead: "Patterns is a <strong>private journal and OCD self-tracker</strong> made for structured reflection.",
        art: "assets/pattern-rings.png",
      },
      {
        eyebrow: "What it is",
        title: "One calm place for two kinds of reflection.",
        lead: "Write freely when you need space. Add structure when a thought, urge, or response is worth noticing.",
        extra: `<div class="card-grid">
          <div class="ui-card"><div class="icon">✎</div><h3>Daily journal</h3><p>Capture thoughts and experiences in your own words.</p></div>
          <div class="ui-card highlight"><div class="icon">◎</div><h3>OCD event tracker</h3><p>Record obsessions, compulsions, distress, and your response.</p></div>
        </div>`,
      },
      {
        eyebrow: "In the moment",
        title: "Record what happened. Not what it “means.”",
        lead: "Patterns gives the moment a simple structure—without turning it into a label or diagnosis.",
        extra: `<div class="mock-panel">
          <div class="mock-label">Track an event</div>
          <div class="input-row"><span class="chip active">Obsession</span><span class="chip">Compulsion</span></div>
          <div class="field">What happened?</div>
          <div class="field">What did you do in response?</div>
          <div class="slider"></div><div class="slider-meta"><span>Distress</span><strong>7 / 10</strong></div>
        </div>`,
      },
      {
        eyebrow: "Over time",
        title: "Entries become context.",
        lead: "Review trends in distress, triggers, responses, and consistency. The goal is clarity—not a perfect score.",
        extra: `<div class="chart">
          <svg viewBox="0 0 760 230" aria-hidden="true">
            <defs><linearGradient id="fade" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#F4C95D"/><stop offset="1" stop-color="#F4C95D" stop-opacity="0"/></linearGradient></defs>
            <path class="area" d="M20 140 C110 80,150 185,230 125 S340 45,420 115 S540 190,610 105 S700 80,740 120 L740 220 L20 220 Z"/>
            <path class="line" d="M20 140 C110 80,150 185,230 125 S340 45,420 115 S540 190,610 105 S700 80,740 120"/>
            <circle cx="20" cy="140" r="7"/><circle cx="230" cy="125" r="7"/><circle cx="420" cy="115" r="7"/><circle cx="610" cy="105" r="7"/><circle cx="740" cy="120" r="7"/>
          </svg>
        </div><div class="chart-labels"><span>MON</span><span>WED</span><span>FRI</span><span>SUN</span></div>
        <div class="insight-pill">A pattern is information, not judgment.</div>`,
      },
      {
        classes: "end-card",
        eyebrow: "The short version",
        title: "Notice. Record. Reflect.",
        lead: "Patterns is a personal space to understand recurring thoughts, behaviors, and emotional trends—one entry at a time.",
        extra: `<div class="cta">Meet Patterns <span>→</span></div>
          <p class="disclaimer">For personal reflection and self-tracking. Patterns does not diagnose, treat, prevent, or cure any condition, and is not a replacement for qualified professional care.</p>`,
      },
    ],
  },
  2: {
    title: "The daily loop",
    accent: "green",
    slides: [
      {
        classes: "cover",
        eyebrow: "How it works",
        title: "From a difficult moment to a clearer pattern.",
        lead: "A simple daily loop you can return to whenever you need it.",
        art: "assets/daily-path.png",
      },
      {
        eyebrow: "Step 01 · Notice",
        title: "Start with the moment you’re in.",
        lead: "Something feels loud. Pause long enough to name what is happening—without needing to solve it first.",
        extra: `<div class="thought-bubble">“I keep replaying the same thought, and the urge to check is getting stronger.”</div>`,
      },
      {
        eyebrow: "Step 02 · Choose",
        title: "Use the kind of space you need.",
        lead: "There is no one right way to record a day.",
        extra: `<div class="choice-stack">
          <div class="choice"><div class="feature-icon">✎</div><div><h3>Write freely</h3><p>Open the journal and let the thought unfold.</p></div><div class="arrow">›</div></div>
          <div class="choice"><div class="feature-icon">◎</div><div><h3>Track the event</h3><p>Capture the obsession, compulsion, distress, and response.</p></div><div class="arrow">›</div></div>
        </div>`,
      },
      {
        eyebrow: "Step 03 · Record",
        title: "Give the moment a little structure.",
        lead: "A short record is enough. Add only what helps you remember the experience later.",
        extra: `<div class="timeline">
          <div class="timeline-row"><div class="timeline-node">1</div><div class="timeline-copy"><strong>What happened?</strong><span>Describe the thought, urge, or situation.</span></div></div>
          <div class="timeline-row"><div class="timeline-node">2</div><div class="timeline-copy"><strong>What did you do?</strong><span>Note the action or response that followed.</span></div></div>
          <div class="timeline-row"><div class="timeline-node">3</div><div class="timeline-copy"><strong>How intense was it?</strong><span>Add a 0–10 distress rating for context.</span></div></div>
        </div>`,
      },
      {
        eyebrow: "Step 04 · Reflect",
        title: "Return when you are ready.",
        lead: "Look across entries for what repeats, what changes, and which responses seem useful to discuss or explore.",
        extra: `<div class="chart">
          <svg viewBox="0 0 760 230" aria-hidden="true">
            <defs><linearGradient id="fade" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#7BBF91"/><stop offset="1" stop-color="#7BBF91" stop-opacity="0"/></linearGradient></defs>
            <path class="area" d="M20 80 C90 100,130 150,205 125 S320 160,390 110 S500 80,565 130 S675 120,740 70 L740 220 L20 220 Z"/>
            <path class="line" d="M20 80 C90 100,130 150,205 125 S320 160,390 110 S500 80,565 130 S675 120,740 70"/>
            <circle cx="20" cy="80" r="7"/><circle cx="205" cy="125" r="7"/><circle cx="390" cy="110" r="7"/><circle cx="565" cy="130" r="7"/><circle cx="740" cy="70" r="7"/>
          </svg>
        </div><div class="insight-pill">Curiosity over certainty.</div>`,
      },
      {
        classes: "end-card",
        eyebrow: "Your daily loop",
        title: "Small records. More context.",
        lead: "You do not need a perfect streak or a perfectly written entry. Just a record you can return to.",
        extra: `<div class="loop-string"><span>Notice</span><b>→</b><span>Choose</span><b>→</b><span>Record</span><b>→</b><span>Reflect</span></div>
          <div class="cta">Begin with today <span>→</span></div>`,
      },
    ],
  },
  3: {
    title: "Why Patterns",
    accent: "amber",
    slides: [
      {
        classes: "cover",
        eyebrow: "Why it exists",
        title: "Made for thoughts you don’t want on someone else’s server.",
        lead: "Patterns was designed to feel <strong>private, calm, and intentional</strong> from the first entry.",
        art: "assets/private-space.png",
      },
      {
        eyebrow: "Private by design",
        title: "Your entries stay on your device.",
        lead: "No account. No automatic upload of your journal or OCD records. You decide what leaves your device.",
        extra: `<div class="privacy-stack">
          <div class="privacy-card"><div class="feature-icon">⌁</div><div><strong>Stored locally</strong><span>Your journal and tracked events remain on-device.</span></div></div>
          <div class="privacy-card"><div class="feature-icon">○</div><div><strong>No account required</strong><span>Open the app and begin privately.</span></div></div>
          <div class="privacy-card"><div class="feature-icon">↗</div><div><strong>Manual export</strong><span>You choose if and where to save a backup.</span></div></div>
        </div>`,
      },
      {
        eyebrow: "Calm by design",
        title: "A next step—not another noisy dashboard.",
        lead: "When your mind is already busy, the interface should ask less of you.",
        extra: `<div class="focus-ui">
          <div class="prompt">What would help right now?</div>
          <div class="focus-actions"><div class="focus-action primary">Write a journal entry</div><div class="focus-action">Track an OCD event</div></div>
          <div class="focus-note">Two clear paths. No feed. No public profile.</div>
        </div>`,
      },
      {
        eyebrow: "Clarity by design",
        title: "Patterns are context—not verdicts.",
        lead: "The app helps you see what has been happening. It does not tell you who you are or make a diagnosis.",
        extra: `<div class="comparison">
          <div class="no"><h3>Not this</h3><p>“A number that defines my progress.”</p><span class="mini">No score can summarize a complicated day.</span></div>
          <div class="yes"><h3>Instead</h3><p>“A record I can reflect on.”</p><span class="mini">Trends can add context to your own reflection.</span></div>
        </div>`,
      },
      {
        classes: "end-card",
        eyebrow: "Built with a boundary",
        title: "A companion to reflection. Not a replacement for care.",
        lead: "Use Patterns for personal journaling and self-tracking—and, if useful, as context for conversations with a qualified clinician.",
        extra: `<div class="cta">Private. Intentional. Yours.</div>
          <p class="disclaimer">Patterns does not diagnose, treat, prevent, or cure any condition. If you need clinical support, seek help from a qualified professional.</p>`,
      },
    ],
  },
  4: {
    title: "NF · OCD story",
    accent: "coral",
    slides: [
      {
        classes: "cover celebrity-cover",
        eyebrow: "OCD, in his own words",
        title: "NF on living with OCD.",
        lead: "He turned intrusive loops, rumination, and creative paralysis into music—and a reason to seek help.",
        portrait: {
          src: "assets/people/nf-2016.jpg",
          alt: "NF wearing a black cap",
          credit: "Photo: Capitol CMG · CC BY-SA 4.0",
          position: "center 26%",
        },
      },
      {
        eyebrow: "The diagnosis",
        title: "The tour ended. The spiral didn’t.",
        lead: "After the <strong>Perception</strong> tour, NF said he was in such a difficult mental state that he checked himself into therapy. There, he was diagnosed with OCD.",
        extra: `<div class="story-marker">
          <span>After the Perception tour</span><b>→</b><span>Therapy</span><b>→</b><span>OCD diagnosis</span>
        </div>
        <div class="pull-quote"><i>“</i><p>I was questioning my life. I was questioning everything.</p><cite>NF to NME, 2019</cite></div>`,
        source: "Source: NME interview, 11 Sep 2019",
      },
      {
        eyebrow: "What he described",
        title: "In his music, a thought can become a loop.",
        lead: "NF has written about ordinary thoughts feeling enormous, doubt filling the space, actions repeating, and thoughts circling again and again.",
        extra: `<div class="track-stack">
          <div class="track-card"><span>01</span><div><strong>The Search</strong><p>Names the OCD diagnosis and the weight of rumination.</p></div></div>
          <div class="track-card"><span>02</span><div><strong>Leave Me Alone</strong><p>Moves through repetition, overwhelm, doubt, and mental noise.</p></div></div>
          <div class="track-card"><span>03</span><div><strong>HOPE</strong><p>Holds growth and hard days in the same story.</p></div></div>
        </div>`,
        source: "Sources: The Search (2019); NME interviews (2019, 2023)",
      },
      {
        classes: "photo-story",
        eyebrow: "When OCD met the work",
        title: "The studio became another place to get stuck.",
        lead: "While making <strong>HOPE</strong>, he said the need for a song to feel “good enough” could turn into months of obsessing, unfinished tracks, and creative exhaustion.",
        extra: `<figure class="story-photo">
          <img src="assets/people/nf-2021.jpg" alt="NF performing live" />
          <figcaption>Photo: Walkster Z · CC BY-SA 4.0</figcaption>
        </figure>
        <div class="photo-quote"><p>“I obsessed about it so much.”</p><span>NF to NME, 2023</span></div>`,
        source: "Source: NME interview, 15 Apr 2023",
      },
      {
        eyebrow: "What changed",
        title: "Getting help became part of the story.",
        lead: "Therapy gave the spiral a name: OCD. Speaking about it gave NF a way to separate the person from the noise—and let listeners hear more than a stereotype.",
        extra: `<div class="truth-grid">
          <div><span>01</span><strong>OCD can be internal.</strong><p>Rumination and intrusive thoughts may be invisible from the outside.</p></div>
          <div><span>02</span><strong>Work can be affected.</strong><p>Obsession can block completion instead of improving it.</p></div>
          <div><span>03</span><strong>Help can begin with a name.</strong><p>A qualified assessment can turn confusion into a path forward.</p></div>
        </div>`,
        source: "Sources: NF’s accounts in NME, 2019 and 2023",
      },
      {
        classes: "end-card celebrity-end",
        eyebrow: "What his story leaves us",
        title: "You are more than the loop.",
        lead: "NF’s story does not offer a neat ending. It shows the value of naming what is happening, getting support, and staying honest about the work.",
        extra: `<div class="cta">Notice the pattern. Keep the person.</div>
          <p class="disclaimer">A public story is not medical guidance. OCD looks different across people. If symptoms are distressing or disruptive, consider speaking with a qualified mental-health professional.</p>`,
        source: "Interview sources and photo credits are documented with this post.",
      },
    ],
  },
  5: {
    title: "Howie Mandel · OCD story",
    accent: "blue",
    slides: [
      {
        classes: "cover celebrity-cover howie-cover",
        eyebrow: "OCD, beyond the punchline",
        title: "Howie Mandel on living with OCD.",
        lead: "Behind the jokes and fist bumps is a decades-long account of intrusive fear, avoidance, treatment, and openness.",
        portrait: {
          src: "assets/people/howie-2022.jpg",
          alt: "Howie Mandel holding a microphone",
          credit: "Photo: RoweCo · CC BY 2.0",
          position: "center 18%",
        },
      },
      {
        eyebrow: "Before the diagnosis",
        title: "It started long before he had a name for it.",
        lead: "Mandel said that, as a child, even touching shoelaces that had touched the ground felt impossible. He lived with obsessions and compulsions for decades before being diagnosed in his 40s.",
        extra: `<div class="story-marker">
          <span>Childhood fears</span><b>→</b><span>Family impact</span><b>→</b><span>Diagnosis</span>
        </div>
        <div class="pull-quote"><i>“</i><p>…lifted a huge weight off my shoulders.</p><cite>Howie Mandel to Healthline, 2023</cite></div>`,
        source: "Source: Healthline interview, updated 13 Oct 2023",
      },
      {
        eyebrow: "What he described",
        title: "Contamination fears shaped everyday contact.",
        lead: "Touch, handshakes, phones, laces, and shared surfaces could trigger intense distress. What looks like a preference from outside can become a restrictive cycle.",
        extra: `<div class="cycle-card">
          <div><span>1</span><strong>Intrusive fear</strong><p>“This may be contaminated.”</p></div>
          <b>→</b>
          <div><span>2</span><strong>Avoid or ritualize</strong><p>Don’t touch. Disinfect. Ask others to adapt.</p></div>
          <b>→</b>
          <div><span>3</span><strong>Short relief</strong><p>The fear returns—and the cycle narrows life.</p></div>
        </div>`,
        source: "Sources: Mandel’s memoir excerpt; Healthline interview, 2023",
      },
      {
        classes: "photo-story",
        eyebrow: "The person behind the persona",
        title: "A public smile can hide a private fight.",
        lead: "Mandel has said that family, professional help, and medication have made his life better. Humor and a busy career can coexist with OCD; neither means the disorder disappeared.",
        extra: `<figure class="story-photo howie-photo">
          <img src="assets/people/howie-samhsa.jpg" alt="Howie Mandel speaking at a mental-health event" />
          <figcaption>Photo: SAMHSA · Public domain</figcaption>
        </figure>
        <div class="photo-quote"><p>“Talk about it and be open.”</p><span>Howie Mandel to AARP, 2024</span></div>`,
        source: "Sources: CNN interview, 2009; AARP interview, 2024",
      },
      {
        eyebrow: "His advice",
        title: "Talk. Get help. Keep going.",
        lead: "Mandel says the first therapist, doctor, dose, or medication may not be the right fit. His message is persistence—not a promise of a quick fix.",
        extra: `<div class="advice-card">
          <div class="quote-mark">“</div>
          <p>Don’t ever give up.</p>
          <span>Howie Mandel to AARP, 2024</span>
        </div>
        <div class="advice-line"><span>Speak openly</span><i></i><span>Find qualified care</span><i></i><span>Adjust when needed</span></div>`,
        source: "Source: AARP interview, 2024",
      },
      {
        classes: "end-card celebrity-end",
        eyebrow: "What his story leaves us",
        title: "OCD is not a punchline.",
        lead: "Mandel’s openness challenges the idea that OCD simply means liking things clean. It can involve intrusive fears, avoidance, rituals, and major distress—and people deserve informed care.",
        extra: `<div class="cta">See the person. Learn the pattern.</div>
          <p class="disclaimer">A public story is not medical guidance. OCD looks different across people. If symptoms are distressing or disruptive, consider speaking with a qualified mental-health professional.</p>`,
        source: "Interview sources and photo credits are documented with this post.",
      },
    ],
  },
};

function footer(post, index, count) {
  const dots = Array.from({ length: count }, (_, i) => `<i class="dot ${i === index ? "active" : ""}"></i>`).join("");
  return `<footer class="footer"><div class="dots">${dots}</div><div class="swipe">${index === count - 1 ? "Patterns" : "Swipe"}<span class="swipe-arrow">${index === count - 1 ? "" : "→"}</span></div></footer>`;
}

function render() {
  const query = new URLSearchParams(location.search);
  const postNumber = Number(query.get("post") || 1);
  const slideNumber = Number(query.get("slide") || 1);
  const post = posts[postNumber] || posts[1];
  const index = Math.max(0, Math.min(post.slides.length - 1, slideNumber - 1));
  const data = post.slides[index];
  const root = document.getElementById("slide");
  root.className = `slide post-${postNumber} ${data.classes || ""}`;
  root.innerHTML = `
    <header class="topbar">
      <div class="brand"><img src="assets/logo.png" alt="" /><span>Patterns</span></div>
      <div class="series">${post.title} · ${String(index + 1).padStart(2, "0")}/${String(post.slides.length).padStart(2, "0")}</div>
    </header>
    ${data.art ? `<img class="hero-art" src="${data.art}" alt="" />` : ""}
    ${data.portrait ? `<figure class="hero-portrait" style="--portrait-position: ${data.portrait.position || "center"}"><img src="${data.portrait.src}" alt="${data.portrait.alt || ""}" /><figcaption>${data.portrait.credit}</figcaption></figure>` : ""}
    <section class="content">
      <div class="eyebrow">${data.eyebrow}</div>
      <h${data.classes?.includes("cover") ? "1" : "2"}>${data.title}</h${data.classes?.includes("cover") ? "1" : "2"}>
      ${data.lead ? `<p class="lead">${data.lead}</p>` : ""}
      ${data.extra || ""}
      ${data.source ? `<div class="source-note">${data.source}</div>` : ""}
    </section>
    ${footer(postNumber, index, post.slides.length)}
  `;
}

render();
