# AI Projects Module Index

Source-of-truth index for the **New AI projects** module of the Boxmining AI Academy course.

## Files

| File | Purpose | Tracked in git? |
|---|---|---|
| `videos.json` | List of in-scope project videos. 96 entries, 141 KB. | ✅ Yes |
| `transcripts/<video_id>.txt` | Plain-text transcripts with header. 58 files, 688 KB. | ❌ No — gitignored. Re-derivable from Supabase. |
| `INDEX.json` | Compact summary: counts, date range, scope query. | ✅ Yes |

## Scope (how a video qualifies as "New AI projects")

A video is in scope if the **title** matches project-build/setup/workflow/cron/kanban/swarm/coding-harness/directory/business terms, OR the **summary_verdict** mentions built/project/workflow/setup.

Explicit exclusions: pure tier-list, benchmark, or head-to-head comparison videos (those live in the AI model comparison module).

```sql
WHERE (
    title ILIKE '%hermes%' AND (
      title ILIKE '%build%' OR title ILIKE '%built%' OR title ILIKE '%project%'
      OR title ILIKE '%setup%' OR title ILIKE '%install%' OR title ILIKE '%workflow%'
      OR title ILIKE '%automate%' OR title ILIKE '%automation%'
      OR title ILIKE '%agent swarm%' OR title ILIKE '%swarm%'
      OR title ILIKE '%directory%' OR title ILIKE '%landing page%'
      OR title ILIKE '%cron%' OR title ILIKE '%kanban%'
      OR title ILIKE '%next js%' OR title ILIKE '%website%'
      OR title ILIKE '%make %' OR title ILIKE '%how to %'
      OR title ILIKE '%guide%' OR title ILIKE '%tutorial%'
      OR title ILIKE '%research%' OR title ILIKE '%summarize%'
    )
    OR title ILIKE '%claude code%' OR title ILIKE '%kilo code%'
    OR title ILIKE '%cursor%' OR title ILIKE '%cline%'
    OR title ILIKE '%vibe coding%' OR title ILIKE '%vibe code%'
    OR title ILIKE '%building with%' OR title ILIKE '%ship %'
    OR title ILIKE '%no code%' OR title ILIKE '%nocode%'
    OR title ILIKE '%hostinger%' OR title ILIKE '%directory%'
    OR title ILIKE '%niche %' OR title ILIKE '%business%'
    OR title ILIKE '%startup%' OR title ILIKE '%mvp%'
    OR title ILIKE '%online directory%' OR title ILIKE '%business in%'
    OR title ILIKE '%AI built%' OR title ILIKE '%AI build%'
    OR title ILIKE '%AI project%' OR title ILIKE '%built with AI%'
    OR (summary_verdict ILIKE '%built%' OR summary_verdict ILIKE '%project%'
        OR summary_verdict ILIKE '%workflow%' OR summary_verdict ILIKE '%setup%')
)
AND NOT (
    title ILIKE '%tier list%' OR title ILIKE '%benchmark%'
    OR (title ILIKE '% vs %' AND NOT title ILIKE '%how to%')
)
```

The bundle-pollution problem hit this module too: 32 of 96 videos carry the same 22-tag generic bundle. The scope query relies on title and summary_verdict, which are far more reliable. See `docs/layer-1-log-ai-models.md` for the original finding.

## Counts (as of 2026-06-26)

- 96 videos in scope
- 58 with transcripts
- 59 with summaries
- Date range: **2026-02-14 → 2026-06-22**

## Topic distribution

| Bucket | Videos |
|---|---|
| Hermes builds (research, sites, swarms) | 3 |
| Hermes setup guides | 12 |
| Hermes automation (Kanban / Cron / sub-agents) | 18 (mostly no transcripts — overlap with Hermes module) |
| Coding harnesses (Claude Code / Kilo Code) | 15 |
| Vibe coding | 1 |
| Directory builds (Hostinger, niche sites) | 1 |
| Business / startup / MVP | 1 |
| Other projects | 45 |

⚠️ **Note**: The "Hermes automation" bucket (18 videos) overlaps heavily with the Hermes module. The drafter will use the module 3 set as supplementary evidence rather than primary source.

## Rebuilding

Re-run the indexing SQL against Supabase (`project_id: ttxdssgydwyurwwnjogq`). Save transcripts under `transcripts/<video_id>.txt` with the standard header.