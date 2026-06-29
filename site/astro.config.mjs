// @ts-check
import { defineConfig } from 'astro/config';

import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';

// Remark plugin: drop the first H1 in each lesson. The lesson title is
// already rendered in the layout (from frontmatter `title`), so the body H1
// is redundant. Applies to both markdown and MDX lessons.
function dropFirstH1() {
  return (tree) => {
    for (const node of tree.children) {
      if (node.type === 'heading' && node.depth === 1) {
        tree.children = tree.children.filter((n) => n !== node);
        break;
      }
    }
  };
}

// https://astro.build/config
export default defineConfig({
  site: 'https://boxai4.boxmining.ai',
  trailingSlash: 'always',
  integrations: [
    mdx(),
    sitemap(),
  ],
  markdown: {
    remarkPlugins: [dropFirstH1],
    shikiConfig: {
      // Light/dark dual-theme code highlighting. Astro 7 + Sätteri uses
      // CSS variables so the theme switches with the site.
      themes: { light: 'github-light', dark: 'github-dark' },
      wrap: true,
    },
  },
  mdx: {
    remarkPlugins: [dropFirstH1],
  },
  vite: {
    build: {
      // Inline small assets to keep page count down.
      assetsInlineLimit: 1024,
    },
  },
});