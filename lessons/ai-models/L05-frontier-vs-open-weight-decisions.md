# Frontier vs Open-Weight AI Models: How to Pick in 2026 (Decision Framework)

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

You've now learned about Claude (L02), Kimi and DeepSeek (L03), and Qwen / MiniMax / GLM (L04). You know the cost-efficient tier handles 80% of daily work for 1/5 to 1/20 the cost of frontier models. But you also know Claude Fable 5 has Mythos-class intelligence and Kimi needs `/swarm` to shine.

This capstone lesson synthesises everything into a single decision framework. By the end you'll be able to answer the question "frontier or open-weight?" for any workload, in any budget, with any tooling setup.

### Who this is for

A reader who has worked through L01–L04 and wants a single decision framework to apply.

### Who this is NOT for

Anyone who hasn't done L01–L04. This lesson assumes the previous context.

### What you'll be able to do

- Apply a single decision framework to pick the right model family for any workload.
- Estimate your realistic monthly cost across the three tiers.
- Recognise the trade-offs between cost, capability, and control.
- Recognise when to switch tiers mid-project.

### Learning Objectives

- Map a workload to a model family using the decision framework.
- Compare frontier and open-weight tiers on real criteria.
- Identify the trigger that should make you switch tiers.
- Articulate the channel's documented "pick by loop, not by model" belief.

### Time estimate**

10-minute read

### Prerequisites

- L01: What Is an AI Model Tier List?
- L02: The Anthropic Family
- L03: Chinese Open-Weight Models
- L04: Cost-Efficient Tier

### Why this matters in 2026

The channel's documented belief, captured across L02–L04 and the source video: "Pick by loop, not by model." This lesson is the synthesis of that belief into a single tool you can apply. The biggest mistake beginners make is picking a model based on marketing, popularity, or list price — instead of on workload, cost, and the harness they'll use.

---

## 2. Core Content

### Chapters

- `00:00` — The "pick by loop, not by model" principle
- `02:00` — The three tiers (frontier, cost-efficient, niche)
- `04:00` — The decision framework
- `06:30` — When to switch tiers mid-project
- `08:30` — Programmer vs Vibe Coder: the harness choice matters too

> 💡 **Ron's Pro Tip** — Pick the model based on the loop your workload runs in, not the model itself. Coding = different loop. Long-horizon agent = different loop. One-shot creative = different loop.

### Step 1 — The "pick by loop, not by model" principle

The source video on the harness vs model distinction makes a critical point: **a great model inside the wrong harness is still the wrong tool.** The same principle applies to tiers: a great frontier model for the wrong workload is still wasted money.

What this means in practice:

1. **Identify the loop.** Are you running a coding session, a long-horizon agent, or a one-shot creative prompt? Each loop has a different optimal model.
2. **Match the loop to a tier.** Coding = tiered routing. Long-horizon = Qwen or Hermes. One-shot creative = Opus or Fable 5.
3. **Test before committing.** Tier lists are starting points. Your loop may have specific needs.

> Source: `GGtmmx0MKCI` — "Use coding harnesses (Claude Code, Kilo Code) for any code-producing work; treat general agent harnesses (Hermes, OpenClaw) as long-running assistants that improve only with hundreds of hours of your own feedback. Pick by loop, not by model."

### Step 2 — The three tiers

Most models fall into one of three tiers:

**Tier 1 — Frontier (closed, expensive, capable).**
- Claude Opus 4.8, Claude Fable 5, GPT 5.5, Gemini 3.1 Pro
- Best for: hard reasoning, novel creative work, vision, the absolute hardest one-shots
- Cost: $80–$300/month at realistic usage
- Trade-off: high cost, vendor lock-in

**Tier 2 — Cost-efficient (open-weight or cheap closed, capable for everyday work).**
- Kimi K2.7, DeepSeek V4 Pro, Qwen 3.7 Max/Plus, MiniMax M3, GLM 5.2, Claude Sonnet 4.5
- Best for: 80% of daily work — UI, vision, code review, summarisation, agent workflows
- Cost: $5–$40/month
- Trade-off: trails frontier on hard reasoning, some have stability issues

**Tier 3 — Niche (specialised for one workload, may not generalise).**
- Sakana Fugu (orchestration), specific agent-tuned models
- Best for: one workload done exceptionally well
- Cost: variable
- Trade-off: don't generalise; pick only when the niche matches

The right move is usually: **Tier 2 by default, Tier 1 for hard work, Tier 3 only when the niche is exactly your workload.**

### Step 3 — The decision framework

Use this 5-question framework to pick the right tier for any workload:

**Q1: What's the workload?**
- Coding session → Tier 2 with tiered routing (Sonnet for default, Opus for hard)
- Long-horizon agent → Qwen 3.7 Max, MiniMax M3, or Kimi K2.7
- One-shot creative → Tier 1 (Opus 4.8 or Fable 5)
- Daily Q&A → Tier 2 (Claude Sonnet, Kimi K2.7, MiniMax M2.7)
- Multimodal → MiniMax M3 or Kimi K2.7
- UI generation → Kimi K2.7 or GLM 5.2
- Tool-call reasoning → DeepSeek V4 Pro

**Q2: What's your monthly budget?**
- Under $20/mo → Tier 2 only. Pick the cheapest that fits the workload.
- $20–$50/mo → Tier 2 plus occasional Tier 1 escalations.
- $50–$200/mo → Tier 1 default, Tier 2 fallback for routine work.
- Over $200/mo → Tier 1 by default. Use Claude Max or equivalent.

**Q3: How reproducible is the workload?**
- Highly reproducible (daily research summary) → Tier 2. Optimise for cost.
- Variable (depends on input) → Tier 1 or Tier 2 with tiered routing.
- One-off creative → Tier 1 for hard work.

**Q4: How time-sensitive is it?**
- Days to weeks → Tier 2. Take the cheap option.
- Hours → Tier 2 if the cheap option is fast enough (Qwen Max for speed).
- Minutes (one-shot) → Tier 1. Mythos-class intelligence matters.

**Q5: How much do you trust the harness?**
- Trusted harness (Claude Code, Hermes) → Tier 2 is safe; harness verifies.
- New or experimental harness → Tier 1 to be safe.

### Step 4 — When to switch tiers mid-project

Sometimes the trigger is clear:

**Switch from Tier 2 to Tier 1 when:**
- The Tier 2 model keeps failing on a specific task (3+ retries).
- The task escalates from routine to novel (you hit a wall).
- You're shipping production-critical work where reliability matters more than cost.

**Switch from Tier 1 to Tier 2 when:**
- You're spending $200+/mo on routine work.
- You realise the Tier 1 model isn't doing anything the Tier 2 can't.
- Your workload shifts from novel to routine.

**Switch within Tier 2 when:**
- The workload changes (e.g. from coding to UI to vision).
- A new release ships in another family that's better for your workload.
- Cost-tier specials become available (e.g. Qwen Plus at 40% off Max).

### Step 5 — Programmer vs Vibe Coder: the harness choice matters too

The source video `0_87ZfF44dk` ("Programmer vs Vibe Coder: The Real Way to Build with AI") makes an important point that ties tier choice to harness choice: **a programmer using a vibe coder's tools is fighting the tool. A vibe coder using a programmer's tools is fighting the tool.**

In practice this means:
- If you're shipping production code → use a coding harness (Claude Code, Kilo Code) with a Tier 1 model for hard work and Tier 2 for routine.
- If you're automating research / Q&A / daily tasks → use an agent harness (Hermes, OpenClaw) with a Tier 2 cost-efficient model.
- If you're doing one-off creative work → Tier 1 model in a chat interface (ChatGPT, Claude.ai).

The mistake is mixing: trying to ship production code in an agent harness, or trying to automate daily tasks in a coding harness. Both work, but neither is optimal.

> Source: `0_87ZfF44dk` — "Vibe coding with intent-free prompts burns tokens and breaks on drag-handlers. Draw a PRD, pick a model per task, and review code before shipping."

---

## 3. Comparison & Decision Framework

This lesson IS the decision framework. The table below maps workloads to recommended tiers.

| Workload | Recommended tier | Default model | Upgrade trigger |
|---|---|---|---|
| Daily Q&A | Tier 2 | Claude Sonnet 4.5 / Kimi K2.7 | Hit 3+ retries → Opus 4.8 |
| Daily research summary (cron) | Tier 2 | DeepSeek V4 Flash or Kimi K2.7 | Almost never — keep cheap |
| Coding all day (production) | Tier 1 + Tier 2 | Sonnet default, Opus hard | Hit Opus ceiling → Fable 5 |
| Long-horizon agent (hours) | Tier 2 | Qwen 3.7 Max or MiniMax M3 | Hit tool-call failures → Opus |
| One-shot creative | Tier 1 | Claude Opus 4.8 | Hit Opus ceiling → Fable 5 |
| UI generation | Tier 2 | Kimi K2.7 or GLM 5.2 | GLM is unstable — fall back to Kimi |
| Vision / multimodal | Tier 2 | MiniMax M3 or Kimi K2.7 | Heavy reasoning → Opus |
| Crypto / finance | Tier 2 | Kimi K2.7 | Almost never — Kimi wins |
| Tool-call reasoning | Tier 2 | DeepSeek V4 Pro | Almost never — DeepSeek wins |

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Picking frontier "because it's the best"

- **Symptom:** You pick Claude Opus for everything and your monthly bill is $300.
- **Cause:** Tier 1 is the "best" by capability, but not by workload fit.
- **Fix:** Default to Tier 2. Upgrade to Tier 1 only when the workload demands it.

### Pitfall 2 — Assuming open-weight means free

- **Symptom:** You start using open-weight APIs and discover you still pay for tokens.
- **Cause:** "Open-weight" means downloadable, not free to run.
- **Fix:** Pay-as-you-go API. $5 starter is enough for most beginners.

### Pitfall 3 — Ignoring the harness choice

- **Symptom:** You pick the perfect Tier 1 model but use it in the wrong harness (or vice versa).
- **Cause:** The source video's main point: "pick by loop, not by model."
- **Fix:** Match the harness to the workload AND the model to the harness.

### Pitfall 4 — Comparing models on synthetic benchmarks

- **Symptom:** You pick a model because SWE-bench Pro says it's the best.
- **Cause:** The channel flags SWE-bench Pro as cherry-picked.
- **Fix:** Trust FrontierCoding Diamond, Artificial Analysis, hands-on real-task tests.

### Pitfall 5 — Switching tiers too often

- **Symptom:** You switch models weekly chasing the latest tier list.
- **Cause:** Model market moves fast. New releases ship every few weeks.
- **Fix:** Pick a tier (not a specific model) and stick for at least a quarter.

### Pitfall 6 — Treating all "cost-efficient" models as interchangeable

- **Symptom:** You assume Kimi, DeepSeek, Qwen, MiniMax, GLM are all the same.
- **Cause:** They're all in the cost tier but have different strengths.
- **Fix:** Match each family to its best workload (covered in L03 and L04).

### Pitfall 7 — Ignoring workload-specific strengths

- **Symptom:** You pick a Tier 2 model that's strong overall but weak on your specific workload.
- **Cause:** Tier 2 models are specialists, not generalists.
- **Fix:** Use the table above. Match workload to model.

### Pitfall 8 — Picking by popularity or marketing

- **Symptom:** You use Claude because it's the most popular, not because it fits your workload.
- **Cause:** Marketing and Twitter hype.
- **Fix:** Apply the decision framework. Run your own test.

### Pitfall 9 — Assuming Fable 5 is always better than Opus

- **Symptom:** You use Fable 5 for everything because it's Mythos-class.
- **Cause:** Fable 5 is mythos-class but expensive. Daily work doesn't need it.
- **Fix:** Fable 5 for one-shots that need it. Opus 4.8 for daily.

### Pitfall 10 — Forgetting to revisit the decision quarterly

- **Symptom:** You pick a model in March and never re-evaluate, even after major releases.
- **Cause:** Quarterly review is the channel's recommendation.
- **Fix:** Set a calendar reminder every 90 days. Re-run the framework.

---

## 5. Key Takeaways & Ron's Bottom Line

- Pick by loop, not by model. Match the model to the workload, not to the marketing.
- Three tiers: frontier (Tier 1, $80–$300/mo), cost-efficient (Tier 2, $5–$40/mo), niche (Tier 3, specialised).
- Default to Tier 2. Upgrade to Tier 1 only when the workload demands it.
- Tier 2 has specialists — Kimi for UI, DeepSeek for tool-call reasoning, Qwen for long-horizon, MiniMax for multimodal, GLM for front-end design.
- The harness choice matters as much as the model choice. Match both to the workload.
- Trust real-task tests and FrontierCoding Diamond. Don't trust SWE-bench Pro.
- Re-evaluate quarterly. Model market moves fast.
- "Practical, cost-efficient models like Kimi K2.7 and MiniMax M3 beat raw frontier capability for everyday use." — `Specs/ChannelIdentity.md`
- "Pick by loop, not by model." — channel's documented belief

> 🟦 **Ron's Bottom Line** — Default to Tier 2. Pick the specialist that matches your workload. Upgrade to Tier 1 only when Tier 2 keeps failing. Don't switch tiers weekly — pick a tier and stick for a quarter. And remember: the harness choice matters as much as the model choice. Match both to the workload.

---

## 6. Hands-On Practice

### Exercise

**Task:** Apply the decision framework to your three most common AI workloads. For each, identify the recommended tier, the default model, and the upgrade trigger.

**Success criteria:** You can name three workloads, three tiers, three default models, and three upgrade triggers.

### Do this today

- [ ] Identify your three most common AI workloads this week.
- [ ] For each, decide: Tier 1, Tier 2, or Tier 3?
- [ ] Pick a default model for each.
- [ ] Set upgrade triggers (e.g. "3+ retries on a coding task").
- [ ] Run your workloads on the recommended models for one week.
- [ ] Note your total cost and total wall-clock time.
- [ ] Adjust if the framework predicted wrong.

### What's next

You've completed the AI model comparison module. 🎉

- **Other modules** — Hermes module (already drafted), New AI projects module (next).
- **Backlog** — possible L06: "New AI Projects" if you want a sixth lesson.
- **Cross-reference** — apply this framework alongside the Hermes module's L06 (tiered routing).

> 💬 Drop your tier-by-workload decision in the Discord. Compare with other learners.

---

## 7. Self-Check / Mini-Quiz

**Q1.** Per the channel, you should pick a model by:
- A) Price
- B) Marketing
- C) The loop your workload runs in
- D) The most popular model

**Q2.** Short answer: What does "pick by loop, not by model" mean?

**Q3.** For coding all day, the channel's recommended tier is:
- A) Tier 1 only
- B) Tier 2 only
- C) Tier 1 + Tier 2 with tiered routing
- D) Tier 3 only

**Q4.** Short answer: Name one benchmark the channel flags as unreliable.

**Q5.** Multiple choice: The biggest mistake beginners make when choosing tiers is:
- A) Picking the cheapest tier
- B) Picking the most popular model
- C) Picking by marketing or popularity instead of workload fit
- D) Avoiding frontier models entirely

**Q6.** Short answer: What's the channel's recommendation for how often to re-evaluate your tier choice?

### Answers

**A1.** C — The loop your workload runs in. Per the channel: "Pick by loop, not by model."

**A2.** The model matters less than the workflow it runs in. A great model in the wrong harness (or for the wrong workload) is still the wrong tool. Match the model to the loop, not to the marketing.

**A3.** C — Tier 1 + Tier 2 with tiered routing. Sonnet for default, Opus for hard. Tier 1 alone is too expensive for daily work; Tier 2 alone may not handle the hardest tasks.

**A4.** SWE-bench Pro. Per `Specs/ChannelIdentity.md`: "Frontier evals like SWE-bench Pro are unreliable/cherry-picked."

**A5.** C — Picking by marketing or popularity instead of workload fit. The channel's documented bet is to pick by loop, not by hype.

**A6.** Quarterly. The channel's spec recommends re-evaluating major lessons quarterly or when tools change significantly.

**Scoring:** 5–6 correct → you've completed the AI model comparison module. 3–4 → re-read Steps 1–3. 0–2 → restart from L01.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Primary video** — `Programmer vs Vibe Coder: The Real Way to Build with AI` (`0_87ZfF44dk`, 2019s, April 2026). The decision framework's programmer-vs-vibe-coder framing comes from this video.
- **Harness vs model framing** — `Agent Harness vs Coding Harness (Know the Difference)` (`GGtmmx0MKCI`, 790s, May 2026). The "pick by loop, not by model" belief comes from this video. (Also used in L01 of the Hermes module.)
- **Channel beliefs** — `Specs/ChannelIdentity.md` in this repo.

### Glossary

- **Frontier model** — the most capable AI model from a major lab (Claude Opus, GPT 5.5, Gemini 3.1 Pro).
- **Open-weight model** — a model whose trained parameters are publicly downloadable.
- **Tier 1 / Tier 2 / Tier 3** — the three tiers used in this lesson: frontier, cost-efficient, niche.
- **Pick by loop, not by model** — the channel's documented belief. Match the model to the workload, not the marketing.
- **SWE-bench Pro** — coding benchmark. The channel flags it as cherry-picked and unreliable.
- **FrontierCoding Diamond** — coding benchmark the channel trusts.
- **Artificial Analysis** — independent model-evaluation site the channel trusts.
- **Tiered routing** — using the right model for the right task. Tier 2 default, Tier 1 for hard work.
- **Harness** — the program that wraps an AI model. Coding harness vs agent harness.
- **Long-horizon workflow** — agent tasks that run for hours.
- **One-shot** — completing a task in a single attempt without iteration.
- **Multimodal** — handling multiple input/output types (text, image, video).

### Go deeper

- **Want to learn about Claude specifically?** → L02: The Anthropic Family.
- **Want to understand Chinese open-weight?** → L03: Kimi and DeepSeek.
- **Want the cost-efficient tier?** → L04: Qwen, MiniMax, GLM.
- **Want to set up tiered routing in Hermes?** → Hermes module L06.

---

## 9. FAQ

**Q: I'm a complete beginner. Which tier should I start with?**
A: Tier 2. Pick the cost-efficient model that matches your workload (Kimi for daily Q&A, DeepSeek for tool-call reasoning, Qwen Plus for coding). Upgrade to Tier 1 when Tier 2 keeps failing.

**Q: Can I run more than one tier at the same time?**
A: Yes — that's tiered routing. Most power users default to Tier 2 and escalate to Tier 1 for hard work.

**Q: What's the cheapest tier 2 setup that actually works?**
A: DeepSeek V4 Pro or Kimi K2.7 base plan. ~$5–$15/mo at realistic beginner usage.

**Q: Is Claude worth $200/month for the Max plan?**
A: Only if you've confirmed you use Opus-level capability regularly. Most beginners should start with pay-as-you-go API access.

**Q: How often should I re-evaluate my tier choice?**
A: Quarterly, or when a major model release ships. Tier lists go stale fast.

**Q: What's the harness choice in this framework?**
A: As important as the model choice. Match the harness to the workload: coding harness for production code, agent harness for long-running automation, chat interface for one-shots.

**Q: What if my workload doesn't fit any tier?**
A: Run a representative task on Tier 2 candidates. If none work, escalate to Tier 1. If Tier 1 doesn't work either, the workload may need a Tier 3 specialist or a custom solution.

**Q: Will the cost-tier models keep getting better?**
A: Yes. The channel's documented belief is that Chinese open-weight models are "the practical benchmark that Western frontier models must clear." Expect cost-tier capability to keep improving.