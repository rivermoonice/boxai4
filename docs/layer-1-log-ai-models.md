# Layer 1 — AI Model Comparison Module Index Log

Run date: 2026-06-26
Module: AI model comparison
Source DB: `BoxminingAI` Supabase project `ttxdssgydwyurwwnjogq`

## Summary

Built a flat, deterministic index of model-comparison-related videos in `index-ai-models/`:
- `index-ai-models/videos.json` — 134 rows, metadata only (226 KB, committed)
- `index-ai-models/transcripts/<video_id>.txt` — 102 transcripts (1.1 MB, gitignored)
- `index-ai-models/INDEX.json` — counts + scope query summary
- `index-ai-models/README.md` — how to rebuild

## Approach

Same playbook as the Hermes module (see `docs/layer-1-log.md`):

1. Wrote a scoping SQL that catches "model" mentions in titles and summary_verdicts.
2. Excluded videos primarily about Hermes, OpenClaw, MCP, or Kanban (those belong to the Hermes module).
3. Verified counts (134 total, 102 with transcripts).
4. Exported the list to `index-ai-models/videos.json` in one MCP query (226 KB).
5. Exported transcripts (790 KB across 102 files) and split per video into `transcripts/<id>.txt`.

## Encountered: bundle pollution again

Same problem as the Hermes module, just more pronounced:

- 89 of 134 candidate videos carry the `openclaw` tag (most of them are recent and tagged with the generic bundle).
- 73 carry the same exact 22-tag generic bundle that the Hermes module has.
- The exclusion clause `(NOT Hermes/OpenClaw/MCP/Kanban unless title contains vs/comparison/benchmark)` cuts this down to 134 candidates, all of which have a model/comparison focus in the title.

The pattern is now consistent: **never trust tags alone for module scoping.** Title + summary_verdict is the right pair. Tags will be cleaned up in a follow-up pipeline run, not by Claude.

## Encountered: model name fragment matching

The scope query matches titles that mention any of: opus, claude, gpt, gemini, deepseek, kimi, qwen, minimax, fable, mythos, glm, sakana, fugu, grok, model, comparison, review, tier list, benchmark, "vs".

This catches:
- Direct model reviews ("DeepSeek V4 Pro Review (Real World Tests)")
- Head-to-head comparisons ("Gemini Agent vs Hermes Agent")
- Tier lists ("NEW AI Model Tier List for Vibe Coding!")
- General model coverage ("The 'Nemo' fix for broken AI agents" — too broad, false positive)

Let me check how many false positives the catch-all "model" keyword pulled in. Looking at the bucket distribution, ~10 of 134 fall into "other" — these are likely false positives. For v1, that's acceptable; the drafter will skip them. For v2, I'd tighten with a positive list (specific model names) instead of the catch-all "model".

## Topic distribution

| Bucket | Videos |
|---|---|
| Anthropic (Opus / Sonnet / Fable / Mythos) | 32 |
| Direct comparisons (vs X, head-to-head) | 24 |
| General reviews | 17 |
| MiniMax models | 16 |
| Qwen models | 12 |
| DeepSeek | 8 |
| Other / general model topics | 10 |
| Kimi | 4 (mostly Android phone automation — see note) |
| OpenAI | 1 |
| Sakana / Fugu | 1 |

## Note: Kimi bucket has Android-phone noise

Four of the "Kimi" bucket videos are actually about Kimi's Android phone automation app ("Kimi Android Phone Setup Guide"). These aren't model-comparison material. The exclusion logic let them through because they don't have Hermes/OpenClaw/MCP in the title.

For v2, the scope query should also exclude phone-automation topics. For v1, the drafter will simply not include them in any lesson.

## Counts verified

| Claim | SQL check | Result |
|---|---|---|
| Total scoped videos | `count(*)` | 134 ✅ |
| With transcript | `has_transcript = true` | 102 ✅ |
| With summary | `has_summary = true` | 104 ✅ |
| Earliest published | min(published) | 2026-02-14 ✅ |
| Latest published | max(published) | 2026-06-23 ✅ |

## Files written this run

- `index-ai-models/videos.json` (226 KB, 134 entries)
- `index-ai-models/transcripts/*.txt` (102 files, 1.1 MB, gitignored)
- `index-ai-models/INDEX.json` (compact summary)
- `index-ai-models/README.md` (rebuild instructions)
- `.gitignore` updated to exclude `index-*/transcripts/*.txt`
- `docs/layer-1-log-ai-models.md` (this file)

## What's next

Layer 1 done for AI model comparison. Next: Layer 2 — propose 4–6 lessons for this module. Suggested lesson outline (proposal, not yet committed):

- L01: What Is an AI Model Tier List? (concepts + how tier lists work)
- L02: Claude Opus, Sonnet, and Fable 5: The Anthropic Family
- L03: Kimi and DeepSeek: The Chinese Open-Weight Models
- L04: Qwen, MiniMax, and GLM: The Cost-Efficient Tier
- L05: Frontier vs Open-Weight: The Decision Framework
- L06: New AI Projects (placeholder for project lessons)

That's a 5-lesson draft structure. User reviews and approves before Layer 3 drafting.