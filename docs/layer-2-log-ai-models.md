# Layer 2 — AI Model Comparison Module Clustering Log

Run date: 2026-06-26
Module: AI model comparison
Source: `index-ai-models/videos.json` (134 scoped videos)

## Summary

Proposed 5 lesson skeletons for the AI model comparison module. Skeletons live under `lessons/ai-models/_skeletons/`.

## Approach

1. Loaded `index-ai-models/videos.json`. Started with 134 videos from Layer 1.
2. Bucketed by title keywords (model name, "vs", "tier list", etc.).
3. Selected the strongest primary sources for each lesson idea — preferring deep reviews (700s+) with transcripts.
4. Wrote one skeleton per lesson using `templates/lesson-skeleton.md`.

## Encountered: bucket pollution (round 2)

Same problem as the Hermes module:
- 73 of 134 candidate videos carry the same 22-tag generic bundle.
- 89 carry the `openclaw` tag (mostly false positives — recent videos tagged with the bundle).
- The scope query's exclusion clause (NOT Hermes/OpenClaw/MCP/Kanban unless vs/comparison/benchmark) is doing the right work.

The lesson is now clear: tag-based filtering alone overcounts massively. The Layer 1 scope query relies on title and summary_verdict, which are far more reliable.

## Encountered: Kimi noise

Four "Kimi" videos are actually about Kimi's Android phone automation app, not model comparison. The scope query let them through because they don't mention Hermes/OpenClaw/MCP/Kanban. For v2, the scope query should also exclude phone-automation topics. For v1, the drafter will simply skip them.

## Encountered: cross-module overlap

The L05 "frontier vs open-weight" decision-framework lesson uses `GGtmmx0MKCI` (Agent Harness vs Coding Harness) as a primary source. That same video is the primary for L01 of the Hermes module. **This is intentional, not a bug.** The video makes the "pick by loop, not by model" point, which is the right anchor for both modules. The drafter will reference the video from both lessons and let readers cross-link.

The `r039hxfog44` (GLM 5.2) video also appears in L04 and L05. Again, intentional — the decision framework uses GLM 5.2 as a concrete example of open-weight beating frontier.

## Lesson structure (proposed)

| # | Title | Why this lesson |
|---|---|---|
| L01 | What Is an AI Model Tier List? | Concepts + how to read tier lists critically |
| L02 | Claude Opus vs Sonnet vs Fable 5 | The Anthropic family as a unit |
| L03 | Kimi and DeepSeek | Chinese open-weight — the channel's documented "practical benchmark" |
| L04 | Qwen, MiniMax, GLM | The cost-efficient tier |
| L05 | Frontier vs Open-Weight: Decision Framework | Capstone — synthesises L01–L04 |

5 lessons, each grounded in 3–5 primary videos. Within the 4–6 target range.

## What didn't make it into v1

- **A standalone Sakana Fugu lesson.** Only 3 Sakana videos in scope; not enough for a full lesson. Folded into L05 as a special case (orchestration as the new frontier).
- **A standalone "benchmarks to trust" lesson.** Could be its own lesson but the channel's stance is simple: trust FrontierCoding Diamond, Artificial Analysis, hands-on tests. Fits in L01.
- **Per-vendor deep dives.** GPT-5.x, Gemini 3.1 Pro, Mythos — these have 1–3 videos each in scope. Covered in L05's decision framework instead of standalone lessons.
- **A "new AI projects" lesson.** Out of scope for this module; projects live in the Hermes module.

## Counts

| Lesson | Sources | Transcripts | Status |
|---|---|---|---|
| L01 | 2 | 2/2 | proposed |
| L02 | 5 | 5/5 | proposed |
| L03 | 3 | 3/3 ⚠️ | proposed |
| L04 | 5 | 5/5 | proposed |
| L05 | 4 | 4/4 | proposed |

⚠️ = the L03 bucket has 7 of 27 transcripts in scope. The drafter will lean on `Specs/ChannelIdentity.md` for body content beyond the three primaries.

## Files written this run

- `lessons/ai-models/_skeletons/L01-what-is-an-ai-model-tier-list.md`
- `lessons/ai-models/_skeletons/L02-the-anthropic-family.md`
- `lessons/ai-models/_skeletons/L03-chinese-open-weight.md`
- `lessons/ai-models/_skeletons/L04-cost-efficient-tier.md`
- `lessons/ai-models/_skeletons/L05-frontier-vs-open-weight-decisions.md`
- `lessons/ai-models/_skeletons/README.md`
- `docs/layer-2-log-ai-models.md` (this file)

## Open questions for the user

1. **5 lessons, not 6.** Acceptable, or do you want a separate Sakana Fugu or benchmarks lesson?
2. **L02 as a unit.** Opus / Sonnet / Fable 5 together, or split into two (Opus+Sonnet vs Fable 5)?
3. **No standalone "new AI projects" lesson in this module.** Projects live in the Hermes module. Acceptable?

## What's next

Once approved, Layer 3 drafts L01 first (smallest scope, sets voice). L02–L05 follow in order — each reviewed before commit.