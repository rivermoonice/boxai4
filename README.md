# boxai4 — BoxminingAI Course Builder

## What this is

A course built from our YouTube library. We produce a lot of videos; we want them organised into a small number of **modules → lessons**, where each lesson is built from one or more videos (we can combine, split, and reorder segments to teach a topic rather than mirror the upload order).

This repo is the source of truth for the course curriculum. Database tables are populated alongside it.

## Course scope (v1)

We're focusing the first cut on three pillars, picked to match our strongest video coverage:

1. **New AI projects** — hands-on builds, integrations, automations (anything that's "we shipped X this week" or "we built Y with Hermes").
2. **Hermes agent** — install, configure, daily-driver workflows, releases.
3. **AI model comparison** — tier list, model-vs-model benchmarks, new releases from major labs.

Everything else (general news, vendor commentary, one-off commentary shorts) is out of scope for v1 and goes in the **Backlog** until promoted.

## Source data

All curriculum work is derived from these fields in the Supabase project `BoxminingAI`:

| Field | Where | Notes |
|---|---|---|
| Title | `public.videos.title` | Primary topic signal. |
| Transcript | `public.videos.transcript_content` | The canonical source — what the video actually says. |
| Timestamped segments | `public.videos.transcript_segments` | JSON `[{ start, duration, text }]` for jump-to-timestamp links. |
| Summary + verdict | `public.videos.summary_content`, `summary_verdict`, `summary_key_takeaways` | AI-written synopsis already produced for 306 videos. |
| YouTube description | `public.videos.youtube_description` | Currently populated for only 13 of 428 videos — treat as a secondary signal. |
| Tags | `public.videos.tags` | Heavy overlap (most videos carry the same generic bundle) — useful only when the *specific* tag matches (e.g. `hermes agent update`, `model-tier-list`). |

Counts (as of 2026-06-24):
- 428 videos total
- 296 with transcripts
- 306 with summaries
- 13 with YouTube descriptions
- 26 with timestamped segments

We **only** use transcripts and descriptions to build the curriculum — no outside knowledge of the videos.

## How a lesson is built

A lesson is a markdown file under `lessons/` keyed by topic, e.g.:

```
lessons/
  hermes/
    L01-install-and-first-run.md
    L02-daily-driver-tui-vs-desktop.md
    ...
  ai-models/
    L01-tier-list-methodology.md
    ...
  projects/
    L01-...md
```

Each lesson file contains:
- **Goal** — what the learner can do after watching.
- **Source videos** — list of `video_id`s from `public.videos`, in playback order.
- **Segments** — start/duration ranges into those videos (from `transcript_segments`) that cover the lesson. Multiple videos may be combined.
- **Watch link** — `https://www.youtube.com/watch?v=<id>&t=<seconds>` for each segment.
- **Why this grouping** — one-line rationale, anchored in what the transcript actually says.

A **module** is a directory; modules are sequenced in `course-outline.md` (TBD).

## Existing taxonomy (from `public.folders`)

The Supabase app already has a folder system. We're reusing it where it matches and adding what's missing:

| Folder | Reuse? | Course module |
|---|---|---|
| OpenClaw | Yes (installer only — not a course topic) | — |
| Claude Code | Yes — pull videos tagged `claude-code` | Backlog (out of scope v1) |
| Getting Started | Partial | Mostly Hermes install lessons |
| AI Models | Yes | **Module: AI model comparison** |
| Model Tier List | Yes | **Module: AI model comparison** |
| Hermes (`hermes agent`, `hermes agent update`, `hermes agent desktop app`, `hermes bible`, `hermes agent vps`, `hermes agent skills`, `hermes agent dashboard`, `hermes agent mcp`) | New | **Module: Hermes agent** |
| Updates | New | Folded into the relevant module's "latest" lesson |
| Tips & Tricks | New | Folded into the module that owns the tool |
| Integrations | Yes (Discord / Telegram / Notion / APIs / Other) | **Module: projects** when paired with a build |
| Learning Paths | Yes — this is the course surface | Hosts `course-outline.md` |
| NemoClaw | Yes | **Module: projects** |

## Workflow

1. **Pick a module** — start with `Hermes agent` (most tagged coverage, recent activity).
2. **Pull candidate videos** — query `public.videos` filtered by the module's specific tags and `has_transcript = true`.
3. **Read the transcript** — scan titles + `summary_verdict` first, then skim the transcript to confirm topic fit.
4. **Group into lessons** — cluster videos by sub-topic (install, daily use, releases, advanced). Each lesson = 1–4 videos.
5. **Pick segments** — when a video only partly covers the lesson, use `transcript_segments` to extract the relevant range and write jump-to-timestamp links.
6. **Write the lesson** — markdown in `lessons/<module>/L##-<slug>.md` using the schema above.
7. **Update the outline** — append to `course-outline.md` (TBD) so the course has a single sequenced reading order.

## Conventions

- **video_id** is the primary key for cross-references between this repo and Supabase — never use the YouTube URL or title as the identifier.
- **No fabrication**: every claim in a lesson must trace back to a specific `video_id` and ideally a `transcript_segments` range.
- **Out of scope** videos stay out of lessons but may be linked from the relevant module's "See also" section if they add context.
- **`description` fallback**: when a transcript is unavailable but `youtube_description` is, the description can stand in — note this in the lesson file.

## Next steps

- [ ] Write `course-outline.md` with module → lesson sequence for v1.
- [ ] Build out the **Hermes agent** module first (largest tagged coverage).
- [ ] Build out the **AI model comparison** module.
- [ ] Build out the **projects** module (newest material first).
- [ ] Decide hosting surface (Supabase `learning_paths` folder vs standalone site).