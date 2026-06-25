# Layer 2 — Hermes Module Clustering Log

Run date: 2026-06-24
Module: Hermes agent
Source: `index/videos.json` (103 scoped → 94 strictly primary)

## Summary

Proposed 9 lesson skeletons for the Hermes module, covering the full beginner journey from "what is this thing" to "should I be using it at all." Skeletons live under `lessons/hermes/_skeletons/`.

## Approach

1. Loaded `index/videos.json`. Started with the 103-videos-by-title-or-summary list from Layer 1.
2. Tightened the scope to **94 videos that are primarily about Hermes** (excluded OpenClaw-only updates, Claude-Code-comparison videos where Hermes is mentioned only in passing, and model-review videos that suggest routing via Hermes).
3. Bucketed the 94 by topic signal in title and summary_verdict. Initial buckets: install / desktop-vs-tui / skills / mcp / performance / security / cron-kanban / comparisons / backlog.
4. **Per-bucket evidence check**: counted how many videos in each bucket had transcripts. Found two evidence-light buckets (L07 security, L08 automation).
5. Selected the strongest primary sources for each lesson — preferring videos with both transcript and summary_verdict, then weighing by duration (longer = more material).
6. Wrote one skeleton per lesson using `templates/lesson-skeleton.md`.

## Encountered: bundle pollution, round 2

Some Hermes-tagged videos are really about *other* things. The Layer 1 scope rule (`title ILIKE '%hermes%' OR summary_verdict ILIKE '%hermes%'`) catches them anyway. For Layer 2 I tightened with a heuristic:

- Exclude if title starts with "Computer use inside Claude Code", "Anthropic's next AI model Mythos", "OpenHuman", "Minimax Mavis".
- Exclude if title starts with "Agent Harness vs Coding Harness" *only if* it has no transcript — but `GGtmmx0MKCI` *does* have a transcript and is the cleanest framing of the harness/model distinction, so it's in L01.
- Exclude if title is "DeepSeek v4 Pro Review" — it's a model review that happens to mention Hermes, not a Hermes lesson source.

That cut 9 videos. Final primary count: **94.**

## Encountered: 27 videos fell to "Backlog"

A surprising 27 of 94 primarily-Hermes videos didn't fit any of the 9 lesson topics cleanly. They are:

- **Release-update videos** (v0.8, v0.9, v0.10, v0.11, v0.13, v0.14, v0.15, v0.16, v0.17 — short PSAs and deep dives)
- **Performance micro-tips** ("Just Got FASTER", "Optimizing Performance")
- **Specific-feature videos** ("See Every Skill", "Real Time News Access", "Grok + Hermes = INSANE Combo")

These are **evidence**, not standalone lesson material. A v0.17 release video shouldn't be a lesson; it should be a reference linked from L03/L04/L05 wherever v0.17 changes behaviour.

**Recommendation for review:** either accept the backlog as "supporting material linked from the 9 lessons" or add a 10th lesson — "Hermes Version History: What Changed in v0.X" — that ties the release notes into a coherent story.

## Encountered: two evidence-light lessons

**L07 (Security)** and **L08 (Automation)** have low transcript coverage relative to their scope. For both, the source material is mostly summary_verdict + title, not full transcripts.

This is a real constraint. Three ways to handle it:

1. **Ship as evidence-light anyway.** Mark the lesson's "Last tested and updated" with a caveat, lean on the channel's documented security belief, and link to the source videos as "watch for visual setup."
2. **Re-run the transcript pipeline on the missing videos.** Possible — the pipeline covers the date range. Would take a one-off `backfill_transcripts` run.
3. **Narrow the lesson scope.** Drop L07 and L08 from v1, push them to v2. Reduce the course to 7 lessons, all evidence-rich.

**My recommendation:** option 1 with prominent caveats. The channel's `Specs/ChannelIdentity.md` is explicit about the security belief ("never expose remote agent credentials over the public internet — Tailscale/VPN is mandatory"), so L07 is teachable without a transcript. L08 has 4 transcript-rich sources covering most of the lesson body.

## Encountered: short-form video era

About 30 of the 94 Hermes videos are **60 seconds or less.** They are quick PSAs from April–May 2026 ("Hermes Just Got FASTER", "4 Hermes Agent Prompts You MUST Know", "Hermes Agent: It Asked the Same Question Six Times"). These are flavour for §4 (pitfalls), not body content for §2 (core content).

The drafter should treat them as **evidence**, not as embeddable videos. Embedding a 60-second clip is fine; making it the lesson's primary source is not.

## Encountered: lesson-skeleton template adjustments

The original `templates/lesson-skeleton.md` had `# L## — <!-- TODO -->` as the first heading. I fixed that to `L## — <!-- TODO: short slug -->` so the rendered H1 reads cleanly even when the TODO is still in place.

Also, when writing these 9 skeletons I added a small **Evidence note** field where a lesson is evidence-light. Recommend folding that into the template formally (so it's not ad-hoc per skeleton).

## Counts

| Bucket | Videos | Transcripts |
|---|---|---|
| L01 - What is Hermes Agent | 1 | 1 |
| L02 - Install & first run | 5 | 3 |
| L03 - TUI vs Desktop | 3 | 3 |
| L04 - Skills & Skill Bundles | 11 | 6 |
| L05 - MCP Catalog & integrations | 6 | 5 |
| L06 - Performance & cost | 10 | 9 |
| L07 - Security | 2 | 0 |
| L08 - Automation | 28 | 4 |
| L09 - Hermes vs alternatives | 1 | 1 |
| Backlog (release updates, micro-tips) | 27 | 16 |

(Counts are video counts per bucket, not unique videos — some videos are referenced from multiple lessons.)

## Files written this run

- `lessons/hermes/_skeletons/L01-what-is-hermes-agent.md` through `L09-hermes-vs-alternatives.md` (9 skeletons)
- `lessons/hermes/_skeletons/README.md` (review guide)
- `docs/layer-2-log.md` (this file)

## Open questions for the user

1. **Course order**: L01 → L09 is the proposed sequence. Beginners may want MCP (L05) before Skills (L04) since MCP is more "plug and play." Confirm or reorder.
2. **Backlog strategy**: 27 videos don't fit any lesson. Accept as supporting material, or add an L10 "Hermes Version History"?
3. **L07 and L08 evidence**: ship with caveats (option 1), re-run transcripts (option 2), or cut to v2 (option 3)?
4. **Source-video selection**: are the primary videos the right picks? E.g. for L02, are there better Mac-install videos I missed?

## What's next

Once the user reviews the 9 skeletons and answers the 4 questions above, Layer 3 drafts L01 (smallest scope, sets voice for the rest). After L01 lands, L02–L09 follow in numerical order — each reviewed before commit.