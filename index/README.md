# Hermes Module Index

This directory holds the source-of-truth index for the **Hermes agent** module of the Boxmining AI Academy course.

## Files

| File | Purpose | Tracked in git? |
|---|---|---|
| `videos.json` | List of in-scope Hermes videos with metadata (no transcripts). 103 entries, 150 KB. | ✅ Yes |
| `transcripts/<video_id>.txt` | Plain-text transcripts with a small header (title, date, url). 57 files, 592 KB. | ❌ No — see `.gitignore`. Re-derivable from Supabase. |
| `INDEX.json` | Compact summary: counts, date range, top tags, scope query. | ✅ Yes |

## Scope (how a video qualifies as "Hermes")

A video is in scope if **either**:

1. The **title** contains the word `hermes`, OR
2. The `summary_verdict` mentions `hermes`.

```sql
WHERE title ILIKE '%hermes%'
   OR (summary_verdict IS NOT NULL AND summary_verdict ILIKE '%hermes%')
```

This was arrived at after a tag-only filter turned out to be unreliable. See `docs/layer-1-log.md` for the full reasoning.

## Counts (as of 2026-06-24)

- 103 videos in scope
- 57 with transcripts and summaries
- 46 without transcripts (mostly older Hermes Kanban / Curator Guide series from Mar–early May 2026, pre-bundle-era)
- Date range: **2026-03-30 → 2026-06-23**

## Rebuilding

Re-run the indexing SQL against Supabase (`project_id: ttxdssgydwyurwwnjogq`). To save transcripts:

```sql
SELECT video_id, title, published, transcript_content
FROM public.videos
WHERE (title ILIKE '%hermes%' OR (summary_verdict IS NOT NULL AND summary_verdict ILIKE '%hermes%'))
  AND has_transcript;
```

Then export each row to `index/transcripts/<video_id>.txt` with the standard header.