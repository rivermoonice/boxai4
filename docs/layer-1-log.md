# Layer 1 — Hermes Module Index Log

Run date: 2026-06-24
Module: Hermes agent
Source DB: `BoxminingAI` Supabase project `ttxdssgydwyurwwnjogq`

## Summary

Built a flat, deterministic index of Hermes-related videos in `index/`:
- `index/videos.json` — 103 rows, metadata only (150 KB, committed)
- `index/transcripts/<video_id>.txt` — 57 transcripts (592 KB, gitignored)
- `index/INDEX.json` — counts + scope query summary
- `index/README.md` — how to rebuild

## Approach

The plan was: pull from `public.videos`, write JSON + per-video transcripts, verify counts.

What actually happened, in order:

1. **First scoping query** used a Hermes tag list (`hermes agent`, `hermes agent update`, etc.) and returned 198 videos. Looked promising.
2. **Cross-checked against titles** to validate the tag filter — that's where I caught the bundle-pollution problem (see below).
3. **Re-scoped using title OR summary_verdict** — settled on 103 videos, the right number.
4. **Exported the list** to `index/videos.json` in one MCP query (111 KB → easy).
5. **Exported transcripts** to one MCP query (457 KB → landed in the harness output file, parsed via Python and split per video).

## Encountered: tag-bundle pollution

The big finding.

`public.videos.tags` on **143 of 428 videos** contains the Hermes tag bundle (`hermes agent`, `hermes agent update`, etc.) — but those videos are *not* about Hermes. They're recent (post May 2026) general AI videos (Sakana Fugu, GLM 5.2, Fable 5 reviews, OpenAI IPO, Trump AI order, Kimi tier list) that share a single generic tag bundle applied across most uploads.

**Verified by sampling 30 of those 143 titles** — every one was about something else. None mentioned Hermes in the title or summary.

This is the lesson I flagged in the README: **never trust tag-only filtering.** For this channel, the same generic 22-tag bundle is slapped on almost every new upload.

### What this means for the other modules

The other two v1 modules will hit the same problem:
- **AI model comparison** — the same generic bundle includes `ai-models`, `model-tier-list`, etc. We need to scope by title too.
- **New AI projects** — this bundle has `AI experiments`, `vibe coding`, `AI workflow`, etc. Same risk.

**Recommendation**: every module's scope should be defined as `title ILIKE '%<topic>%' OR summary_verdict ILIKE '%<topic>%'`, then eyeball the list before trusting it.

## Encountered: older Hermes videos have no transcripts

Of the 103 Hermes videos, **46 have no transcripts**. These are concentrated in the older Hermes Kanban / Curator Guide series (2026-03-30 → 2026-05-08). The summary pipeline was apparently run after the tag-bundle era, so it didn't process these older uploads.

**Implication for Layer 2/3**: lesson topics that depend on the older Kanban / Curator Guide content will have to either (a) skip those videos or (b) rely on the summary_verdict field for guidance. Without a transcript we can't do true-beginner explanation.

## Encountered: MCP output size limits

The MCP `execute_sql` tool has a token limit per response. The transcript query (478K chars across one line) overflowed and was redirected to a JSON-wrapped output file at `/home/ubuntu/.claude/projects/-home-ubuntu-boxai4/.../mcp-supabase-execute_sql-<id>.txt`.

**Workaround that worked**: parse the wrapper with Python, find the inner `[...]` payload, write per-video files. No need to chunk the SQL.

If a future index (e.g. all 428 videos) exceeds the limit, **chunk by date range** rather than video count. The wrapper parsing pattern above generalises.

## Encountered: only 13 videos have YouTube descriptions

Earlier check: `youtube_description IS NOT NULL` returns only 13 of 428. So our original "transcripts + descriptions only" rule in the README is effectively **transcripts only** for the Hermes module.

Not blocking, but worth noting in the README's source-data table.

## Counts verified

| Claim | SQL check | Result |
|---|---|---|
| Total Hermes by title or summary_verdict | `count(*)` | 103 ✅ |
| With transcript | `has_transcript = true` | 57 ✅ |
| With summary | `has_summary = true` | 57 ✅ |
| Tag-only Hermes count | `tags && ARRAY[hermes-tags]` | 198 ❌ overcount |
| Date range | min/max published | 2026-03-30 → 2026-06-23 ✅ |

The discrepancy between tag-only (198) and title/summary (103) is the bundle-pollution problem.

## Files written this run

- `index/videos.json` (150 KB, 103 entries)
- `index/transcripts/*.txt` (57 files, 592 KB, gitignored)
- `index/INDEX.json` (compact summary)
- `index/README.md` (rebuild instructions)
- `.gitignore` updated to exclude `index/transcripts/*.txt`
- `TODO.md` updated to mark Layer 1 done for Hermes (next: still todo)

## Open questions / next decisions

1. **Older Hermes videos with no transcript** — for the course, do we (a) skip them, (b) use them as "see also" links only, or (c) re-run the summary/transcript pipeline on them?
2. **Tag-bundle problem** — when scoping AI model comparison and New AI projects modules, repeat the title-vs-tag cross-check. Will likely surface the same overcount.
3. **Layer 1.5** — still todo. Lesson template (`templates/lesson.md` and `templates/lesson-skeleton.md`) is the next concrete step before any Layer 2 clustering.
4. **Spec title format** — `Specs/ai-academy-lesson-specification.md` was the lesson spec; `Specs/ChannelIdentity.md` is the channel voice reference. Both already in the repo.

## What's next

Layer 1 for Hermes is **done**. The next concrete step is **Layer 1.5** — draft `templates/lesson.md` (12 sections with placeholders) and `templates/lesson-skeleton.md` (short LLM output form), then run Layer 2 for Hermes to propose lesson structure.