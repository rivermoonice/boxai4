# AI Model Comparison Module — Proposed Lesson Skeletons

Layer 2 output for the AI model comparison module. **Each skeleton needs human review before Layer 3 drafting begins.**

## Course outline (proposed)

| # | Title | Source videos | Transcripts | Status |
|---|---|---|---|---|
| L01 | What Is an AI Model Tier List? | 2 | 2/2 | proposed |
| L02 | Claude Opus vs Sonnet vs Fable 5 | 5 | 5/5 | proposed |
| L03 | Kimi and DeepSeek (Chinese Open-Weight) | 3 | 3/3 ⚠️ | proposed |
| L04 | Qwen, MiniMax, GLM (Cost-Efficient Tier) | 5 | 5/5 | proposed |
| L05 | Frontier vs Open-Weight: Decision Framework | 4 | 4/4 | proposed |

⚠️ = evidence-light: the L03 bucket has 7 of 27 transcripts in scope. The drafter will lean on `Specs/ChannelIdentity.md` for body content beyond the three primaries.

## How to review

Open each skeleton and:

1. Check the **Title (SEO formula)** — does the formula match the spec? Is it specific enough to rank?
2. Check the **Learning Objectives** — are they action-verb outcomes a beginner could actually achieve?
3. Check the **Source Videos** — every `video_id` must exist in `index-ai-models/videos.json`. Cross-check the verdicts.
4. Check the **Pitfalls** — are these real beginner mistakes, or invented?
5. Check the **Notes for the Drafter** — any structural choices you want changed?

## What approval means

Approving a skeleton tells the drafter (Claude) to fill in `templates/lesson.md` using the skeleton as source of truth. Skeletons are short on purpose so review is fast.

## Notable design choices

- **L05 is the capstone** — it synthesises L01–L04 into a single decision framework. If you want a different capstone, say so.
- **L02 covers the Anthropic family as a unit** rather than splitting Opus / Sonnet / Fable 5 into separate lessons. This works because the channel's documentation treats them as a tier within one lab.
- **Sakana Fugu** is treated as a special case inside L05 (orchestration as the new frontier) rather than its own lesson. Only 3 Sakana videos in scope; not enough for a standalone.
- **No L06 yet.** Possible sixth lesson: "New AI Projects" if you want to break it out from the Hermes module. For now, projects live in the Hermes module.

## What's next

Once approved, Layer 3 drafts L01 first (smallest scope, sets voice). L02–L05 follow in order — each reviewed before commit.