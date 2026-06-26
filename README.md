# Boxmining AI Academy

> **Status (June 2026):** Course complete end-to-end. 19 lessons across 3 modules, all passing the quality gate. See `docs/course-overview.md` for the canonical "start here" guide.

A structured curriculum built from Boxmining AI's YouTube library. Three modules, 19 lessons, all beginner-friendly.

## What you'll learn

| Module | Lessons | Focus |
|---|---|---|
| **Hermes agent** | 9 | What a harness is, install, daily-driver workflows, MCPs, security, automation |
| **AI model comparison** | 5 | Tier lists, Anthropic family, Chinese open-weight, cost-efficient tier, decision framework |
| **New AI projects** | 5 | Coding with Claude Code, vibe vs real coding, niche directories, the AI-business stack |

**Read this first:** [`docs/course-overview.md`](docs/course-overview.md) — reading order, cross-module references, methodology.

**Audience:** true beginners. Grade 8–10 reading level. Every term defined on first use.

**Voice:** Ron's — direct, no-hype, "I tested this so you don't have to waste time."

## Quick start

```bash
# Clone the repo
git clone https://github.com/rivermoonice/boxai4.git
cd boxai4

# Browse the lessons
ls lessons/hermes/      # Hermes module (9 lessons)
ls lessons/ai-models/   # AI model comparison (5 lessons)
ls lessons/ai-projects/ # New AI projects (5 lessons)

# Run the quality gate
python3 scripts/check-lesson.py lessons/

# Or check a single lesson
python3 scripts/check-lesson.py lessons/hermes/L01-what-is-hermes-agent.md
```

## Source data

All curriculum work is derived from the Supabase project `BoxminingAI` (`public.videos` table).

| Field | Where | Notes |
|---|---|---|
| Title | `public.videos.title` | Primary topic signal |
| Transcript | `public.videos.transcript_content` | Canonical source — what the video says |
| Timestamped segments | `public.videos.transcript_segments` | `[{ start, duration, text }]` for jump-to-timestamp links |
| Summary + verdict | `summary_content`, `summary_verdict`, `summary_key_takeaways` | AI-written synopsis already produced |
| YouTube description | `youtube_description` | Only 13 of 428 videos — secondary signal |
| Tags | `tags` | Heavy overlap (most videos carry the same 22-tag bundle) — useful only when specific tag matches |

**Critical:** we never filter by tags alone. See `docs/layer-1-log.md` for the bundle-pollution finding that drove this rule.

## Methodology: the 4-layer pipeline

| Layer | Output | Method |
|---|---|---|
| 1. Index | `index/`, `index-ai-models/`, `index-ai-projects/` | Deterministic SQL → JSON + transcripts |
| 1.5. Templates | `templates/lesson.md`, `templates/lesson-skeleton.md` | Fill-in-the-blank scaffolds matching the 12-section spec |
| 2. Cluster | `lessons/<module>/_skeletons/` | LLM proposes lesson groupings; user reviews |
| 3. Draft | `lessons/<module>/L##-*.md` | LLM fills in the template from the approved skeleton |
| 4. Quality gate | `scripts/check-lesson.py` | Deterministic checker for the 12-section spec |

Every claim in every lesson traces back to a `video_id` in the indexes. The indexes are flat, reproducible, and re-derivable from Supabase.

## Lesson specification

Every lesson follows [`Specs/ai-academy-lesson-specification.md`](Specs/ai-academy-lesson-specification.md) — 12 required sections:

1. Title, URL & metadata (SEO foundation)
2. Introduction & Hook
3. Core Content & Delivery
4. Comparisons, Tables & Decision Frameworks
5. Common Pitfalls, Troubleshooting
6. Key Takeaways & Ron's Bottom Line
7. Hands-On Practice
8. Self-Check / Mini-Quiz
9. Resources, Glossary & Further Learning
10. SEO & On-Page Optimization
11. Accessibility, Tone & Inclusivity
12. Standalone Text Guides

Word count target: 1,800–3,500+ words per lesson. Reading level: grade 8–10.

## File layout

```
boxai4/
├── README.md                        # this file
├── TODO.md                          # 4-layer build plan + status
├── .gitignore                       # excludes transcripts + .env
├── docs/
│   ├── course-overview.md           # ⭐ start here
│   ├── layer-1-log.md              # run logs (one per module)
│   ├── layer-1-log-ai-models.md
│   ├── layer-1-log-ai-projects.md
│   ├── layer-2-log.md
│   ├── layer-2-log-ai-models.md
│   ├── layer-2-log-ai-projects.md
│   ├── layer-3-log-ai-projects.md
├── Specs/
│   ├── ai-academy-lesson-specification.md   # the 12-section spec
│   └── ChannelIdentity.md                    # channel voice reference
├── templates/
│   ├── lesson.md                    # full lesson scaffold
│   ├── lesson-skeleton.md           # short L2 output form
│   └── README.md
├── scripts/
│   └── check-lesson.py              # quality gate (deterministic)
├── index*/                           # per-module video indexes + transcripts
├── lessons/
│   ├── hermes/                      # 9 lessons (L01–L09)
│   ├── ai-models/                   # 5 lessons (L01–L05)
│   └── ai-projects/                 # 5 lessons (L01–L05)
```

## Conventions

- **`video_id`** is the primary key for cross-references between this repo and Supabase. Never use the YouTube URL or title.
- **No fabrication**: every claim in a lesson must trace back to a `video_id` in `index*/videos.json`. Body content beyond the source is marked "Ron-tested framing" and grounded in `Specs/ChannelIdentity.md`.
- **Title + summary_verdict filters, never tags alone.** Tags are bundle-polluted.
- **Tracked in git:** `index*/videos.json`, `index*/INDEX.json`, `index*/README.md`, lessons, templates, scripts, specs, docs.
- **Gitignored:** `index*/transcripts/*.txt` (large, re-derivable from Supabase), `.env`.

## What's next

- **CI integration.** The quality gate runs locally. Wire it into GitHub Actions so PRs that break lessons fail CI.
- **Quarterly review.** Models and tools ship every few weeks. Re-validate lesson recommendations.
- **Backlog.** Each module has a "Backlog" of videos that didn't fit cleanly into lessons. Promote as needed.
- **Cross-module reference audit.** Verify each lesson's "Related" section points to the right other lessons.

See `TODO.md` for the full backlog.