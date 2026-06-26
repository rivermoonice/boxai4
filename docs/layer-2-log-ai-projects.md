# Layer 2 — New AI Projects Module Clustering Log

Run date: 2026-06-26
Module: New AI projects
Source: `index-ai-projects/videos.json` (96 scoped videos)

## Summary

Proposed 5 lesson skeletons for the New AI projects module. Skeletons live under `lessons/ai-projects/_skeletons/`.

## Approach

1. Loaded `index-ai-projects/videos.json`. Started with 96 videos from Layer 1.
2. Bucketed by topic signal in title (build, setup, Claude Code, vibe coding, directory, business).
3. Selected the strongest primary sources — preferring long videos (700s+) with transcripts.
4. Wrote one skeleton per lesson using `templates/lesson-skeleton.md`.

## Encountered: thin evidence for some buckets

The "directory builds" bucket has 1 video. The "business / no-code" bucket has 2. The "Hermes builds" bucket has 0 transcripts. Three of the five proposed lessons are evidence-light:

- **L03 (Building with Hermes)** — 0 transcripts in the Hermes-builds bucket. Most Hermes-build content overlaps with the Hermes module's L04 (Skills) and L08 (Automation). The drafter will treat the Hermes module as primary evidence.
- **L04 (Niche Directory Sites)** — 1 primary video. The drafter will lean on `Specs/ChannelIdentity.md` for the channel's documented directory philosophy.
- **L05 (Online Business Stack)** — 2 primaries. Body content leans on `Specs/ChannelIdentity.md`.

## Encountered: cross-module overlap with Hermes

The "Hermes builds" bucket is mostly covered by the Hermes module. The drafter will cross-reference L04 (Skills) and L08 (Automation) rather than re-teach them.

## Lesson structure (proposed)

| # | Title | Why this lesson |
|---|---|---|
| L01 | How to Use Claude Code for Beginners | The canonical coding harness intro |
| L02 | Vibe Coding vs Real Coding | Decision framework for AI-assisted coding |
| L03 | Building Real Projects with Hermes | Cross-reference lesson for Hermes-based projects |
| L04 | Niche Directory Sites | The "$5K–$100K/month" case study |
| L05 | The Online Business Stack | Capstone — real business on $3/month |

5 lessons, each grounded in 1–4 primary videos.

## What didn't make it into v1

- **A standalone Cursor lesson.** Cursor videos exist in the index but the channel doesn't have a strong primary for them. Folded into L01 (Claude Code / Kilo Code / Cursor — three coding harnesses, one lesson).
- **A standalone "Build a SaaS" lesson.** No clear primary videos. The closest would be the directory-build case study in L04.
- **A standalone "Hostinger setup" lesson.** Too tactical. Folded into L04 and L05.

## Counts

| Lesson | Sources | Transcripts | Status |
|---|---|---|---|
| L01 | 4 | 4/4 | proposed |
| L02 | 2 | 2/2 | proposed |
| L03 | 1 | 0/1 ⚠️ | proposed |
| L04 | 1 | 1/1 ⚠️ | proposed |
| L05 | 2 | 2/2 ⚠️ | proposed |

## Files written this run

- `lessons/ai-projects/_skeletons/L01-coding-with-claude-code.md`
- `lessons/ai-projects/_skeletons/L02-vibe-coding-vs-real-coding.md`
- `lessons/ai-projects/_skeletons/L03-building-with-hermes.md`
- `lessons/ai-projects/_skeletons/L04-niche-directory-sites.md`
- `lessons/ai-projects/_skeletons/L05-the-online-business-stack.md`
- `lessons/ai-projects/_skeletons/README.md`
- `docs/layer-2-log-ai-projects.md` (this file)

## Open questions for the user

1. **5 lessons, or fewer?** L03 is mostly cross-reference. Drop it?
2. **L04 evidence is thin.** Acceptable as standalone, or fold into L05?
3. **L05 capstone framing.** "Real business on $3/month" or something more nuanced?

## What's next

Layer 3 drafting once the user approves. The course has reached Layer 2 across all three modules. Once all three modules are drafted, the course is complete end-to-end.