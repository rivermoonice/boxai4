# AI Model Comparison Module Index

Source-of-truth index for the **AI model comparison** module of the Boxmining AI Academy course.

## Files

| File | Purpose | Tracked in git? |
|---|---|---|
| `videos.json` | List of in-scope model-comparison videos. 134 entries, 226 KB. | ✅ Yes |
| `transcripts/<video_id>.txt` | Plain-text transcripts with header. 102 files, 1.1 MB. | ❌ No — gitignored. Re-derivable from Supabase. |
| `INDEX.json` | Compact summary: counts, date range, scope query. | ✅ Yes |

## Scope (how a video qualifies as "AI model comparison")

A video is in scope if **all** of the following are true:

1. The **title** mentions model/comparison/review/tier-list terms, OR the **summary_verdict** mentions model/tier/benchmark/comparison terms.
2. The video is **not primarily about Hermes, OpenClaw, MCP, or Kanban** (those live in the Hermes module).

```sql
WHERE (
    title ILIKE '%tier list%'
    OR title ILIKE '%comparison%'
    OR title ILIKE '%benchmark%'
    OR title ILIKE '%review%'
    OR title ILIKE '% vs %'
    OR title ILIKE '%model%'
    OR title ILIKE '%opus%'
    -- ...other model names
    OR (summary_verdict ILIKE '%model%' OR summary_verdict ILIKE '%tier%'
        OR summary_verdict ILIKE '%benchmark%' OR summary_verdict ILIKE '%comparison%')
)
AND NOT (
    (title ILIKE '%hermes%' OR title ILIKE '%openclaw%'
     OR title ILIKE '%mcp%' OR title ILIKE '%kanban%')
    AND NOT (title ILIKE '% vs %' OR title ILIKE '%comparison%'
             OR title ILIKE '%benchmark%')
)
```

The bundle-pollution problem hit the Hermes module too: tags alone overcount massively. The scope query above uses title and summary_verdict, which are far more reliable. See `docs/layer-1-log.md` for the original finding.

## Counts (as of 2026-06-26)

- 134 videos in scope
- 102 with transcripts and summaries
- 32 without transcripts (mostly older reviews from Feb–March 2026)
- Date range: **2026-02-14 → 2026-06-23**

## Topic distribution

| Bucket | Videos |
|---|---|
| Anthropic (Opus / Sonnet / Fable / Mythos) | 32 |
| Direct comparisons (vs X, head-to-head) | 24 |
| General reviews | 17 |
| MiniMax models | 16 |
| Qwen models | 12 |
| Other / general model topics | 10 |
| DeepSeek | 8 |
| Other (Kimi, OpenAI, Sakana) | 13 |

## Rebuilding

Re-run the indexing SQL against Supabase (`project_id: ttxdssgydwyurwwnjogq`). Save transcripts under `transcripts/<video_id>.txt` with the standard header.