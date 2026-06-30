# L05 example — apply the 5-question decision tree to one real workload

The smallest "do it" demo for [L05 — Frontier vs Open-Weight AI Models](/lessons/ai-models/l05-frontier-vs-open-weight-decisions/).
Goal: take one real workload, run the five questions in order, pick a tier, set an escalation trigger, and sketch a routing pattern.

## The workload

**"Ship a multi-tenant billing flow"** — a real engineering task that mixes routine coding with hard sub-tasks. It is a good test case because it is neither pure one-shot creative work nor pure mechanical refactor. It lives in the messy middle.

## Step 1 — Q1: What loop does the workload run in?

The loop is **coding all day in production** — interactive, test-verified, multi-turn. The harness is Claude Code (or another coding harness) that runs the test suite after each edit. That makes the loop "coding" per the Q1 table, not "one-shot creative."

| Loop | Tier | Model |
|---|---|---|
| One-shot creative / novel spec | Tier 1 | Opus 4.8 or Fable 5 |
| Daily Q&A, summarisation | Tier 2 | Sonnet 4.5 or Kimi K2.7 |
| **Coding all day (production)** | **Tiered** | **Sonnet default, Opus on hard tasks** |
| Long-horizon agent (hours) | Tier 2 + agent harness | Qwen 3.7 Max or MiniMax M3 |
| Multimodal (vision / UI / images) | Tier 2 specialist | MiniMax M3 or Kimi K2.7 |

**Pick: Tiered routing (Sonnet 4.5 default, Opus 4.8 for hard sub-tasks).**

## Step 2 — Q2: What's your monthly budget?

Budget: **$50/month.** That lands in the $20–$50–$200 band — Tier 2 default plus Tier 1 escalations are affordable. Pure Tier 1 (Opus for every edit) would burn through $200+ in days. Pure Tier 2 risks hitting hard sub-tasks that a small model cannot finish.

**Pick: Tier 2 default with Tier 1 escalations on the hardest 10–20% of sub-tasks.**

## Step 3 — Q3: How reproducible is the workload?

The workload is **reproducible in shape** (every multi-tenant feature follows a similar pattern: schema, RLS, audit log, tests) but **variable in detail** (each tenant has unique fields, edge cases, integration quirks). The "shape is reproducible, detail is variable" combination is the textbook trigger for tiered routing.

**Pick: Tiered routing — Tier 2 for the reproducible 80%, Tier 1 for the variable 20%.**

## Step 4 — Q4: How time-sensitive is it?

Time budget: **days, not hours.** Two weeks of iteration before ship. A coding harness verifies each edit, so even when Sonnet misses an edge case, the test suite catches it and the next retry usually fixes it. The deadline is not a same-day one-shot, so Tier 1 is not required for raw intelligence.

**Pick: Tier 2 by default; escalate to Tier 1 only when retries pile up.**

## Step 5 — Q5: How much do you trust the harness?

Harness: **Claude Code.** This is the most-trusted coding harness in 2026 — it runs the test suite after every edit, catches regressions, and refuses to merge broken code. Trust level is high. Tier 2 mistakes get caught by verification, so the Tier 1 insurance premium is not needed on every call.

**Pick: Tier 2 as the safe default; Tier 1 only when Q1–Q4 say you need it.**

## Final tier pick

**Tiered routing:**
- Sonnet 4.5 handles 80% of routine work (schema migrations, test scaffolding, RLS policies, billing webhook handlers).
- Opus 4.8 handles the 20% of sub-tasks where Sonnet failed twice in a row, the spec is ambiguous, or the change touches money (refund logic, proration, tax).

## Escalation trigger

**3+ retries on the same prompt → escalate to Opus.** This is concrete and countable. The first retry is on Sonnet (cheap, fast). The second retry is still on Sonnet (sometimes a different prompt angle fixes it). After the third failure, switch the harness to Opus for that sub-task and ship. After Opus succeeds, drop back to Sonnet for the next sub-task.

## Routing-pattern sketch

```
Tiered routing: Sonnet 80% / Opus 20%

Routine sub-tasks (Sonnet 4.5, ~80% of work):
- Schema migrations
- Test scaffolding
- RLS policy boilerplate
- Webhook handler boilerplate

Hard sub-tasks (Opus 4.8, ~20% of work):
- Refund / proration / tax logic
- Ambiguous spec translation
- Anything that failed 3+ times on Sonnet
```

## Expected cost

- Sonnet 4.5 at $3 input / $15 output per million tokens: ~30M tokens/month on routine work = **$30–$50/month**.
- Opus 4.8 at $15 input / $75 output per million tokens: ~1M tokens/month on hard sub-tasks = **$15–$30/month**.
- **Total: $45–$80/month.** Inside the $50/month budget band, with headroom for the occasional Opus escalation spike.

## What would change the pick

- Budget drops to $20/month: switch to Kimi K2.7 for the routine 80% and drop Opus entirely.
- Budget jumps to $200/month: switch to Opus for the routine 80% and skip Sonnet.
- Deadline moves to "ship tomorrow": switch to Opus 4.8 for everything; lose the savings, gain the speed.
- Harness becomes unknown / unverified: switch to Opus for the routine 80% as insurance (Q5 flips the default).
- Workload becomes one-shot creative (pitch deck, novel spec): switch to Tier 1 Opus for the entire task.

This is the decision tree in action. Five questions, one workload, one tier pick, one trigger, one routing pattern.
