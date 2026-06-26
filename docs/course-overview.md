# Boxmining AI Academy — Course Overview

> **Status (June 2026):** All three modules complete. 19 lessons drafted and quality-gated. See `TODO.md` for build state.

This document is the canonical "start here" map of the Boxmining AI Academy course. If you're new to the repo, read this first.

## What this course is

A structured curriculum built from Boxmining AI's YouTube library. We produce many videos — this course pulls them into a beginner-friendly learning path organised into three modules.

**Three pillars, three modules:**

1. **Hermes agent** — the open-source AI harness for research, automation, and multi-channel workflows.
2. **AI model comparison** — how to read tier lists, choose between Claude Opus / Sonnet / Fable 5 / Kimi / DeepSeek / Qwen / MiniMax / GLM, and route by cost.
3. **New AI projects** — building real things with coding harnesses, vibe coding vs real coding, niche directories, and the AI-business stack.

**Audience:** true beginners. No assumed knowledge of AI agents, models, or AI coding tools. Each lesson is graded 8–10 reading level with every term defined on first use.

**Voice:** Ron's — direct, no-hype, "I tested this so you don't have to waste time."

## Reading order

The course is designed to be read in order within each module, but modules are loosely coupled. Pick a starting module based on your interest:

- **If you want to set up an AI agent for daily use** → Hermes module (L01 first).
- **If you want to understand which AI model to use** → AI model comparison (L01 first).
- **If you want to build something real** → New AI projects (L01 first).

### Module 1: Hermes agent (9 lessons)

| # | Title | What you'll learn |
|---|---|---|
| L01 | What Is Hermes Agent? | What a harness is; coding vs agent harnesses |
| L02 | Install & first run | Mac and VPS install paths; first chat |
| L03 | TUI vs Desktop App | Which interface to use when |
| L04 | Skills & Skill Bundles | Codifying workflows so you stop re-asking |
| L05 | MCP Catalog & integrations | Connecting Hermes to GitHub, Linear, Notion, etc. |
| L06 | Performance, model routing & cost | Tiered routing; setting a budget cap |
| L07 | Security essentials | Tailscale, credential hygiene, exposure risks |
| L08 | Automation: Cron, Kanban, sub-agents | The three automation patterns |
| L09 | Hermes vs alternatives | Decision framework for harness choice |

### Module 2: AI model comparison (5 lessons)

| # | Title | What you'll learn |
|---|---|---|
| L01 | What Is an AI Model Tier List? | How to read tier lists critically |
| L02 | Claude Opus vs Sonnet vs Fable 5 | The Anthropic family as a unit |
| L03 | Kimi and DeepSeek | Chinese open-weight; the `/swarm` requirement |
| L04 | Qwen, MiniMax, GLM | The cost-efficient tier |
| L05 | Frontier vs Open-Weight: Decision Framework | Pick by loop, not by model |

### Module 3: New AI projects (5 lessons)

| # | Title | What you'll learn |
|---|---|---|
| L01 | Coding with Claude Code | Claude Code / Kilo Code / Cursor |
| L02 | Vibe Coding vs Real Coding | When to use which; the PRD habit |
| L03 | Building Real Projects with Hermes | Project types Hermes wins at |
| L04 | Niche Directory Sites | The $5K–$100K/month case study |
| L05 | The Online Business Stack | Real business on $3/month infrastructure |

## Cross-module references

The modules aren't siloed. Each lesson points to related lessons in other modules. The most important cross-links:

| Topic | Start here | Then |
|---|---|---|
| Setting up daily AI use | Hermes L01–L04 | AI models L06 (cost), L05 (decision framework) |
| Picking which model to use | AI models L01–L05 | Hermes L06 (tiered routing) |
| Building production code | New AI projects L01–L02 | Hermes L02 (install), AI models L06 (cost) |
| Running a real business | New AI projects L04–L05 | Hermes L03 (Hermes projects), New AI projects L01 (coding) |
| Security essentials | Hermes L07 | AI models L06 (provider-side) |

## Source data and methodology

Every lesson is built from `public.videos` in the Supabase `BoxminingAI` project. We use **transcripts and descriptions only** — no external knowledge of the videos.

### Scope (how a video qualifies for a module)

Each module uses a `title` + `summary_verdict` filter, never `tags` alone. Tags overcount massively because the channel applies a generic 22-tag bundle to most recent uploads. See `docs/layer-1-log.md` for the original finding.

### Module 1 (Hermes): 103 scoped, 57 transcripts

```sql
WHERE title ILIKE '%hermes%'
   OR (summary_verdict IS NOT NULL AND summary_verdict ILIKE '%hermes%')
```

### Module 2 (AI model comparison): 134 scoped, 102 transcripts

```sql
WHERE (
    title ILIKE '%tier list%' OR title ILIKE '%comparison%' OR title ILIKE '%benchmark%'
    OR title ILIKE '%review%' OR title ILIKE '% vs %' OR title ILIKE '%model%'
    OR -- ...model name keywords (opus, claude, gpt, gemini, deepseek, kimi, ...)
    (summary_verdict ILIKE '%model%' OR summary_verdict ILIKE '%tier%'
     OR summary_verdict ILIKE '%benchmark%' OR summary_verdict ILIKE '%comparison%')
)
AND NOT (
    (title ILIKE '%hermes%' OR title ILIKE '%openclaw%' OR title ILIKE '%mcp%'
     OR title ILIKE '%kanban%')
    AND NOT (title ILIKE '% vs %' OR title ILIKE '%comparison%'
             OR title ILIKE '%benchmark%')
)
```

### Module 3 (New AI projects): 96 scoped, 58 transcripts

```sql
WHERE (
    title ILIKE '%hermes%' AND (
      title ILIKE '%build%' OR title ILIKE '%built%' OR title ILIKE '%project%'
      OR title ILIKE '%setup%' OR title ILIKE '%install%' OR title ILIKE '%workflow%'
      OR title ILIKE '%automate%' OR title ILIKE '%automation%'
      OR title ILIKE '%agent swarm%' OR title ILIKE '%swarm%'
      OR -- ...more project keywords
    )
    OR title ILIKE '%claude code%' OR title ILIKE '%kilo code%' OR title ILIKE '%cursor%'
    OR title ILIKE '%vibe coding%' OR title ILIKE '%vibe code%'
    OR title ILIKE '%no code%' OR title ILIKE '%directory%' OR title ILIKE '%hostinger%'
    OR -- ...business keywords
)
AND NOT (
    title ILIKE '%tier list%' OR title ILIKE '%benchmark%'
    OR (title ILIKE '% vs %' AND NOT title ILIKE '%how to%')
)
```

## The lesson specification

Every lesson follows `Specs/ai-academy-lesson-specification.md` — 12 required sections:

1. Title, URL & metadata (SEO foundation)
2. Introduction & Hook
3. Core Content & Delivery
4. Comparisons, Tables & Decision Frameworks
5. Common Pitfalls, Troubleshooting & "What Beginners Break"
6. Key Takeaways & Ron's Bottom Line
7. Hands-On Practice & Actionable Next Steps
8. Self-Check / Mini-Quiz
9. Resources, Glossary & Further Learning
10. SEO & On-Page Optimization
11. Accessibility, Tone & Inclusivity
12. Standalone Text Guides

The quality gate (`scripts/check-lesson.py`) enforces this automatically.

## Reading time and commitment

| Module | Lessons | Reading time | Hands-on time |
|---|---|---|---|
| Hermes | 9 | ~110 min | ~3 hours |
| AI model comparison | 5 | ~55 min | ~1 hour |
| New AI projects | 5 | ~50 min | ~1 hour |
| **Total** | **19** | **~3.5 hours** | **~5 hours** |

## What's in this repo

```
boxai4/
├── README.md                        # project overview
├── TODO.md                          # 4-layer build plan + status
├── .gitignore                       # excludes transcripts + .env
├── Specs/
│   ├── ai-academy-lesson-specification.md   # the 12-section spec
│   └── ChannelIdentity.md                    # channel voice reference
├── templates/
│   ├── lesson.md                    # full lesson scaffold
│   ├── lesson-skeleton.md           # short L2 output form
│   └── README.md
├── scripts/
│   └── check-lesson.py              # quality gate (deterministic)
├── index/                           # Hermes module index
│   ├── videos.json
│   ├── INDEX.json
│   ├── README.md
│   └── transcripts/                 # gitignored
├── index-ai-models/                 # same structure for module 2
├── index-ai-projects/               # same structure for module 3
├── lessons/
│   ├── hermes/                      # 9 drafted lessons
│   ├── ai-models/                   # 5 drafted lessons
│   └── ai-projects/                 # 5 drafted lessons
└── docs/
    ├── course-overview.md           # this file
    ├── layer-1-log.md              # Hermes Layer 1 run log
    ├── layer-1-log-ai-models.md     # AI model comparison Layer 1 run log
    ├── layer-1-log-ai-projects.md   # New AI projects Layer 1 run log
    ├── layer-2-log.md              # Hermes Layer 2 cluster log
    ├── layer-2-log-ai-models.md
    ├── layer-2-log-ai-projects.md
    ├── layer-3-log-ai-projects.md
    └── ...
```

## Open work

- **CI integration.** The quality gate runs locally but isn't wired into GitHub Actions yet. PRs that don't pass the gate should fail CI.
- **Cross-module reference audit.** Each lesson's "Related" section should be spot-checked for accuracy.
- **Backlog from Layer 2.** Each module had a "Backlog" of videos that didn't fit cleanly into any lesson. These are still in the indexes and could become supplementary material.
- **Refresh cadence.** The source videos are from 2026. New releases ship every few weeks. The course needs quarterly review.

See `TODO.md` for the full backlog.