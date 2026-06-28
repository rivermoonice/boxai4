// @ts-check
import { defineConfig } from 'astro/config';

import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  site: 'https://boxai4.boxmining.ai',
  trailingSlash: 'always',
  integrations: [
    mdx(),
    sitemap(),
  ],
  markdown: {
    shikiConfig: {
      // Light/dark dual-theme code highlighting. Astro 7 + Sätteri uses
      // CSS variables so the theme switches with the site.
      themes: { light: 'github-light', dark: 'github-dark' },
      wrap: true,
    },
  },
  vite: {
    build: {
      // Inline small assets to keep page count down.
      assetsInlineLimit: 1024,
    },
  },
});