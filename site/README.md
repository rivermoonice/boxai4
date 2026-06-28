# Boxmining AI Academy — Site

Astro 7 site that serves the 19 Boxmining AI Academy lessons.

## Stack

- **Astro 7.0.3** with the new Rust compiler, Rolldown bundler, and Sätteri markdown engine (all default in 7)
- **MDX** via `@astrojs/mdx` for future component embedding
- **Sitemap** via `@astrojs/sitemap`
- **RSS** via `@astrojs/rss`
- **Pagefind** for static full-text search (zero-runtime indexing at build time)
- **No client-side JS framework** — Astro's island runtime only loads the theme toggle, progress tracking, and Pagefind UI

## Source of content

Lessons live at `../lessons/<module>/L##-*.md`, **outside** this Astro project. A custom content loader (`src/content.config.ts`) reads them at build time, parses the title, module, lesson number, and "Last tested" date from each file, and uses Astro's `renderMarkdown()` to compile the body through the same Shiki pipeline as MDX files. No lesson files are copied or modified.

## Development

```sh
npm install
npm run dev
```

Dev server at http://localhost:4321.

## Build

```sh
npm run build
```

Runs `astro build` then `pagefind --site dist` to generate the search index. Output goes to `dist/`. Deployable to any static host (Cloudflare Pages, Netlify, GitHub Pages, S3, etc.).

## Structure

```
site/
├── astro.config.mjs              # site URL, MDX, sitemap, Shiki config
├── package.json
├── public/
│   ├── favicon.svg / favicon.ico
│   └── og-default.svg           # default OG image
├── src/
│   ├── content.config.ts        # custom lessons loader
│   ├── data/specs.ts            # spec pages index
│   ├── styles/global.css        # design tokens + base styles
│   ├── components/
│   │   ├── Nav.astro            # sticky nav with theme toggle
│   │   ├── Footer.astro         # 4-col footer
│   │   └── LessonCard.astro     # lesson grid card
│   ├── layouts/
│   │   ├── BaseLayout.astro     # SEO + nav + footer shell
│   │   ├── ModuleLayout.astro   # module page shell
│   │   └── LessonLayout.astro   # lesson page with breadcrumb, prose, prev/next
│   └── pages/
│       ├── index.astro          # homepage
│       ├── 404.astro
│       ├── about.astro
│       ├── search.astro         # Pagefind UI host
│       ├── rss.xml.ts           # RSS feed of all lessons
│       ├── lessons/
│       │   ├── index.astro
│       │   ├── [module]/
│       │   │   ├── index.astro
│       │   │   └── [slug].astro
│       └── specs/
│           └── [slug].astro     # renders Specs/*.md files
```

## Features

- **Light + dark mode** with `prefers-color-scheme` default, manual toggle, localStorage persistence, no FOUC.
- **Progress tracking** per lesson via localStorage (`boxai4.progress`).
- **Search** via Pagefind. ~50KB client bundle loaded only on `/search/`.
- **JSON-LD** structured data: Course on the homepage, LearningResource on every lesson page, WebSite site-wide.
- **Open Graph + Twitter Card** meta on every page.
- **Sitemap** auto-generated, **RSS** feed of all 19 lessons.
- **A11y**: skip link, `prefers-reduced-motion`, focus styles, semantic HTML, ARIA labels.

## Adding a new lesson

1. Add a `.md` file under `../lessons/<module>/L##-<slug>.md` with a top-level `# Title` and `**Last tested and updated:** Month YYYY`.
2. Run `npm run build`. The lesson appears automatically on the homepage, the module page, the `/lessons/` index, the RSS feed, and the search index.