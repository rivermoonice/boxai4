# Layer 1 — New AI Projects Module Index Log

Run date: 2026-06-26
Module: New AI projects
Source DB: `BoxminingAI` Supabase project `ttxdssgydwyurwwnjogq`

## Summary

Built a flat, deterministic index of project-related videos in `index-ai-projects/`:
- `index-ai-projects/videos.json` — 96 rows, metadata only (141 KB, committed)
- `index-ai-projects/transcripts/<video_id>.txt` — 58 transcripts (688 KB, gitignored)
- `index-ai-projects/INDEX.json` — counts + scope query summary
- `index-ai-projects/README.md` — how to rebuild

## Approach

Same playbook as the Hermes and AI model comparison modules:

1. Wrote a scoping SQL that catches project-build/setup/workflow/cron/kanban/swarm/coding-harness/directory/business terms.
2. Excluded pure tier-list, benchmark, or head-to-head comparison videos (those live in the AI model comparison module).
3. Verified counts (96 total, 58 with transcripts).
4. Exported the list to `index-ai-projects/videos.json` in one MCP query (141 KB).
5. Exported transcripts (563 KB across 58 files) and split per video.

## Encountered: bundle pollution (round 3)

Same problem as the previous modules:
- 32 of 96 videos carry the same 22-tag generic bundle.
- 44 of 96 carry the `openclaw` tag.
- The scope query's title-based logic excludes most of these.

The pattern is now well-established: tag-based filtering alone is unreliable for module scoping. Title + summary_verdict is the right pair. See `docs/layer-1-log.md` for the original finding.

## Encountered: cross-module overlap with Hermes

The "Hermes automation" bucket (18 videos) overlaps heavily with the Hermes module. These are Kanban / Cron / sub-agent videos that the drafter will use as supplementary evidence rather than primary source. The Hermes module's lessons (especially L08 on automation) cover this content in depth.

## Encountered: directory-build niche is thin

Only 1 video in scope for "directory builds" (the famous "_8iv521cy_A: AI built me a Business in 48 Hours (Online Directory)" video). The channel's documented belief: "Niche directory sites are a legitimate, mostly-passive income play ($5K–$100K/month), best built with cheap no-code + LLM stacks like Hostinger Horizons + Kimi, and the founder's prior niche advantage is the real moat."

For Layer 2, the directory-build lesson may need to lean heavily on this single video plus `Specs/ChannelIdentity.md` for body content. Treat as evidence-light.

## Encountered: vibe-coding bucket is thin

Only 1 video matches "vibe coding" exactly (`0_87ZfF44dk: Programmer vs Vibe Coder`). Most vibe-coding content is tagged with the generic bundle and gets caught by the title-keyword filter. The drafter will broaden the lesson scope to cover "AI-built projects" generally rather than vibe-coding specifically.

## Topic distribution

| Bucket | Videos | Transcripts |
|---|---|---|
| Hermes setup guides | 12 | 8 |
| Hermes automation (Kanban/Cron) | 18 | 0 ⚠️ |
| Coding harnesses (Claude Code / Kilo Code) | 15 | 12 |
| Hermes builds | 3 | 0 |
| Vibe coding | 1 | 1 |
| Directory builds | 1 | 1 |
| Business / startup | 1 | 1 |
| Other projects (catch-all) | 45 | 35 |

## Counts verified

| Claim | SQL check | Result |
|---|---|---|
| Total scoped videos | `count(*)` | 96 ✅ |
| With transcript | `has_transcript = true` | 58 ✅ |
| With summary | `has_summary = true` | 59 ✅ |
| Earliest published | min(published) | 2026-02-14 ✅ |
| Latest published | max(published) | 2026-06-22 ✅ |

## Files written this run

- `index-ai-projects/videos.json` (141 KB, 96 entries)
- `index-ai-projects/transcripts/*.txt` (58 files, 688 KB, gitignored)
- `index-ai-projects/INDEX.json` (compact summary)
- `index-ai-projects/README.md` (rebuild instructions)
- `.gitignore` already excludes `index-*/transcripts/*.txt`
- `docs/layer-1-log-ai-projects.md` (this file)

## What's next

Layer 1 done for New AI projects. Next: Layer 2 — propose 4–6 lessons for this module. Suggested lesson outline:

- L01: Coding with Claude Code (production coding)
- L02: Vibe Coding vs Real Coding (when to use which)
- L03: Building with Hermes (research, automation, sites)
- L04: Niche Directory Sites (Hostinger + Kimi stack)
- L05: The Online Business Stack (no-code + LLM)

5 lessons, each grounded in primary videos. User reviews and approves before Layer 3 drafting.

## Open questions for the user

1. **5 lessons, or fewer?** The "directory build" niche is thin (1 video). Acceptable as a standalone lesson?
2. **Coding harness focus**: Claude Code only, or also Kilo Code / Cursor?
3. **Cross-module references**: L01 (Hermes module) covers installation. L03 here covers building with Hermes. Both are valid — confirm scope.