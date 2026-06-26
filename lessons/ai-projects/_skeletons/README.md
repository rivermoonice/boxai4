# New AI Projects Module — Proposed Lesson Skeletons

Layer 2 output. **Each skeleton needs human review before Layer 3 drafting begins.**

## Course outline (proposed)

| # | Title | Source videos | Transcripts | Status |
|---|---|---|---|---|
| L01 | How to Use Claude Code for Beginners | 4 | 4/4 | proposed |
| L02 | Vibe Coding vs Real Coding | 2 | 2/2 | proposed |
| L03 | Building Real Projects with Hermes | 1 | 0/1 ⚠️ | proposed |
| L04 | Niche Directory Sites | 1 | 1/1 ⚠️ | proposed |
| L05 | The Online Business Stack | 2 | 2/2 ⚠️ | proposed |

⚠️ = evidence-light: the L03 / L04 / L05 buckets have 0–2 transcripts. The drafter will lean on `Specs/ChannelIdentity.md` for body content.

## How to review

Open each skeleton and:

1. Check the **Title (SEO formula)** — does the formula match the spec? Is it specific enough to rank?
2. Check the **Learning Objectives** — are they action-verb outcomes a beginner could actually achieve?
3. Check the **Source Videos** — every `video_id` must exist in `index-ai-projects/videos.json`. Cross-check the verdicts.
4. Check the **Pitfalls** — are these real beginner mistakes, or invented?
5. Check the **Notes for the Drafter** — any structural choices you want changed?

## What approval means

Approving a skeleton tells the drafter (Claude) to fill in `templates/lesson.md` using the skeleton as source of truth.

## Notable design choices

- **L01 covers Claude Code AND Kilo Code** — they're the two open coding harnesses in the index. Lesson teaches patterns that transfer.
- **L02 frames vibe coding vs real coding as a spectrum** — many beginners land in the middle.
- **L03 is a cross-reference lesson** — points back to the Hermes module for the heavy lifting.
- **L04 has 1 primary video** — directory builds are niche in the index. Lean on `Specs/ChannelIdentity.md`.
- **L05 is the capstone** — synthesises L01–L04 into a "real business" framing.

## What's next

Once approved, Layer 3 drafts L01 first (largest source set). L02–L05 follow in order — each reviewed before commit.