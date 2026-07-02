# Boxmining AI Academy Brand Specification

**Version:** 1.0  
**Created:** June 30, 2026  
**Applies to:** Boxmining AI Academy website, lessons, module pages, search, references, and future course assets  
**Design direction:** Friendly, practical AI learning with a warm code-editor sensibility inspired by Claude Code, adapted into a clearer education product.

---

## 1. Brand Promise

Boxmining AI Academy helps capable beginners understand modern AI tools without hype, gatekeeping, or visual intimidation.

The product should feel like a calm mentor sitting beside you at a real workstation: technical enough to be credible, warm enough to keep going, and spacious enough that the learner never feels rushed.

**One-line promise:** Learn practical AI workflows in plain English, with enough structure to actually use them.

**What the current UI is missing:**

- It feels too severe. The dark background and muted text create a terminal-first mood, but not a learning-first mood.
- The page spacing feels compressed. Important lesson sections do not get enough breathing room.
- The visual hierarchy is blunt. Large headings work, but supporting elements, cards, rails, buttons, and progress states do not feel inviting.
- The color system is too narrow. The palette relies heavily on near-black, cream, and one or two bright accents, so the course feels flat instead of guided.
- The lesson experience feels like documentation. It should feel like a course: oriented, encouraging, structured, and easy to resume.

---

## 2. Brand Personality

### Core Traits

**Friendly**
: The interface should make beginners feel welcome. Use warmth, plain language, clear affordances, and gentle guidance.

**Practical**
: The academy is not a glossy marketing site. It teaches real tools, trade-offs, and workflows. The design should support concentration.

**Calm**
: Avoid visual shouting. Use soft contrast, comfortable spacing, stable layouts, and predictable interaction states.

**Credible**
: The site should look maintained, current, and technically trustworthy. Code examples, diagrams, and lesson states must feel deliberate.

**Momentum-building**
: Learners should always know where they are, what they have finished, and what to do next.

### Personality Slider

| Dimension | Direction |
|---|---|
| Warm vs. cold | Warm, but not cozy to the point of looking unserious |
| Technical vs. casual | Technical foundation with casual explanations |
| Editorial vs. app-like | App-like learning shell with editorial lesson content |
| Dense vs. airy | Airy by default, dense only inside tables/code |
| Premium vs. playful | Premium learning tool with small playful details |

---

## 3. Visual Concept

### Working Theme: Warm Terminal Classroom

Use the emotional memory of Claude Code: warm dark surfaces, parchment-like light mode, restrained orange accents, calm typography, and a sense of being inside a focused developer tool.

Then soften it for education:

- More whitespace than a terminal.
- More legible contrast than a mood board.
- More color variety than a monochrome code editor.
- Clear module identity colors so learners can orient themselves.
- Progress, checkpoints, and next steps that feel encouraging.

The site should not look like a startup landing page. It should look like a polished course workspace.

---

## 4. Color System

The palette is inspired by Claude Code and Anthropic-adjacent warmth, but it must be owned by Boxmining AI Academy. Do not copy a product UI directly.

### Palette Roles

| Role | Light | Dark | Usage |
|---|---:|---:|---|
| Canvas | `#F7F1E7` | `#181612` | Page background |
| Canvas soft | `#FBF7EF` | `#211E19` | Alternate bands, lesson panels |
| Surface | `#FFFDF8` | `#28231D` | Cards, nav, sidebars, raised controls |
| Surface warm | `#F1E5D4` | `#332B22` | Callouts, selected states, gentle emphasis |
| Text primary | `#221F1A` | `#F4EDE1` | Body and headings |
| Text secondary | `#62584C` | `#C9BBA8` | Ledes, descriptions, nav |
| Text subtle | `#8E8170` | `#8D806F` | Metadata, timestamps, labels |
| Border soft | `#E0D2BF` | `#40382F` | Default dividers |
| Border strong | `#C7B49B` | `#5C4E41` | Interactive borders, tables |
| Primary accent | `#C96442` | `#E08A62` | Primary actions, active states, highlights |
| Primary accent hover | `#A94E31` | `#F0A27E` | Button hover, active link hover |
| Focus | `#2F7E6D` | `#75C9B7` | Focus rings, success/progress |
| Link | `#2D5F8B` | `#86B8E8` | Text links |
| Warning | `#B97813` | `#E8B957` | Gotchas, caution states |
| Success | `#3F7C55` | `#86C995` | Completion states |
| Info | `#586FBA` | `#A9B8FF` | Concept notes and references |

### Module Colors

Each module needs a stable identity color. These should appear as slim accents, icons, badges, progress segments, and module chips, not huge saturated fields.

| Module | Accent | Dark Accent | Feeling |
|---|---:|---:|---|
| Hermes Agent | `#C96442` | `#E08A62` | Warm, practical, tool-focused |
| AI Model Comparison | `#2F7E6D` | `#75C9B7` | Analytical, steady, decision-oriented |
| AI Projects | `#586FBA` | `#A9B8FF` | Creative, building, forward motion |

### Color Rules

- Use warm neutrals as the base, not pure black and white.
- Do not let the UI become all brown, all orange, or all beige. Balance warmth with sage, blue, and cool link colors.
- Reserve the primary orange accent for meaningful actions or active states.
- Never use low-contrast muted text for lesson body content.
- Use color plus shape or label for state. Do not rely on color alone.
- Keep dark mode warm, but raise the surface contrast enough that cards, sidebars, and code blocks are easy to distinguish.

---

## 5. Typography

### Font Strategy

Use system fonts first for speed and reliability.

**Primary UI/Text Stack**

```css
font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
```

If no custom font is loaded, the system stack is acceptable. If a custom font is later added, prefer Inter, Geist, or a similarly readable sans. Do not use decorative display fonts.

**Code Stack**

```css
font-family: "SF Mono", ui-monospace, Menlo, Consolas, monospace;
```

### Type Principles

- Body text should be relaxed and readable: `18px` desktop, `16px` mobile, `1.7` line height for lessons.
- Lesson headings should feel like signposts, not billboards.
- Use large hero type only on the homepage and module landing pages.
- Avoid negative letter spacing except very lightly on large headings.
- Metadata labels should be small but readable, with enough contrast.
- Keep line length between `62ch` and `76ch` for lesson prose.

### Suggested Scale

| Token | Size | Usage |
|---|---:|---|
| `--fs-xs` | `0.78rem` | Eyebrows, metadata |
| `--fs-sm` | `0.9rem` | Secondary UI, cards |
| `--fs-base` | `1rem` | UI body |
| `--fs-reading` | `1.08rem` | Lesson prose |
| `--fs-md` | `1.18rem` | Ledes, card text |
| `--fs-lg` | `1.35rem` | Small headings |
| `--fs-xl` | `1.7rem` | Section headings |
| `--fs-2xl` | `2.2rem` | Page headings |
| `--fs-3xl` | `3rem` | Homepage/module hero |

---

## 6. Layout And Spacing

The site needs more room to breathe. The current pages feel compressed vertically and horizontally, especially lessons with a right rail.

### Layout Goals

- Make the first viewport orient the learner quickly.
- Keep lesson reading comfortable.
- Make navigation and progress visible without crowding the prose.
- Use section spacing to create rhythm and reduce fatigue.

### Global Layout Tokens

| Token | Value | Usage |
|---|---:|---|
| `--page-gutter` | `clamp(1.25rem, 4vw, 3rem)` | Left/right page padding |
| `--content-width` | `72ch` | Lesson prose max width |
| `--wide-width` | `1180px` | Home/module/search pages |
| `--lesson-grid` | `minmax(0, 760px) 320px` | Lesson body + right rail |
| `--section-gap` | `clamp(4rem, 8vw, 7rem)` | Major page sections |
| `--block-gap` | `1.5rem` | Groups inside a section |
| `--radius-sm` | `6px` | Inputs, inline code |
| `--radius-md` | `8px` | Cards, buttons, callouts |
| `--radius-lg` | `12px` | Lesson panels, progress card |

### Spacing Rules

- Increase homepage hero top/bottom padding, but keep the next section peeking into view.
- Lesson pages should start below the nav with a complete lesson header, not jump straight into body text.
- Use at least `3rem` between major lesson sections.
- Use `1rem-1.25rem` between paragraphs in lesson prose.
- Right rail cards should not sit too close to the main text. Use at least `4rem` column gap on desktop.
- On mobile, the right rail becomes a progress section below the lesson intro, not a cramped sidebar.

---

## 7. Core UI Components

### Navigation

The nav should feel like a quiet learning app toolbar.

- Use a warmer surface with subtle blur, not a heavy dark bar.
- Keep the brand mark simple, but consider replacing the blue diamond with a warmer mark or two-tone module spark.
- Active nav links need a visible state.
- The theme toggle should feel tactile and consistent with other icon buttons.
- On mobile, expose Lessons and Search. Do not hide nearly everything except GitHub.

### Buttons

Primary buttons should be warm and confident.

| Variant | Style |
|---|---|
| Primary | Filled primary accent, dark text in light mode only if contrast passes; otherwise use light text |
| Secondary | Surface fill with strong border |
| Ghost | Text/link button with subtle hover background |
| Disabled | Lower opacity, no hover motion |

Button copy should be action-oriented:

- `Start Lesson`
- `Continue`
- `Browse Lessons`
- `Mark As Read`
- `Next Lesson`

### Cards

Cards should be calm containers, not dark slabs.

- Use `8px` radius by default.
- Add a visible top or left accent strip for module identity.
- Avoid nested cards.
- Use clear metadata rows: lesson count, updated date, estimated time.
- Card hover should slightly raise contrast or border, not jump.

### Lesson Header

Every lesson page should open with an orientation area:

- Module chip
- Lesson number
- Title
- Plain-English summary
- Reading time
- Last updated date
- Primary action or progress state
- Optional “What you will do” bullets

This makes lessons feel like intentional course units.

### Progress Rail

The progress rail should support confidence, not just store a button.

Required elements:

- Module name and lesson position, such as `Hermes Agent · Lesson 1 of 10`
- Progress bar with label
- `Mark as read` or `Completed`
- Previous/next lesson links
- Small “You are here” course map when space allows

### Callouts

Callouts are a major part of the learning voice.

| Type | Color | Usage |
|---|---|---|
| Tip | Sage/green | Practical help |
| Gotcha | Amber | Mistakes, costs, limits |
| Bottom line | Primary orange | Ron-style verdict |
| Note | Blue | Concept support |

Each callout needs a short label, clear border, and enough padding. Avoid loud full-color fills.

### Code Blocks

Code blocks should feel like a friendly terminal, not an unreadable black box.

- Use warm dark surface in both themes when helpful.
- Include optional filename/title bar where useful.
- Use comfortable padding.
- Keep border visible.
- Inline code should be subtle and readable.

### Tables

Tables are important for comparisons and costs.

- Keep header rows distinct.
- Add horizontal breathing room.
- Use zebra tint sparingly for long tables.
- On mobile, allow horizontal scrolling with a visible edge affordance.

---

## 8. Learning UX Principles

### Orientation

Learners should always be able to answer:

- What course/module am I in?
- What lesson am I on?
- Why does this lesson matter?
- How long will it take?
- What do I do after this?

### Confidence

The UI should reduce anxiety:

- Use labels like `Beginner-friendly`, `No setup required`, or `Hands-on` when true.
- Put prerequisites near the top.
- Make progress visible.
- Make mistakes feel normal through gotcha callouts and troubleshooting sections.

### Resumption

Returning learners should immediately see:

- Continue lesson
- Completed lessons
- Next recommended lesson
- Recently updated lessons

### Rhythm

Long lessons need visual rhythm:

- Intro orientation
- Short paragraphs
- Frequent subheads
- Callouts
- Diagrams/screenshots
- Quizzes
- Next-step footer

Do not make a lesson feel like a single endless article.

---

## 9. Page-Level Direction

### Homepage

The homepage should answer: “Is this for me, and where should I start?”

Required changes:

- Warmer hero with more human welcome.
- Reduce the giant dark empty field.
- Add a concise path chooser: `Learn AI agents`, `Choose a model`, `Build a project`.
- Make module cards feel like starting points, not generic tiles.
- Show progress/lesson count in a friendlier way.

### Module Page

The module page should feel like a course syllabus.

Required elements:

- Module promise
- Who it is for
- Lesson list with completion state
- Estimated total time
- Recommended first lesson

### Lesson Page

The lesson page should feel like a guided learning session.

Required elements:

- Lesson intro panel
- Better vertical spacing
- Reading progress
- Helpful right rail
- Better callout styling
- Clear next lesson footer

### Search Page

Search should feel utilitarian and forgiving.

Required elements:

- Large input with clear affordance
- Helpful empty state
- Results grouped by lesson/module when possible
- Highlight module identity

### Spec Pages

Spec pages are internal reference material. They can be denser than lessons, but should still inherit the friendly reading system.

---

## 10. Voice And Microcopy

### Voice

Use plain English with direct encouragement.

Good:

- “Start here if you are new to AI agents.”
- “You do not need to understand every term yet.”
- “This is the part beginners usually miss.”
- “By the end, you will have a working mental model.”

Avoid:

- “Unlock the future of autonomous AI.”
- “Revolutionary agentic workflows.”
- “Master everything in minutes.”
- “Seamless cutting-edge productivity.”

### UI Copy Rules

- Prefer verbs for buttons.
- Use “lesson” and “module” consistently.
- Keep labels short.
- Use friendly empty states, not error-like dead ends.
- Never blame the user.

---

## 11. Accessibility Standards

Minimum requirements:

- Body text contrast: WCAG AA or better.
- Interactive element contrast: WCAG AA or better.
- Visible focus ring on every interactive element.
- Hit target minimum: `44px` for touch where practical.
- Do not hide primary navigation on mobile.
- Do not rely on color alone for module or completion states.
- Keep reading line length controlled.
- Respect reduced motion.
- All images need useful alt text.

---

## 12. Motion And Interaction

Motion should be restrained and helpful.

Allowed:

- Subtle hover border or background change.
- Small progress transitions.
- Gentle disclosure animation for accordions.
- Smooth but brief theme transition.

Avoid:

- Floating decorative shapes.
- Overly bouncy cards.
- Scroll-jacking.
- Long animations that delay reading.

Interaction should make the learner feel grounded, not entertained.

---

## 13. Implementation Tokens

These tokens should replace or extend the current global CSS variables.

```css
:root {
  --canvas: #F7F1E7;
  --canvas-soft: #FBF7EF;
  --surface: #FFFDF8;
  --surface-warm: #F1E5D4;
  --text: #221F1A;
  --text-muted: #62584C;
  --text-subtle: #8E8170;
  --border: #E0D2BF;
  --border-strong: #C7B49B;
  --accent: #C96442;
  --accent-hover: #A94E31;
  --focus: #2F7E6D;
  --link: #2D5F8B;
  --warning: #B97813;
  --success: #3F7C55;
  --info: #586FBA;
}

:root[data-theme="dark"] {
  --canvas: #181612;
  --canvas-soft: #211E19;
  --surface: #28231D;
  --surface-warm: #332B22;
  --text: #F4EDE1;
  --text-muted: #C9BBA8;
  --text-subtle: #8D806F;
  --border: #40382F;
  --border-strong: #5C4E41;
  --accent: #E08A62;
  --accent-hover: #F0A27E;
  --focus: #75C9B7;
  --link: #86B8E8;
  --warning: #E8B957;
  --success: #86C995;
  --info: #A9B8FF;
}
```

Mapping to the current codebase:

```css
--bg: var(--canvas);
--bg-elev: var(--surface);
--bg-sunk: var(--canvas-soft);
--fg: var(--text);
--fg-muted: var(--text-muted);
--fg-subtle: var(--text-subtle);
```

---

## 14. Redesign Acceptance Criteria

The redesign is successful when:

- The homepage feels warmer within three seconds.
- Lesson pages feel less cramped on desktop and mobile.
- Body text is easier to read in both light and dark mode.
- Module cards clearly communicate where to start.
- The progress rail helps learners continue, not merely mark a lesson read.
- Color feels inspired by Claude Code warmth without becoming a copy or a one-note beige/orange theme.
- All core pages work at mobile, tablet, and desktop widths.
- The site still feels practical and no-hype.

---

## 15. Recommended First Redesign Pass

Implement in this order:

1. Replace global color tokens and improve light/dark surface contrast.
2. Increase page gutters, lesson column gap, and vertical section spacing.
3. Redesign the nav, buttons, and cards with the new palette.
4. Redesign lesson header and progress rail.
5. Improve callouts, code blocks, tables, and quiz components.
6. Verify homepage, module page, lesson page, search, and specs in both themes.
7. Run accessibility checks for contrast, focus states, and mobile navigation.

This order gives the site an immediate emotional improvement while protecting the learning experience from regressions.

