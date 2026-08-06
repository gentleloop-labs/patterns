import adapter from '@sveltejs/adapter-static';
import { mdsvex } from 'mdsvex';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  extensions: ['.svelte', '.md'],
  preprocess: [
    mdsvex({
      extensions: ['.md'],
      // Posts are plain prose - the post route owns the typography, so there is
      // no mdsvex layout component here.
      smartypants: {
        // House style uses " - " rather than em dashes; leave dashes alone.
        dashes: false
      }
    })
  ],
  kit: {
    adapter: adapter({
      pages: 'build',
      assets: 'build',
      fallback: undefined,
      precompress: false,
      strict: true
    }),
    prerender: {
      handleUnseenRoutes: ({ routes, message }) => {
        // Below one full page of posts there is no page 2, so the pagination
        // route has no entries and nothing links to it. That is correct, not a
        // build failure. Anything else unreachable still fails the build.
        const unexpected = routes.filter((id) => id !== '/blog/page/[page]');
        if (unexpected.length > 0) throw new Error(message);
      }
    }
  }
};

export default config;
