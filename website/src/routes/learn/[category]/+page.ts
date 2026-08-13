import { error } from '@sveltejs/kit';
import { blogCategories, getBlogCategory, postsByCategory, type BlogCategory } from '$lib/data/blog';
import type { EntryGenerator, PageLoad } from './$types';

export const entries: EntryGenerator = () =>
  blogCategories.map((category) => ({ category: category.slug }));

export const load: PageLoad = ({ params }) => {
  const category = getBlogCategory(params.category);
  if (!category) {
    throw error(404, 'Library category not found');
  }

  return {
    category,
    posts: postsByCategory(category.slug as BlogCategory)
  };
};
