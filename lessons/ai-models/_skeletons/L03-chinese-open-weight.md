# L03 — chinese-open-weight

**Module:** AI model comparison
**Proposed by:** layer-2-ai-models-2026-06-26
**Status:** proposed

---

## Title (SEO formula)

**Working title:** Kimi K2.7 and DeepSeek V4 Pro: The Chinese Open-Weight Models That Beat the West in 2026

**Meta title (50–60 chars):** Kimi vs DeepSeek: Chinese Open-Weight Models 2026
**Meta description (150–160 chars):** Two Chinese labs, two flagship models, both S-tier for daily work. A real-world comparison of cost, capability, and the agent swarm trick Kimi uses.
**URL slug:** kimi-vs-deepseek-chinese-open-weight

---

## Audience

**For:** A reader who has heard of DeepSeek and Kimi but doesn't know how they compare to Western frontier models. Considering open-weight alternatives.
**Not for:** Anyone already running open-weight models in production.

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Explain what "open-weight" means and why it matters.
- Compare Kimi K2.7 and DeepSeek V4 Pro on real workloads.
- Decide when to use a Chinese open-weight model vs Claude Opus.

**Time estimate:** 12-min read

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `nzG5KXBAYxs` | Kimi K2.7 Review (MUST Use Agent Swarm) | 727s | primary (Kimi) |
| 2 | `eOEFp8bjpDQ` | DeepSeek v4 Pro Review (Real World Tests) | 1551s | primary (DeepSeek) |
| 3 | `B4KfrB-OFwE` | Kimi Agent Swarm LIVE Review | 637s | supporting (Kimi swarm) |

**Why these videos:** The channel's documented belief is unambiguous: "Chinese open-weight models (Kimi, Qwen, DeepSeek) are the practical benchmark that Western frontier models must clear, not the other way around." `nzG5KXBAYxs` and `eOEFp8bjpDQ` are the canonical reviews for these two models. The Agent Swarm clip adds the "must use /swarm" caveat the channel is explicit about.

⚠️ **Evidence note:** Most Kimi and DeepSeek videos in the index are 60–80 second clips without transcripts. Only 7 of 27 have full transcripts. The drafter will lean on the channel's documented beliefs in `Specs/ChannelIdentity.md` for body content beyond the three primaries.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `nzG5KXBAYxs` | `00:00` | `12:00` | Kimi K2.7 review, the /swarm requirement |
| `eOEFp8bjpDQ` | `00:00` | `26:00` | DeepSeek V4 Pro full tests, tool-call reasoning strength |
| `B4KfrB-OFwE` | `00:00` | `11:00` | Kimi Agent Swarm live review, the $40/mo plan caveat |

---

## Prerequisites

- L01: What Is an AI Model Tier List?

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

1. **Treating Kimi and DeepSeek as interchangeable.** They have different strengths (Kimi for coding + swarm, DeepSeek for tool-call reasoning).
2. **Using Kimi without `/swarm`.** Per the channel's review: "you must launch `/swarm` before planning."
3. **Paying for the $40/mo Kimi plan for the swarm alone.** The channel recommends "self-host OpenClaw for ~$2/mo instead."
4. **Using DeepSeek V4 Pro for one-shot creative writing.** Per the source video: "the one-shot output is weaker than Kimi 2.6 and MiMo 2.5 Pro."
5. **Ignoring geographic restrictions.** Kimi's API has China vs international variants. The source video flags this for non-China users.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: "Open-weight" means:
2. Short answer: What is the "/swarm" requirement for Kimi K2.7?
3. Multiple choice: For tool-call reasoning, the channel's pick is:
4. Short answer: Why is DeepSeek V4 Pro weaker than Kimi for one-shot creative work?

---

## Suggested FAQ (for §9)

- **Q: Can I run Kimi or DeepSeek locally?**
- **Q: Why are Chinese open-weight models so much cheaper than Claude?**
- **Q: Are Chinese open-weight models censored?**

---

## Glossary Seeds

- **Open-weight** — a model whose trained parameters (weights) are publicly downloadable. You can run them locally or fine-tune them.
- **Open-source** — broader than open-weight. Includes training data, training code, etc. Most "open-weight" models are NOT fully open-source.
- **Agent swarm** — a Kimi-specific pattern of launching multiple sub-agents in parallel for a single task.
- **Tool-call reasoning** — a model's ability to choose the right function/API call given a request. DeepSeek V4 Pro is "best-in-class" per the channel.
- **One-shot** — completing a task in a single attempt without iteration.

---

## Notes for the Drafter

- **Channel-voice alignment:** The channel's documented belief is direct: "Chinese open-weight models (Kimi, Qwen, DeepSeek) are the practical benchmark that Western frontier models must clear, not the other way around." The lesson should reflect this stance without being preachy.
- **Cost transparency is critical.** Both Kimi and DeepSeek are dramatically cheaper than Claude for similar performance on most workloads.
- **Geographic caveat is real.** Kimi's API differs between China and international users. Document this.
- **The swarm caveat is the most important actionable advice** — beginners will try Kimi as a single-agent and be disappointed.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index-ai-models/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_