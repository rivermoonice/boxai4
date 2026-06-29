# L01 — what-is-an-ai-model-tier-list

**Module:** AI model comparison
**Proposed by:** layer-2-ai-models-2026-06-26
**Status:** proposed

---

## Title (SEO formula)

**Working title:** What Is an AI Model Tier List? A Beginner's Guide to Comparing LLMs in 2026

**Meta title (50–60 chars):** What Is an AI Model Tier List? (Beginner Guide)
**Meta description (150–160 chars):** Tier lists rank AI models from S to D. Learn what they mean, how they're built, and why you should read three before believing any of them.
**URL slug:** what-is-an-ai-model-tier-list

---

## Audience

**For:** Someone who has used ChatGPT or Claude casually and wants to understand what "S-tier model" actually means. No prior knowledge of model evaluation assumed.
**Not for:** Anyone who already ships production code with multiple models.

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Explain what a model tier list is and how it's constructed.
- Read a tier list critically — know what to look for and what to ignore.
- Pick a model from a tier list for a given workload.

**Time estimate:** 8-min read

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `kOZzRRQHqR8` | AI Model Tier List for Agentic Workflows (April 2026) | 1046s | primary |
| 2 | `yE9_9zkP47c` | NEW AI Model Tier List for Vibe Coding! | 966s | supporting |

**Why these videos:** Both are tier-list videos from April–June 2026. `kOZzRRQHqR8` is for "agentic workflows" (heavy tool use, sub-agents). `yE9_9zkP47c` is for "vibe coding" (interactive, code-heavy). Together they cover the two main use cases a beginner cares about.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `kOZzRRQHqR8` | `00:00` | `17:00` | full walkthrough of the agentic tier list |
| `yE9_9zkP47c` | `00:00` | `16:00` | full walkthrough of the vibe-coding tier list |

---

## Prerequisites

None — this is L01 of the AI model comparison module.

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [x] 3. Comparison & Decision Framework *(this lesson IS a decision framework)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Treating any single tier list as ground truth.** Per the channel's documented belief, "Frontier evals like SWE-bench Pro are unreliable/cherry-picked; trust FrontierCoding Diamond, Artificial Analysis, and especially hands-on real-task testing."
2. **Confusing "best at coding" with "best for your work."** A model that's S-tier for code may be C-tier for vision, and vice versa.
3. **Ignoring cost.** An S-tier model at $200/month is not better than an A-tier model at $5/month if the A-tier handles your workload.
4. **Reading tier lists from non-experts.** Anyone can publish a tier list. Look for lists from people who run real workloads.
5. **Chasing tier changes weekly.** Models update. The tier you read this week may be stale next week.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: A tier list typically ranks models on a scale of:
2. Short answer: According to the channel's beliefs, which benchmark should you NOT trust?
3. Multiple choice: When picking a model from a tier list, the most important factor is:
4. Short answer: Name one non-tier-list source for model comparison.

---

## Suggested FAQ (for §9)

- **Q: How often do tier lists update?**
- **Q: Can I trust a tier list from a YouTuber?**
- **Q: What's the difference between S-tier and A-tier?**

---

## Glossary Seeds

- **Tier list** — a ranking of AI models, typically S/A/B/C/D.
- **S-tier** — the best. Top 1–3 models globally.
- **A-tier** — very good. Top 5–10 models globally.
- **SWE-bench Pro** — a coding benchmark. The channel flags it as unreliable.
- **FrontierCoding Diamond** — a more trusted coding benchmark per the channel.
- **Artificial Analysis** — an independent model-evaluation site. Trusted by the channel.
- **Real-task testing** — running a model on actual work (a trading strategy, a game build, a coding task) rather than synthetic benchmarks.

---

## Notes for the Drafter

- **Lead with the channel's documented belief** about which benchmarks to trust. The lesson should explicitly warn beginners off SWE-bench Pro.
- **Frame tier lists as starting points, not ground truth.** The channel's bet: read three lists, then run your own tests.
- **Decision framework is the lesson's spine** — the §3 comparison table matters more than the §2 history of tier lists.
- **Cross-reference L06 in the Hermes module** — tier-list models change as new releases ship.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index-ai-models/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_