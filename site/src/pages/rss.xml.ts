// RSS feed for new and updated lessons.
// Uses Astro's @astrojs/rss helper with the lessons content collection.

import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import { MODULES, moduleMeta, type ModuleName } from '../content.config';

const siteUrl = 'https://boxai4.boxmining.ai';

export async function GET(context: { site: URL }) {
  const lessons = await getCollection('lessons');
  const sorted = lessons.sort(
    (a, b) => b.data.updatedDate.getTime() - a.data.updatedDate.getTime(),
  );

  return rss({
    title: 'Boxmining AI Academy',
    description:
      'A beginner-friendly course built from BoxminingAI\'s YouTube library. 19 lessons across Hermes agent, AI model comparison, and new AI projects.',
    site: context.site ?? siteUrl,
    items: sorted.map((l) => {
      const mod = l.data.module as ModuleName;
      const modMeta = moduleMeta[mod];
      return {
        title: l.data.title,
        description: l.data.summary || l.data.description,
        pubDate: l.data.updatedDate,
        link: `/lessons/${mod}/${l.data.slug}/`,
        categories: [modMeta.title, `Lesson L${String(l.data.order).padStart(2, '0')}`],
      };
    }),
    customData: `<language>en-us</language>`,
  });
}