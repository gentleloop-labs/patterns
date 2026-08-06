import { error } from '@sveltejs/kit';
import { allTags, postsByTag, tagLabel } from '$lib/data/blog';
import type { EntryGenerator, PageLoad } from './$types';

export const entries: EntryGenerator = () => allTags.map(({ tag }) => ({ tag }));

export const load: PageLoad = ({ params }) => {
  const posts = postsByTag(params.tag);
  if (posts.length === 0) {
    throw error(404, 'Topic not found');
  }
  return { tag: params.tag, label: tagLabel(params.tag), posts };
};
