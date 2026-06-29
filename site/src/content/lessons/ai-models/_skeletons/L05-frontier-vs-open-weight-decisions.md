# L05 — frontier-vs-open-weight-decisions

**Module:** AI model comparison
**Proposed by:** layer-2-ai-models-2026-06-26
**Status:** proposed

---

## Title (SEO formula)

**Working title:** Frontier vs Open-Weight AI Models: How to Pick in 2026 (Decision Framework)

**Meta title (50–60 chars):** Frontier vs Open-Weight AI Models (2026 Decision)
**Meta description (150–160 chars):** Should you pay for Claude Opus or run an open-weight model locally? A decision framework based on workload, cost, and the channel's tested recommendations.
**URL slug:** frontier-vs-open-weight-models

---

## Audience

**For:** A reader who has tried Claude and is curious whether running an open-weight model locally or via API makes sense.
**Not for:** Anyone who hasn't yet tried at least one AI model.

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Define frontier, open-weight, and open-source clearly.
- Apply a decision framework to pick the right model family for a workload.
- Recognize the trade-offs between cost, capability, and control.

**Time estimate:** 10-min read

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `0_87ZfF44dk` | Programmer vs Vibe Coder: The Real Way to Build with AI | 2019s | primary (decision framing) |
| 2 | `GGtmmx0MKCI` | Agent Harness vs Coding Harness (Know the Difference) | 790s | primary (workload framing — also used in L01 of Hermes module) |
| 3 | `r039hxfog44` | GLM 5.2 is TOO GOOD! (Better than Opus 4.8) | 580s | supporting (frontier vs open-weight comparison) |
| 4 | `zaLAonePx38` | Sakana Fugu ULTRA Review (Better than Fable 5?!) | 590s | supporting (orchestration as frontier frontier) |

**Why these videos:** `0_87ZfF44dk` is the longest and most direct decision-framing video in the index. `GGtmmx0MKCI` is the canonical "pick by loop, not by model" source. The GLM 5.2 and Sakana Fugu clips are concrete examples of open-weight and orchestration competing with frontier.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `0_87ZfF44dk` | `00:00` | `33:00` | full talk — Programmer vs Vibe Coder decision framework |
| `GGtmmx0MKCI` | `00:00` | `13:00` | harness vs model, pick by loop not by model |
| `r039hxfog44` | `00:00` | `10:00` | GLM 5.2 — open-weight beating frontier for one workload |
| `zaLAonePx38` | `00:00` | `10:00` | Sakana Fugu — orchestration as the new frontier |

---

## Prerequisites

- L01: What Is an AI Model Tier List?
- L02: The Anthropic Family
- L03: Kimi and DeepSeek (Chinese Open-Weight)
- L04: Qwen, MiniMax, GLM (Cost-Efficient Tier)

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [x] 3. Comparison & Decision Framework *(the heart of this lesson)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Choosing frontier "because it's the best."** The channel's documented belief: "Pure, cost-efficient models like Kimi K2.7 and MiniMax M3 beat raw frontier capability for everyday use."
2. **Assuming open-weight means free.** Training, hosting, and inference still cost money — just different money than subscriptions.
3. **Ignoring the harness choice.** Per the source: "Use coding harnesses (Claude Code, Kilo Code) for any code-producing work; treat general agent harnesses (Hermes, OpenClaw) as long-running assistants." The harness matters more than the model for many workloads.
4. **Comparing models on synthetic benchmarks.** Per the channel: "Frontier evals like SWE-bench Pro are unreliable/cherry-picked; trust FrontierCoding Diamond, Artificial Analysis, and especially hands-on real-task testing."
5. **Ignoring workload fit.** A S-tier coding model may be C-tier for vision. The decision framework should map workload to model family, not just "best overall."

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: The decision framework's first question should be:
2. Short answer: What does "pick by loop, not by model" mean?
3. Multiple choice: For coding all day, the channel recommends:
4. Short answer: Name one benchmark the channel flags as unreliable.

---

## Suggested FAQ (for §9)

- **Q: Is open-weight always cheaper?**
- **Q: Can I run an open-weight model locally on my laptop?**
- **Q: What's the difference between open-weight and open-source?**

---

## Glossary Seeds

- **Frontier model** — the most capable AI model from a major lab (Claude Opus, GPT 5.5, Gemini 3.1 Pro).
- **Open-weight model** — a model whose trained parameters are publicly downloadable. You can run them locally.
- **Open-source model** — broader than open-weight. Includes training data and code.
- **Tiered routing** — using the right model for the right task. Covered in the Hermes module's L06.
- **SWE-bench Pro** — coding benchmark. The channel flags it as cherry-picked and unreliable.
- **FrontierCoding Diamond** — coding benchmark. The channel trusts this.
- **Artificial Analysis** — independent model-evaluation site. The channel trusts this.

---

## Notes for the Drafter

- **This is the capstone lesson of the module.** It synthesises L01–L04 into a single decision framework.
- **The channel's documented beliefs are the spine:** "Pick by loop, not by model" + "Frontier evals are unreliable; trust hands-on real-task testing" + "Practical, cost-efficient models beat raw frontier capability for everyday use."
- **The decision framework table is the lesson.** Build it carefully: workload → recommended model family → cost tier → example model.
- **Honesty matters.** The channel doesn't recommend one family for all workloads. The framework should make that explicit.
- **Cross-reference the Hermes module** — L06 there covers tiered routing within a single harness. This lesson covers picking the model family before you even pick a harness.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index-ai-models/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_