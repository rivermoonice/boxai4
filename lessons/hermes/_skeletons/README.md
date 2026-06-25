# Hermes Module — Proposed Lesson Skeletons

Layer 2 output. **Each skeleton needs human review before Layer 3 drafting begins.**

## Course outline (proposed)

| # | Title | Source videos | Transcripts | Status |
|---|---|---|---|---|
| L01 | What Is Hermes Agent? A Beginner's Guide to AI Agent Harnesses | 1 | 1/1 | proposed |
| L02 | How to Install Hermes Agent for Beginners (Mac and VPS) | 3 | 2/3 | proposed |
| L03 | Hermes Agent TUI vs Desktop App | 2 | 2/2 | proposed |
| L04 | Hermes Agent Skills and Skill Bundles Explained | 5 | 5/5 | proposed |
| L05 | How to Connect Hermes Agent to Other Apps with the MCP Catalog | 2 | 2/2 | proposed |
| L06 | How to Pick the Cheapest AI Model for Hermes Agent | 3 | 3/3 | proposed |
| L07 | How to Secure Your Hermes Agent (Tailscale, Credentials) | 3 | 2/3 ⚠️ | proposed |
| L08 | Hermes Agent Automation: Cron, Kanban, Sub-Agents | 6 | 4/6 ⚠️ | proposed |
| L09 | Hermes Agent vs Claude Code vs Mavis | 4 | 4/4 | proposed |

⚠️ = evidence-light: the lesson draws on summaries + channel-voice beliefs, not just transcripts. Marked in each skeleton.

## How to review

Open each skeleton (e.g. `L01-what-is-hermes-agent.md`) and:

1. Check the **Title (SEO formula)** — does the formula match the spec? Is it specific enough to rank?
2. Check the **Learning Objectives** — are they action-verb outcomes a beginner could actually achieve?
3. Check the **Source Videos** — every `video_id` must exist in `index/videos.json`. Cross-check the verdicts in `index/videos.json`.
4. Check the **Pitfalls** — are these real beginner mistakes, or invented?
5. Check the **Notes for the Drafter** — any structural choices you want changed?

## What approval means

Approving a skeleton tells the drafter (Claude) to fill in `templates/lesson.md` using the skeleton as source of truth. Skeletons are short on purpose so review is fast.

## What to push back on

- The **order** — L01→L09 is the proposed sequence. Beginners may want MCP before Skills. You decide.
- The **scope of L07 and L08** — both are evidence-light. We could cut them, narrow them, or rebuild from the YouTube descriptions we don't have.
- The **Backlog** — 27 release-update and micro-tip videos aren't in any lesson. Either promote them into a "What changed in v0.X" recap lesson, or leave them as supporting material for the existing lessons.

## Next

Once approved, Layer 3 drafts L01 first (smallest scope, sets the voice for the rest). After L01 lands and reads well, the rest follow in numerical order — each reviewed before commit.