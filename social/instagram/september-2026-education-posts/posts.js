const posts = [
  {
    id: "01-reassurance-loop",
    number: "01 / 05",
    accent: "yellow",
    eyebrow: "THE REASSURANCE LOOP",
    title: "Why reassurance never feels finished",
    deck: "For OCD, an answer can become a ritual—not a lasting resolution.",
    illustration: "assets/illustrations/01-reassurance-loop.png",
    alt: "A person caught in a loop of repeated questions on their phone",
    layout: "flow",
    items: [
      ["Doubt feels urgent", "The question seems to need an answer now."],
      ["You ask, search or compare", "The aim is complete certainty or relief."],
      ["Relief arrives", "It helps briefly, which rewards the ritual."],
      ["A new ‘what if?’ appears", "The loop asks for one more answer."],
    ],
    takeaway: "ERP practises allowing uncertainty without another reassurance round.",
  },
  {
    id: "02-mental-compulsions",
    number: "02 / 05",
    accent: "blue",
    eyebrow: "OCD, OUT OF SIGHT",
    title: "Mental compulsions can be invisible",
    deck: "The function matters more than whether anyone else can see it.",
    illustration: "assets/illustrations/02-mental-compulsions.png",
    alt: "A person surrounded by looping thoughts and internal checking symbols",
    layout: "list",
    items: [
      ["Mental review", "Replaying a memory until it feels resolved."],
      ["Internal checking", "Testing feelings, certainty or bodily reactions."],
      ["Neutralizing", "Replacing a ‘bad’ thought until distress shifts."],
      ["Rumination", "Analyzing the same question for a perfect answer."],
    ],
    takeaway: "Ask: is this practical reflection—or an attempt to remove discomfort right now?",
  },
  {
    id: "03-erp-two-parts",
    number: "03 / 05",
    accent: "green",
    eyebrow: "OCD TREATMENT",
    title: "ERP has two parts—and both matter",
    deck: "Exposure and Response Prevention is more than simply ‘facing a fear.’",
    illustration: "assets/illustrations/03-erp-two-parts.png",
    alt: "A person taking manageable steps toward a valued goal while leaving a ritual behind",
    layout: "split",
    items: [
      ["01 · EXPOSURE", "Gradually approach a planned trigger, thought or uncertainty."],
      ["02 · RESPONSE PREVENTION", "Reduce the ritual, avoidance or reassurance that usually follows."],
    ],
    takeaway: "Good ERP is collaborative, gradual and tailored with an OCD-trained clinician.",
  },
  {
    id: "04-urgent-doubt",
    number: "04 / 05",
    accent: "coral",
    eyebrow: "WHEN DOUBT FEELS URGENT",
    title: "Urgency is part of the alarm",
    deck: "It is not proof that the thought must be solved right now.",
    illustration: "assets/illustrations/04-urgent-doubt.png",
    alt: "A person pausing beside a loud alarm before returning to an ordinary activity",
    layout: "steps",
    items: [
      ["NOTICE", "A doubt or intrusive thought showed up."],
      ["SPOT", "What action is OCD requesting—check, search, confess, review?"],
      ["PAUSE", "Create a small delay before responding."],
      ["RETURN", "Choose the next ordinary action while uncertainty is present."],
    ],
    takeaway: "The goal is not certainty first. It is choosing your response with uncertainty present.",
  },
  {
    id: "05-recovery-progress",
    number: "05 / 05",
    accent: "yellow",
    eyebrow: "OCD RECOVERY",
    title: "Recovery is not always feeling calm",
    deck: "A hard day can still contain meaningful practice.",
    illustration: "assets/illustrations/05-recovery-progress.png",
    alt: "A person moving toward what matters while carrying an anxious feeling beside them",
    layout: "list",
    items: [
      ["Delaying a compulsion", "Even a short pause changes the automatic sequence."],
      ["Leaving a question open", "Not every doubt needs another round of checking."],
      ["Returning to what matters", "A valued action can happen while anxiety is present."],
      ["Sharing the full pattern", "Mental rituals and avoidance belong in the conversation too."],
    ],
    takeaway: "Count the practice, not perfection.",
  },
];

function itemMarkup(item, index, layout) {
  const [title, body] = item;
  const marker = layout === "steps" ? String(index + 1).padStart(2, "0") : "";
  return `
    <article class="item">
      ${marker ? `<span class="marker">${marker}</span>` : ""}
      <div><h2>${title}</h2><p>${body}</p></div>
    </article>`;
}

function render(post) {
  document.title = `${post.number} · ${post.title}`;
  document.getElementById("post").className = `post ${post.accent} layout-${post.layout}`;
  document.getElementById("post").innerHTML = `
    <header>
      <div class="brand">
        <img src="../launch-carousels/assets/logo.png" alt="Patterns logo" />
        <span>patterns<span class="brand-dot">.</span></span>
      </div>
      <span class="series">OCD EDUCATION · ${post.number}</span>
    </header>

    <section class="intro">
      <p class="eyebrow">${post.eyebrow}</p>
      <h1>${post.title}</h1>
      <p class="deck">${post.deck}</p>
    </section>

    <section class="stage">
      <div class="illustration-wrap">
        <span class="shape shape-one"></span>
        <span class="shape shape-two"></span>
        <img class="illustration" src="${post.illustration}" alt="${post.alt}" />
      </div>
      <div class="items">${post.items.map((item, index) => itemMarkup(item, index, post.layout)).join("")}</div>
    </section>

    <aside class="takeaway"><span>TRY THIS LENS</span><p>${post.takeaway}</p></aside>

    <footer>
      <span>@patternsocd</span>
      <span>Education only · not diagnosis or treatment</span>
      <span>patternsocd.com</span>
    </footer>`;
}

const params = new URLSearchParams(window.location.search);
const requested = Number.parseInt(params.get("post") || "1", 10);
render(posts[Math.min(Math.max(requested, 1), posts.length) - 1]);
