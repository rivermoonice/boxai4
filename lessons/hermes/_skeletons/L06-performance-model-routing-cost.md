# L06 — performance-model-routing-cost

**Module:** Hermes agent
**Proposed by:** layer-2-hermes-2026-06-24
**Status:** proposed

---

## Title (SEO formula)

**Working title:** How to Pick the Cheapest AI Model for Hermes Agent (2026 Cost Guide)

**Meta title (50–60 chars):** Cheapest AI Model for Hermes (2026 Cost Breakdown)
**Meta description (150–160 chars):** Hermes doesn't pick your model — you do. A real cost breakdown of Claude Opus, Kimi, DeepSeek, and Qwen for daily-driver workloads. $5/mo vs $200/mo.
**URL slug:** cheapest-ai-model-for-hermes

---

## Audience

**For:** A Hermes user who has been running a model (probably the default) and wants to understand the cost trade-offs.
**Not for:** Anyone who hasn't picked a model at install time (L02 covers that).

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Read and compare AI model pricing tables.
- Route cheap tasks to cheap models and hard tasks to expensive ones.
- Estimate your real monthly cost based on realistic beginner usage.

**Time estimate:** 12-min read

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `s3Q9hvdlrmo` | DeepSeek v4 Flash + Hermes Agent = Surprisingly STRONG | 1313s | primary (cheap model test) |
| 2 | `Af7Fg1m7hRw` | Top AI Models for Hermes Agent (Tier List) | 1480s | primary (tier list) |
| 3 | `GL2FhteoPBA` | Hermes Agent Update v0.15 is POWERFUL! (Velocity Release) | 799s | supporting (speed wins) |

**Why these videos:** `s3Q9hvdlrmo` is the only deep test of a single cheap model with Hermes — its verdict says "legitimately strong lightweight model worth routing most agent tasks through." `Af7Fg1m7hRw` is the canonical tier list. `GL2FhteoPBA` adds the v0.15 speed improvements that change the calculus.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `s3Q9hvdlrmo` | `00:00` | `22:00` | full DeepSeek V4 Flash test with Hermes — what works, what doesn't |
| `Af7Fg1m7hRw` | `00:00` | `25:00` | full tier list — orchestrators vs executors |
| `GL2FhteoPBA` | `00:00` | `13:00` | v0.15 speed and stability changes |

---

## Prerequisites

- L02: Install & first run (you need to have picked a model already)
- L03: TUI vs Desktop App (token cost mentioned here)

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [x] 3. Comparison & Decision Framework
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Picking the most expensive model for everything** — Opus-class is overkill for most agent tasks. Route cheap tasks to cheap models.
2. **Picking the cheapest model for hard reasoning** — vision, one-shots, and complex planning need an expensive model. Don't route everything to DeepSeek V4 Flash.
3. **Ignoring sub-agent delegation cost** — `s3Q9hvdlrmo`'s verdict says "sub-agent delegation is too slow." Multi-step work is more expensive than a single well-prompted call.
4. **Not setting a budget cap in the provider dashboard** — runaway sessions can burn dollars in minutes. Set a hard cap on day one.
5. **Chasing the "best" model instead of the best for the task** — the tier list exists because different models win at different jobs.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: For a beginner doing 100 messages/day, the realistic monthly cost of DeepSeek V4 Flash is closest to… ($0.50 / $5 / $50 / $200)
2. Short answer: Per the source, is sub-agent delegation cheap?
3. Multiple choice: You should pick Opus for… (every message / vision and one-shot planning / file reads / counting tokens)
4. Short answer: Name one thing the v0.15 release changed about cost.

---

## Suggested FAQ (for §9)

- **Q: Which model should I start with?**
- **Q: Can I switch models mid-session?**
- **Q: How do I see how much I've spent this month?**
- **Q: Is Kimi K2.7 actually cheaper than Claude? By how much?**

---

## Glossary Seeds

- **Token** — a small chunk of text (≈¾ of a word) that the model charges you for. Both input and output tokens count.
- **Model tier** — a rough classification: S-tier (best), A-tier (good), B-tier (decent), C/D-tier (avoid).
- **Orchestrator** — the model that plans and decides. Typically more expensive, called rarely.
- **Executor** — the model that does the actual work. Typically cheaper, called many times.
- **Tiered routing** — using the orchestrator for hard work and the executor for bulk work. The whole point of this lesson.

---

## Notes for the Drafter

- **Cost table is the heart of this lesson.** Build it: model | $/1M input tokens | $/1M output tokens | realistic monthly cost for a beginner.
- **Channel-voice alignment**: this lesson directly maps to the channel's "tiered model workflow" belief (one of the high-confidence Beliefs in `Specs/ChannelIdentity.md`). The course is teaching this belief to beginners, so the lesson must be both honest *and* persuasive.
- **Update freshness**: pricing changes. Include the "Last tested and updated" date prominently and link to the provider's pricing page (in §9).
- **Don't recommend any specific model for a beginner without a "Last tested" caveat.** Pricing changes monthly.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_