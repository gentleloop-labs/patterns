<script lang="ts">
  import Seo from '$lib/components/Seo.svelte';
  import ContentContainer from '$lib/components/ContentContainer.svelte';
  import Footer from '$lib/sections/Footer.svelte';
  import { links } from '$lib/data/links';
  import { UserRound } from 'lucide-svelte';

  const jsonLd = [
    {
      '@context': 'https://schema.org',
      '@type': 'ProfilePage',
      name: 'About Aftaab Siddiqui',
      url: links.author,
      mainEntity: {
        '@type': 'Person',
        name: 'Aftaab Siddiqui',
        url: links.author,
        description:
          'Founder and developer of Patterns, writing from lived experience with OCD and ERP.',
        sameAs: [links.maskedsyntax, 'https://github.com/maskedsyntax']
      }
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: links.site },
        { '@type': 'ListItem', position: 2, name: 'About Aftaab Siddiqui', item: links.author }
      ]
    }
  ];
</script>

<Seo
  title="About Aftaab Siddiqui - Author of the Patterns OCD Library"
  description="Aftaab Siddiqui lives with OCD and builds Patterns. Learn about the experience, limits, and editorial approach behind the Patterns OCD library."
  path="about/aftaab-siddiqui"
  {jsonLd}
/>

<article class="about section-pad">
  <ContentContainer>
    <header class="head">
      <div class="icon-tile"><UserRound size={34} color="var(--accent)" strokeWidth={1.75} /></div>
      <p class="eyebrow">About the author</p>
      <h1 class="serif">Aftaab Siddiqui</h1>
      <p>I live with OCD, and I build Patterns.</p>
    </header>

    <div class="prose reading">
      <p class="lead">
        I am the founder and developer of Patterns, a private OCD journal and ERP companion. I
        write the articles on this site from a combination of lived experience, careful research,
        and the limits of knowing that I am not a therapist or doctor.
      </p>

      <h2>Why I write about OCD</h2>
      <p>
        For years, I could describe the content of my intrusive thoughts in exhausting detail but
        could not see the response pattern around them. Learning to recognize obsessions,
        compulsions, reassurance, and avoidance gave me a language for what was happening between
        therapy sessions.
      </p>
      <p>
        Patterns grew out of that gap. The library has the same aim: explain one difficult question
        clearly enough that a reader can understand the pattern, find the next reliable resource,
        and have a more useful conversation with a qualified professional.
      </p>

      <h2>Experience is not clinical authority</h2>
      <p>
        My first-person essays describe only my own experience. They cannot establish what another
        person has, predict what treatment will do for them, or replace professional care.
        Evidence-led guides are separated from personal essays, cite their sources, and avoid
        diagnosing the reader.
      </p>

      <h2>Start with the honest version</h2>
      <ul>
        <li><a href="/blog/why-i-built-patterns">Why I built Patterns</a></li>
        <li><a href="/blog/between-therapy-sessions">The recovery that happens between therapy sessions</a></li>
        <li><a href="/blog/pure-o-mental-compulsions">Pure O and the mental compulsions I missed</a></li>
        <li><a href="/blog/why-patterns-stays-private">Why Patterns stays private</a></li>
      </ul>

      <div class="callout">
        <h2>How the library is produced</h2>
        <p>
          The <a href="/editorial-policy">Patterns editorial policy</a> explains sourcing,
          corrections, updates, authorship, and the line between education and care.
        </p>
      </div>
    </div>
  </ContentContainer>
</article>

<Footer />

<style>
  .about {
    background: var(--surface);
  }

  .head {
    max-width: 720px;
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
  }

  .head > p:last-child {
    margin: 14px 0 0;
    color: var(--text-secondary);
    font-size: 19px;
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
      font-size: 36px;
    }
  }
</style>
