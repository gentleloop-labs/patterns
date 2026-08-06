import { error, redirect } from '@sveltejs/kit';
import { postsForPage, totalPages } from '$lib/data/blog';
import type { EntryGenerator, PageLoad } from './$types';

// Page 1 lives at /blog, so this route only ever prerenders 2..totalPages.
export const entries: EntryGenerator = () =>
  Array.from({ length: Math.max(0, totalPages - 1) }, (_, i) => ({ page: String(i + 2) }));

export const load: PageLoad = ({ params }) => {
  const page = Number(params.page);

  if (!Number.isInteger(page) || page < 1) {
    throw error(404, 'Page not found');
  }
  // Keep a single canonical URL for the first page.
  if (page === 1) {
    throw redirect(308, '/blog');
  }
  if (page > totalPages) {
    throw error(404, 'Page not found');
  }

  return { page, totalPages, posts: postsForPage(page) };
};
