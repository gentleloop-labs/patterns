import { error } from '@sveltejs/kit';
import { getPost, loadPostBody, posts, relatedPosts } from '$lib/data/blog';
import type { EntryGenerator, PageLoad } from './$types';

// Enumerate every post so the static adapter prerenders each blog URL.
export const entries: EntryGenerator = () => posts.map((post) => ({ slug: post.slug }));

export const load: PageLoad = async ({ params }) => {
  const post = getPost(params.slug);
  if (!post) {
    throw error(404, 'Post not found');
  }

  // This is a universal load, so it re-runs on the client during hydration and
  // the component below never has to survive serialization.
  const body = await loadPostBody(post.slug);
  if (!body) {
    throw error(404, 'Post not found');
  }

  return { post, body, related: relatedPosts(post) };
};
