---
title: 'What Is an AI Model Tier List? A Beginner''s Guide to Comparing LLMs in 2026'
summary: ''
description: 'There are dozens of AI models you can use right now. Claude, GPT, Gemini, DeepSeek, Kimi, Qwen, MiniMax, GLM, Grok, and more. If you''re new, picking one feels like collecting infinity stones — exce…'
module: 'ai-models'
slug: 'l01-what-is-an-ai-model-tier-list'
order: 1
updatedDate: 2026-06-01
updatedRaw: 'June 2026'
readingMinutes: 17
accent: '#0ea5a4'
---

# What Is an AI Model Tier List? A Beginner's Guide to Comparing LLMs in 2026

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

There are dozens of AI models you can use right now. Claude, GPT, Gemini, DeepSeek, Kimi, Qwen, MiniMax, GLM, Grok, and more. If you're new, picking one feels like collecting infinity stones — except you don't have unlimited money, and the wrong pick wastes hours of your week.

A **tier list** is a way of ranking them. You'll see tier lists labelled S, A, B, C, D. They're useful as a starting point. They're dangerous if you treat them as ground truth.

In this lesson you'll learn what tier lists are, how they're built, what to look for, and — most importantly — what to ignore. By the end you'll be able to read a tier list critically and pick a model for your specific workload.

### Who this is for

Someone who has used ChatGPT or Claude casually and wants to understand what "S-tier model" actually means. No prior knowledge of model evaluation assumed.

### Who this is NOT for

Anyone who already ships production code with multiple models. This is the conceptual intro lesson.

### What you'll be able to do

- Explain what a model tier list is and how it's typically constructed.
- Read a tier list critically — know what to look for and what to ignore.
- Pick a model from a tier list for a given workload.

### Learning Objectives

- Define the tier categories (S/A/B/C/D) and what they usually mean.
- List three things that make a tier list credible (and three that don't).
- Apply a workload-first decision framework when reading any tier list.
- Identify one source of model comparison the channel trusts and one it flags as unreliable.

### Time estimate

8-minute read

### Prerequisites

None — this is L01 of the AI model comparison module.

### Why this matters in 2026

In 2026 the model market is more crowded than ever. Models ship every few weeks. Pricing changes monthly. Capability claims get louder. Tier lists try to make sense of this — but as the channel's documented belief puts it: "Frontier evals like SWE-bench Pro are unreliable/cherry-picked; trust FrontierCoding Diamond, Artificial Analysis, and especially hands-on real-task testing." Knowing how to read tier lists critically is the difference between picking a real winner and chasing hype.

---

## 2. Core Content

### Chapters

- `00:00` — What a tier list is (and why you should read three of them)
- `02:00` — How the source video builds its tier list
- `04:00` — The S-tier trap
- `06:00` — Benchmarks to trust (and not trust)
- `07:30` — How to use a tier list for your workload

> 💡 **Ron's Pro Tip** — Tier lists are starting points, not gospel. Read three lists from people who run real workloads. Then run your own test before committing.

### Step 1 — What a tier list is (and why you should read three of them)

A **model tier list** is a ranking of AI models, typically labelled:

- **S-tier** — the best. Top 1–3 models globally. Most expensive. Most capable.
- **A-tier** — very good. Top 5–10 models globally. Often the daily-driver sweet spot.
- **B-tier** — good. Reliable for specific use cases. Often the cost-tier pick.
- **C-tier** — usable but limited. Pick only if the alternatives fail.
- **D-tier** — don't use for production. May be promising in private beta.

The labels are roughly universal but the boundaries aren't. One creator's A-tier is another creator's B-tier. The framing — what workloads they care about, what they tested, what they value — matters more than the letters.

> Source: `kOZzRRQHqR8` — "It's quite hard to know which one to even use at the start. It might also be fun because it kind of feels like you're collecting infinity system."

The right move is to read three lists from people who run workloads similar to yours. If all three put the same model in S-tier for your use case, that's a strong signal. If they disagree, you need to dig deeper.

### Step 2 — How the source video builds its tier list

The source video uses a "Wildclaw Bench" — 60 tasks run inside OpenClaw to test real agentic workflow. Models that complete more tasks without prompt-injection failures score higher. This is exactly the kind of test the channel trusts: hands-on, real-task, repeatable.

The ranking as of late March 2026:

- **S-tier**: Claude Opus (despite "disrespectful" billing transparency)
- **S/95%**: GPT 5.4 (cheaper, getting better)
- **A-tier**: MiniMax, Kimi, Grok (with caveats — Grok is fast but bad at coding)
- **B-tier**: Step, Hermes's own model
- **C-tier**: Gemini ("they know they suck")
- **D-tier**: DeepSeek (until a new release)

> Source: `kOZzRRQHqR8` — "We were pretty big into Wildclaw bench. The results are quite interesting in terms of real world use cases. GPT 5.4 gets stuff done but the cost is lower. It's catching popularity just because of the cost."

Notice what the source video **didn't** do: trust synthetic benchmarks like SWE-bench Pro as the primary ranking signal. The hands-on real-task test was the spine. That's the methodology that produces credible tier lists.

### Step 3 — The S-tier trap

The biggest mistake beginners make is to read "Claude Opus is S-tier" and assume Opus is always the answer. S-tier means "best for the workload the tier-list creator tested." It does not mean "best for your workload."

For example:
- Opus may be S-tier for agentic coding, but C-tier for vision work.
- A cheap open-weight model may be A-tier for daily Q&A and S-tier for your specific sub-niche.
- The newest flagship may be S-tier on benchmarks but D-tier on cost for your budget.

> Source: `kOZzRRQHqR8` — "Claude gets very expensive. It's most expensive model. And on top of that they've been a little bit disrespectful of the community. Recently people have been noticing that their usage plans got reduced without telling us."

The S-tier trap also has a cost dimension. An S-tier model at $200/month is not better than an A-tier model at $5/month if the A-tier handles your workload. The channel's documented belief is explicit: "Practical, cost-efficient models like Kimi K2.7 and MiniMax M3 beat raw frontier capability for everyday use."

### Step 4 — Benchmarks to trust (and not trust)

The channel's documented belief about benchmarks, from `Specs/ChannelIdentity.md` and the source video:

**Trusted benchmarks:**
- **FrontierCoding Diamond** — coding-specific, well-named baselines, the channel trusts this.
- **Artificial Analysis** — independent model-evaluation site, broadly trusted.
- **Hands-on real-task testing** — running the model on actual work (a trading strategy, a game build, a coding task) rather than synthetic evals.

**Distrusted benchmarks:**
- **SWE-bench Pro** — coding benchmark. The channel's verdict: "cherry-picked and unreliable."
- **Anonymized "Model A vs Model B vs Model C" comparisons** — Sakana Fugu uses this format and the channel calls out the lack of named baselines as a transparency red flag.

> Source: `kOZzRRQHqR8` — "The fact that even engineers from Meta are using Claude. They learn on top of that. That's what makes it really powerful." (Note: this is about network effects and user feedback, not synthetic benchmarks. The source video's credibility comes from real-user feedback, not benchmark numbers.)

### Step 5 — How to use a tier list for your workload

The right way to use a tier list:

1. **Identify your workload.** Coding? Long-document summarisation? Daily Q&A? Vision?
2. **Find tier lists focused on that workload.** A generalist list is less useful than a workload-specific list.
3. **Cross-check with two other lists.** If all three agree on a model for your workload, that's a signal.
4. **Check the cost.** S-tier is irrelevant if the cost is 10× your budget.
5. **Run a 1-hour test before committing.** Most providers offer free credits or a pay-as-you-go tier. Use it.
6. **Re-test every quarter.** The model market changes fast. Your "A-tier pick" today may be "B-tier pick" in three months.

> Source: `kOZzRRQHqR8` — "You can view it on boxminingai.com. We're going to update this as this month progresses. We're going to review this very soon because yet again, all these models have newest updates coming soon."

---

## 3. Comparison & Decision Framework

This lesson IS the decision framework. The table below shows what to look for in a credible tier list and what to ignore.

| Source | Trust it? | Why |
|---|---|---|
| FrontierCoding Diamond | ✅ Yes | Named baselines, transparent methodology |
| Artificial Analysis | ✅ Yes | Independent, broad coverage |
| Hands-on real-task tests (e.g. Wildclaw Bench) | ✅ Yes | Real workloads, reproducible |
| SWE-bench Pro | ❌ No | Cherry-picked, unreliable per the channel |
| Vendor self-reported benchmarks | ⚠️ Use with care | Vendors cherry-pick favourable tasks |
| Anonymized model comparisons | ❌ No | No way to verify which model is which |
| A YouTuber's tier list | ⚠️ Depends | Trust depends on whether they run real workloads |
| Tier lists older than 3 months | ⚠️ Re-verify | Model market moves fast |

**Decision guide:**

- **If your workload is coding** → look for tier lists that test real coding tasks (FrontierCoding Diamond, Wildclaw Bench).
- **If your workload is daily Q&A** → cost matters more than capability. Read cost-tier coverage.
- **If your workload is vision or multimodal** → explicitly check the tier list tested vision. Most lists skip it.
- **If the tier list is older than 3 months** → re-run your own test. The market may have shifted.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Treating any single tier list as ground truth

- **Symptom:** You pick an S-tier model and assume it's the best for everything you do.
- **Cause:** S-tier means "best for the workload the creator tested." Not "best for everything."
- **Fix:** Read three lists. Look for agreement.

### Pitfall 2 — Confusing "best at coding" with "best for your work"

- **Symptom:** You pick an S-tier coding model and find it C-tier for vision or long-doc work.
- **Cause:** Different workloads need different strengths. Tier lists can't cover every use case.
- **Fix:** Match the tier list to your workload. Coding-tier lists for coding. Vision-tier lists for vision.

### Pitfall 3 — Ignoring cost

- **Symptom:** You pick the S-tier model and discover your monthly bill is $300.
- **Cause:** S-tier often means most expensive. The channel has flagged Claude's billing transparency as "disrespectful."
- **Fix:** Build a cost table before picking. A S-tier model at $200/mo is not always better than an A-tier model at $5/mo for daily work.

### Pitfall 4 — Reading tier lists from non-experts

- **Symptom:** You follow a tier list from a creator who doesn't run real workloads and pick a model that fails.
- **Cause:** Anyone can publish a tier list. Without testing methodology, it's just opinion.
- **Fix:** Look for tier lists from people who run real workloads and publish their test methodology.

### Pitfall 5 — Chasing tier changes weekly

- **Symptom:** You switch models every time a new tier list drops. Your work is constantly interrupted.
- **Cause:** Model market is moving fast. New releases ship every few weeks.
- **Fix:** Pick a model and stick for at least a quarter. Re-evaluate when a major release ships.

### Pitfall 6 — Trusting vendor self-reported benchmarks

- **Symptom:** A vendor's blog claims their model is "the best at X." You pick it and find it's mediocre.
- **Cause:** Vendors cherry-pick favourable tasks. Self-reported benchmarks are marketing, not science.
- **Fix:** Trust independent benchmarks (FrontierCoding Diamond, Artificial Analysis) over vendor claims.

### Pitfall 7 — Ignoring the cost dimension of "tier"

- **Symptom:** You treat S/A/B/C/D as purely capability rankings.
- **Cause:** Tier lists usually optimise for capability per dollar, but the dollar axis isn't always explicit.
- **Fix:** Always build a separate cost column when reading tier lists.

### Pitfall 8 — Picking from a tier list older than your work

- **Symptom:** You follow a tier list from 4 months ago. The model has been deprecated or upgraded since.
- **Cause:** Models change fast. Tier lists go stale.
- **Fix:** Date-stamp the tier list. Anything older than 3 months needs re-verification.

---

## 5. Key Takeaways & Ron's Bottom Line

- A tier list ranks models S/A/B/C/D. The letters are roughly universal but the boundaries aren't.
- Read three tier lists from people who run real workloads.
- "S-tier" means "best for the workload the creator tested." It doesn't mean "best for your workload."
- Cost matters as much as capability. S-tier at $200/mo is not always better than A-tier at $5/mo for daily work.
- Trusted benchmarks: FrontierCoding Diamond, Artificial Analysis, hands-on real-task tests.
- Distrusted benchmarks: SWE-bench Pro, vendor self-reports, anonymized comparisons.
- Always run a 1-hour test before committing to a model. Tier lists are starting points, not gospel.
- "Frontier evals like SWE-bench Pro are unreliable/cherry-picked; trust FrontierCoding Diamond, Artificial Analysis, and especially hands-on real-task testing." — `Specs/ChannelIdentity.md`

> 🟦 **Ron's Bottom Line** — A tier list is a starting point, not gospel. Read three of them. Match the list to your workload. Check the cost. Run your own test before committing. S-tier models are the safest bet if cost is no object; A-tier models usually handle 80% of daily work for 1/10th the price. The biggest mistake is picking the highest-tier model and ignoring whether it actually fits your work.

---

## 6. Hands-On Practice

### Exercise

**Task:** Pick a workload you do regularly. Find two tier lists focused on that workload (try FrontierCoding Diamond for coding, Artificial Analysis for general). Identify the top three models on each list. Note the cost of each. Pick one for a 1-hour test.

**Success criteria:** You can name your workload, two tier lists you checked, three models per list, the cost of your pick, and what you'll test in your 1-hour trial.

### Do this today

- [ ] Pick a workload (coding, writing, Q&A, vision, etc.).
- [ ] Find two tier lists focused on that workload.
- [ ] Note three top models from each list.
- [ ] Build a cost table for your top three picks.
- [ ] Pick one and run a 1-hour test.
- [ ] Document the result in a note for future reference.

### What's next

- Next lesson: **L02 — Claude Opus vs Sonnet vs Fable 5** — the Anthropic family as a unit.
- Related: **L05 — Frontier vs Open-Weight: Decision Framework** — the capstone lesson that synthesises everything.

> 💬 Drop your "I picked an A-tier model and it worked" or "I tested an S-tier and it failed" story in the Discord.

---

## 7. Self-Check / Mini-Quiz

**Q1.** A model tier list typically ranks models on a scale of:
- A) 1–10
- B) S/A/B/C/D
- C) Gold/Silver/Bronze
- D) Pass/Fail

**Q2.** Short answer: According to the channel's documented beliefs, which benchmark should you NOT trust?

**Q3.** When picking a model from a tier list, the most important factor is:
- A) The letter (S-tier is always best)
- B) Whether the tier list tested workloads like yours
- C) The price
- D) The vendor's marketing

**Q4.** Short answer: Name one non-tier-list source for model comparison that the channel trusts.

**Q5.** Multiple choice: The biggest mistake beginners make when reading tier lists is:
- A) Reading too many of them
- B) Treating any single tier list as ground truth for their specific workload
- C) Ignoring cost
- D) All of the above

**Q6.** Short answer: According to the source video, what does "S-tier" actually mean?

### Answers

**A1.** B — S/A/B/C/D. The other scales aren't standard for AI model tier lists.

**A2.** SWE-bench Pro. The channel's documented belief: "Frontier evals like SWE-bench Pro are unreliable/cherry-picked."

**A3.** B — Whether the tier list tested workloads like yours. S-tier means "best for what the creator tested," not "best for you."

**A4.** Hands-on real-task testing. Run the model on actual work (a trading strategy, a game build, a coding task) rather than synthetic evals.

**A5.** D — All of the above. Each one is a real beginner mistake.

**A6.** "Best for the workload the creator tested." Not "best for everything." Not "best for your workload unless your workload matches the creator's."

**Scoring:** 5–6 correct → ready for L02. 3–4 → re-read Step 3. 0–2 → restart from the top.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Primary video** — `AI Model Tier List for Agentic Workflows (April 2026)` (`kOZzRRQHqR8`, 1046s, March 2026). The whole lesson's framework comes from this video.
- **Supporting video** — `NEW AI Model Tier List for Vibe Coding!` (`yE9_9zkP47c`, 966s, June 2026). A more recent tier list focused on vibe coding.
- **Trusted benchmarks:**
  - `artificialanalysis.ai` — independent model evaluation
  - FrontierCoding Diamond — coding-specific benchmark
- **Channel beliefs** — `Specs/ChannelIdentity.md` in this repo. Documents the benchmark trust hierarchy.

### Glossary

- **Tier list** — a ranking of AI models, typically S/A/B/C/D.
- **S-tier** — the best. Top 1–3 models globally.
- **A-tier** — very good. Top 5–10 models globally.
- **B-tier** — good. Reliable for specific use cases.
- **C-tier** — usable but limited.
- **D-tier** — don't use for production.
- **SWE-bench Pro** — coding benchmark the channel flags as cherry-picked.
- **FrontierCoding Diamond** — coding benchmark the channel trusts.
- **Artificial Analysis** — independent model-evaluation site the channel trusts.
- **Real-task testing** — running a model on actual work rather than synthetic benchmarks.
- **Wildclaw Bench** — the source video's preferred test: 60 tasks run inside OpenClaw to test real agentic workflows.
- **Cost-tier** — a tier based on cost-per-task, not raw capability. A $5/mo model can be A-tier for daily work.
- **Frontier model** — the most capable AI model from a major lab (Claude Opus, GPT 5.x, Gemini 3.x).

### Go deeper

- **Want to learn about the Anthropic family?** → L02: Claude Opus vs Sonnet vs Fable 5.
- **Want to understand open-weight models?** → L03: Kimi and DeepSeek.
- **Want a single decision framework?** → L05: Frontier vs Open-Weight.

---

## 9. FAQ

**Q: How often do tier lists update?**
A: Most update monthly. Major releases (Opus 4.8, Fable 5, GPT 5.5) cause mid-cycle updates. Anything older than 3 months needs re-verification.

**Q: Can I trust a tier list from a YouTuber?**
A: Depends on whether they run real workloads. The channel's tier lists are grounded in Wildclaw Bench and real-task testing. Other creators vary. Look for transparent methodology.

**Q: What's the difference between S-tier and A-tier?**
A: S-tier is the top 1–3 models globally, usually the most expensive. A-tier is the top 5–10, usually the cost-tier sweet spot. For daily work, A-tier often handles 80% of use cases at 1/10th the price of S-tier.

**Q: Is Claude always the best?**
A: No. Claude Opus is consistently S-tier for coding and agentic workflows as of 2026. It's expensive and the channel has flagged billing-transparency concerns. For vision, multimodal, or cost-sensitive workloads, other models may be better.

**Q: Should I use the channel's tier list directly?**
A: It's a starting point. Cross-check with another independent source (FrontierCoding Diamond, Artificial Analysis). Run your own 1-hour test before committing.

**Q: What's the most underrated model in the channel's tier list?**
A: Per the source video, MiniMax and Kimi. Both are A-tier daily drivers with transparent pricing and good real-world performance. The channel's documented belief: "Practical, cost-efficient models like Kimi K2.7 and MiniMax M3 beat raw frontier capability for everyday use."

**Q: What about the cheapest models?**
A: Most cheap models are in C or D tier for serious work. The exception is the cost-efficient tier (covered in L04): Qwen, MiniMax, GLM. These are explicitly designed to be cheap AND capable.