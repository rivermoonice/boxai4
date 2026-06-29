# Boxmining AI Academy — Site

Astro 7 site that serves the Boxmining AI Academy lessons and renders them as
MDX, so lessons can include interactive components like quizzes, terminal
screenshots, and video cards.

## Stack

- **Astro 7.0.3** with the new Rust compiler, Rolldown bundler, and Sätteri
  markdown engine (all default in 7).
- **MDX** via `@astrojs/mdx` — every lesson body is `mdx`.
- **Sitemap** via `@astrojs/sitemap`.
- **RSS** via `@astrojs/rss`.
- **Pagefind** for static full-text search (zero-runtime indexing at build).
- **Astro image pipeline** (`astro:assets` + `sharp`) for all raster assets —
  the standard `<Image>` and `<Picture>` components emit WebP/AVIF and a
  responsive `srcset`. See [Adding images to a lesson](#adding-images-to-a-lesson)
  below.
- **No client-side JS framework** — Astro islands only load the theme toggle,
  progress tracking, Pagefind UI, and the interactive lesson widgets
  (`<Quiz>`, `<VidCard>`, `<TerminalScreenshot>`).

## Source of content

Lessons live at `src/content/lessons/<module>/L##-<slug>.{md,mdx}`. Astro's
built-in **`glob` loader** reads them at build time and the page route calls
`render(lesson)` to get a `Content` component — identical behavior for `.md`
and `.mdx` files, so MDX lessons can use interactive components while plain
markdown lessons stay simple.

Lesson metadata is in YAML frontmatter at the top of each file:

```yaml
---
title: "What Is Hermes Agent? A Beginner's Guide to AI Agent Harnesses (2026)"
module: hermes
slug: l01-what-is-hermes-agent
order: 1
updatedDate: 2026-06-29
updatedRaw: "June 2026"
summary: "..."
description: "..."
readingMinutes: 8
accent: "#7c5cff"
---
```

The body follows. Markdown headings (`## Section`) become page sections.
MDX lets the body import and use Astro components.

`site/src/content.config.ts` is the schema definition; it enforces these
fields. `_skeletons/` directories inside each module are excluded from the
collection — they're draft proposals, not finished lessons.

## Development

```sh
npm install
npm run dev
```

Dev server at <http://localhost:4321>.

## Build

```sh
npm run build
```

Runs `astro build` then `pagefind --site dist`. Optimized images are emitted
under `dist/_astro/`. Output goes to `dist/`. Deployable to any static host
(Cloudflare Pages, Netlify, GitHub Pages, S3, etc.).

## Adding a new lesson

1. Pick a module and the next `L##` order number in that module's directory.
2. Copy an existing lesson from `src/content/lessons/<module>/` as a starting
   point, then update the frontmatter (`title`, `slug`, `order`, `updatedDate`,
   `summary`, `description`, `readingMinutes`) and rewrite the body.
3. If the lesson needs interactive components (quiz, terminal screenshot,
   callout, video card, image), use the MDX format (`L##-slug.mdx`) and import
   what you need:

   ```mdx
   ---
   import Quiz from '../../../components/lesson/Quiz.astro';
   import Callout from '../../../components/lesson/Callout.astro';
   import { Picture } from 'astro:assets';
   import diagram from '../../../assets/lessons/<module>/L##/<diagram>.svg';
   ---

   <Callout type="tip">One sentence of advice.</Callout>

   <Quiz questions={[
     { q: "...", choices: ["A", "B", "C"], answer: 1, explain: "..." },
   ]} />

   <Picture src={diagram} alt="..." width={800} height={400} formats={["avif", "webp"]} />
   ```

4. Run `npm run build`. The lesson appears automatically on the homepage, the
   module page, the `/lessons/` index, the RSS feed, the search index, and
   the sitemap.

## Adding images to a lesson

The site runs every raster image through Astro's image pipeline
(`astro:assets` + `sharp`). **Never** drop a PNG into `public/` and reference
it from a lesson — that bypasses the optimizer and ships a 200kB image to
mobile users. Use the pipeline instead.

### Where the source assets live

```
src/assets/lessons/<module>/L##/<name>.{png,jpg,svg}
```

These are imported into the MDX lesson file (Vite hashes them at build time)
and passed through `<Image>` or `<Picture>`. The output lands in
`dist/_astro/<hashed-name>.<format>` with a responsive `srcset`.

### When to use which component

| Component | Import | Use it for |
|---|---|---|
| `<Image>`  | `import { Image } from 'astro:assets';` | Most raster images (PNG screenshots, photos). Emits a single `<img>` with a multi-width `srcset` in WebP. |
| `<Picture>` | `import { Picture } from 'astro:assets';` | SVG diagrams that should render vector but be wrapped in `<picture>` so a raster fallback exists (e.g. for email clients). |
| `<TerminalScreenshot>` | `import TerminalScreenshot from '../../../components/lesson/TerminalScreenshot.astro';` | CLI captures — wraps `<Image>` with macOS-style window chrome (3 traffic-light dots, title bar). |
| `<img src="...">` (plain) | — | Only for assets that already live in `public/` (favicon, OG image). Don't use for lesson images. |

### Reference table: putting an image in a lesson

The MDX lesson file does three things: imports the asset, declares width/
height (the optimizer needs them to avoid CLS), passes it to the component.

```mdx
---
import { Picture } from 'astro:assets';
import diagram from '../../../assets/lessons/hermes/L01/brain-vs-harness.svg';

import hermesHelp from '../../../assets/lessons/hermes/L01/hermes-help.png';
import TerminalScreenshot from '../../../components/lesson/TerminalScreenshot.astro';
---

<Picture src={diagram} alt="..." width={800} height={420} formats={["avif", "webp"]} />

<TerminalScreenshot
  image={hermesHelp}
  title="hermes --help"
  alt="Output of the hermes --help command"
/>
```

`<Image>` requires `width` and `height` props. `<Picture>` likewise (used for
SVG aspect-ratio reservation). Without them, the build fails with
`MissingImageDimension`.

### Generating terminal screenshots

For CLI screenshots (Hermes, Claude Code, anything terminal-shaped), use the
capture + render pipeline at `scripts/`. It writes ready-to-import PNGs into
`src/assets/lessons/<module>/L##/`.

```sh
# 1. Capture real CLI output (no API keys needed for --help, status, doctor,
#    skills list, version).
bash scripts/capture-hermes.sh /tmp/hermes-captures

# 2. Render each capture as a styled PNG with macOS window chrome.
node scripts/render-terminal.mjs /tmp/hermes-captures src/assets/lessons/hermes/L01
```

Both steps are wrapped in the npm script `npm run capture:hermes` — read it
before changing it. The renderer accepts a `TRUNCATIONS` config block at the
top of `scripts/render-terminal.mjs` so each capture has a per-lesson line
budget. **L01 is an intro lesson — keep its screenshots short and focused.**
Later lessons can show more output.

The renderer strips ANSI escapes (we render in a single color for
consistency). If you need full-color terminal output for a dedicated lesson,
extend `scripts/render-terminal.mjs` rather than capturing the raw bytes
directly — the build pipeline assumes the source assets are PNGs coming out
of that script.

### SVG diagrams

Hand-authored SVGs in `src/assets/lessons/<module>/L##/<name>.svg`. Keep the
viewBox sensible (a 2:1 or 16:9 aspect ratio reads well inside the
`.lesson__body` container) and use the `--accent` variable of the lesson's
module for emphasis. SVGs render vector at every size, so no width/height
generation is needed for the asset itself — only for the `<Picture>` props.

### Things to never do

- Don't drop a PNG into `site/public/` and reference it with `<img src>`
  from a lesson — that ships the raw file with no WebP, no responsive
  variants, no width/height.
- Don't import images directly inside `<TerminalScreenshot>` or any
  `<Image>`-wrapping component — the MDX lesson imports the asset and passes
  it in as a prop.
- Don't reference remote URLs (e.g. `https://i.imgur.com/...`) for lesson
  illustrations — Astro's image pipeline can't optimize those, and they ship
  with no width/height. Either download the asset into `src/assets/` or
  treat it as a third-party resource (currently no lesson does this; ask
  before adding).
- Don't use the `image()` helper from `public/` with `<Image>` — the pipeline
  only optimizes assets that are imported through the module graph.

## Lesson components reference

These components live in `src/components/lesson/`. Import them by relative
path from a lesson MDX file.

| Component | What it does | When to use |
|---|---|---|
| `<Quiz questions={[...]} />` | Interactive multiple-choice; "Check answer" highlights correct/incorrect and reveals an explanation per question. | End-of-lesson self-check. Use 4–6 questions per lesson. |
| `<TerminalScreenshot image={...} title="..." alt="..." />` | Renders an `<Image>` inside macOS-window chrome (3 dots + title bar). | When showing real CLI output. |
| `<VidCard id="..." title="..." start={N} />` | Click-to-play YouTube thumbnail; the iframe mounts only on click. | Linking the source video in a lesson body. |
| `<Callout type="tip\|gotcha\|bottom-line">...</Callout>` | Styled aside: green / amber / accent. | "Ron's Pro Tip", warning, "Ron's Bottom Line". |
| `<Picture>` / `<Image>` from `astro:assets` | Optimized raster / vector. | Any other image. |

## Structure

```
site/
├── astro.config.mjs              # site URL, MDX, sitemap, Shiki, dropFirstH1 remark
├── package.json
├── public/
│   ├── favicon.svg / favicon.ico
│   └── og-default.svg           # default OG image
├── scripts/
│   ├── capture-hermes.sh        # script(1) wrapper for real CLI captures
│   ├── render-terminal.mjs      # sharp-based PNG renderer (macOS chrome)
│   └── migrate-frontmatter.py   # one-shot helper for the MDX migration
├── src/
│   ├── assets/                  # images, optimized through astro:assets
│   │   └── lessons/<module>/L##/*.png|svg
│   ├── content.config.ts        # glob loader, schema
│   ├── content/lessons/         # ⭐ the lessons live here (md or mdx)
│   │   ├── hermes/_skeletons/
│   │   ├── ai-models/_skeletons/
│   │   └── ai-projects/_skeletons/
│   ├── components/
│   │   ├── Nav.astro            # sticky nav with theme toggle
│   │   ├── Footer.astro         # 4-col footer
│   │   ├── LessonCard.astro     # lesson grid card
│   │   └── lesson/              # interactive widgets (Quiz, TerminalScreenshot, ...)
│   ├── layouts/
│   │   ├── BaseLayout.astro     # SEO + nav + footer shell
│   │   ├── ModuleLayout.astro   # module page shell
│   │   └── LessonLayout.astro   # lesson page with breadcrumb, prose, prev/next
│   ├── pages/
│   │   ├── index.astro          # homepage
│   │   ├── 404.astro
│   │   ├── about.astro
│   │   ├── search.astro         # Pagefind UI host
│   │   ├── rss.xml.ts           # RSS feed of all lessons
│   │   ├── lessons/[module]/[slug].astro
│   │   └── specs/[slug].astro   # renders Specs/*.md files
│   └── styles/global.css        # design tokens + base styles
```

## Features

- **Light + dark mode** with `prefers-color-scheme` default, manual toggle,
  localStorage persistence, no FOUC.
- **Progress tracking** per lesson via localStorage (`boxai4.progress`).
- **Search** via Pagefind. ~50 KB client bundle loaded only on `/search/`.
- **JSON-LD** structured data: Course on the homepage, LearningResource on
  every lesson page, WebSite site-wide.
- **Open Graph + Twitter Card** meta on every page.
- **Sitemap** auto-generated, **RSS** feed of every lesson.
- **Optimized images** through Astro's image pipeline — see below.
- **A11y**: skip link, `prefers-reduced-motion`, focus styles, semantic HTML,
  ARIA labels.

## Quality gate

`scripts/check-lesson.py` at the repo root runs over the lesson collection.
It only flags two things now:

1. Unfilled `<!-- TODO -->` markers.
2. Missing `**Last tested and updated: <Month YYYY>**` line.

Everything else is advisory. Use it as a quick sanity check before committing
a lesson — `python3 scripts/check-lesson.py site/src/content/lessons/`.
