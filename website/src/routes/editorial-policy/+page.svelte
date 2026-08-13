<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import Footer from '$lib/sections/Footer.svelte';
  import { links } from '$lib/data/links';
  import { ClipboardCheck } from 'lucide-svelte';

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'WebPage',
      name: 'Patterns Editorial Policy',
      description:
        'How Patterns authors, sources, reviews, updates, and corrects its OCD educational content.',
      url: links.editorialPolicy,
      isPartOf: { '@type': 'WebSite', name: 'Patterns', url: links.site },
      author: { '@type': 'Person', name: 'Aftaab Siddiqui', url: links.author }
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'Editorial policy', item: links.editorialPolicy }
      ]
    }
  ];
</script>

<Seo
  title="Editorial Policy - How Patterns OCD Content Is Made"
  description="How Patterns separates evidence from experience, selects sources, checks drafts, handles corrections, and keeps educational content within its limits."
  path="editorial-policy"
  {jsonLd}
/>

<article class="policy section-pad">
  <ContentContainer>
    <header class="head">
      <div class="icon-tile"><ClipboardCheck size={34} color="var(--accent)" strokeWidth={1.75} /></div>
      <p class="eyebrow">Editorial policy</p>
      <h1 class="serif">How Patterns content is made</h1>
      <p>Clear authorship, visible sources, honest limits, and corrections that do not disappear.</p>
    </header>

    <div class="prose reading">
      <p class="lead">
        Patterns publishes educational OCD guides and first-person essays. Aftaab Siddiqui writes
        and is responsible for every article. Patterns is not a clinic, and its content does not
        diagnose, prescribe treatment, or replace a qualified professional.
      </p>

      <h2>Two kinds of content</h2>
      <p>
        <strong>Evidence-led guides</strong> explain established ideas about OCD, assessment, and
        treatment. Clinical claims must be supported by a named source. These articles use neutral
        language and do not tell readers what diagnosis they have.
      </p>
      <p>
        <strong>Personal essays</strong> describe Aftaab's own experience with OCD, ERP, privacy,
        and building Patterns. They are marked as lived experience and are not generalized into
        medical claims about other people.
      </p>

      <h2>Sources</h2>
      <p>
        Guides prioritize public health bodies, professional OCD organizations, treatment
        guidelines, systematic reviews, and peer-reviewed research. Sources appear at the end of
        the article so readers can inspect them directly. Statistics are not published without a
        source, and source quality matters more than the number of citations.
      </p>

      <h2>Drafting and fact checks</h2>
      <p>
        Aftaab chooses the question, writes from genuine experience where relevant, checks claims
        against the listed sources, and makes the final editorial decisions. Software tools may
        assist with research organization, structure, drafts, accessibility checks, and copy
        review. They do not supply lived experience or become the author.
      </p>
      <p>
        Some drafts may receive confidential factual feedback before publication. Confidential
        feedback is not public authorship, clinical review, or endorsement. Unless a named reviewer
        is visibly credited on an article, Patterns makes no claim that the page was clinically
        reviewed. Responsibility for the published page remains with Aftaab.
      </p>

      <h2>Safety and scope</h2>
      <ul>
        <li>Articles do not diagnose the reader or promise an outcome.</li>
        <li>Treatment information describes options and evidence without prescribing a plan.</li>
        <li>Examples avoid unnecessary graphic detail and are included only when they clarify the pattern.</li>
        <li>High-risk situations direct readers toward urgent local help rather than self-assessment.</li>
        <li>The app is presented as a journal and ERP companion, not a replacement for care.</li>
      </ul>

      <h2>Updates and corrections</h2>
      <p>
        Every article shows its publication date and the date of its last meaningful update. A date
        changes only when the content changes, not to create an appearance of freshness. When new
        evidence or guidance materially changes an article, the article is revised and its update
        date changes.
      </p>
      <p>
        Factual errors are corrected as soon as they are confirmed. A material correction that
        changes the meaning of the article should be noted on the page. Minor spelling, formatting,
        and broken-link fixes do not require a correction note.
      </p>

      <h2>Commercial independence</h2>
      <p>
        Patterns articles may link to the Patterns app where it is relevant. App links do not
        determine the conclusion of a guide, and the informational answer comes before the product
        invitation. Patterns does not accept paid placement in educational articles.
      </p>

      <div class="callout">
        <h2>Questions or corrections</h2>
        <p>
          Open an issue through the <a href={links.issues}>Patterns project</a> with the page URL,
          the statement in question, and a reliable supporting source. Do not include private
          health information in a public issue.
        </p>
      </div>
    </div>
  </ContentContainer>
</article>

<Footer />

<style>
  .policy {
    background: var(--surface);
  }

  .head {
    max-width: 760px;
    margin: 0 auto 48px;
    text-align: center;
  }

  .icon-tile {
    width: 80px;
    height: 80px;
    margin: 0 auto 28px;
    display: grid;
    place-items: center;
    border-radius: 20px;
    background: color-mix(in srgb, var(--accent) 10%, transparent);
  }

  .eyebrow {
    margin: 0 0 10px;
    color: var(--accent);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  h1 {
    margin: 0;
    font-size: 48px;
    line-height: 1.1;
  }

  .head > p:last-child {
    margin: 18px auto 0;
    max-width: 650px;
    color: var(--text-secondary);
    font-size: 18px;
    line-height: 1.6;
  }

  .prose {
    max-width: 720px;
    margin: 0 auto;
    color: var(--text-secondary);
    font-size: 17px;
  }

  .prose :global(.lead) {
    color: var(--text);
    font-size: 20px;
    line-height: 1.65;
  }

  .prose h2 {
    margin: 42px 0 14px;
    color: var(--text);
    font-size: 27px;
  }

  .prose p {
    margin: 0 0 18px;
  }

  .prose ul {
    padding-left: 22px;
  }

  .prose li {
    margin-bottom: 10px;
  }

  .prose strong {
    color: var(--text);
  }

  .prose a {
    color: var(--accent);
    text-decoration: underline;
    text-underline-offset: 3px;
  }

  .callout {
    margin-top: 36px;
    padding: 26px;
    border-radius: 18px;
    background: color-mix(in srgb, var(--accent) 7%, transparent);
  }

  .callout h2 {
    margin-top: 0;
  }

  .callout p:last-child {
    margin-bottom: 0;
  }

  @media (max-width: 599px) {
    h1 {
      font-size: 34px;
    }

    .head > p:last-child {
      font-size: 16px;
    }
  }
</style>
