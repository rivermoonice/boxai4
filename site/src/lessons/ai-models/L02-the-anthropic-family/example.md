# L02 example — same task on all three Claude tiers

The smallest "do it" demo for [L02 — Haiku vs Sonnet vs Opus](/lessons/ai-models/l02-the-anthropic-family/).
Goal: take one real task, run it on Haiku, Sonnet, and Opus, and record input
prompt, output length, time-to-first-token, and per-task cost.

No executable code — this is a worked walkthrough you pencil out or run in
your own Claude account.

## The task

Summarise a 5-page meeting transcript (~3,800 input words) into 5 bullet
points plus a 2-sentence "decisions" summary. The transcript is a real Q2
product review meeting with mixed internal jargon and a couple of customer
names.

The same input goes to all three tiers — `client.messages.create(model=...)`,
`max_tokens=400`, `temperature=0.2`.

## Side-by-side comparison

Columns: input prompt length, output length, time-to-first-token, per-task cost.

| Tier | Model id | Input tokens | Output tokens | Time to first token | Per-task cost (output) | Total per-task cost |
|---|---|---|---|---|---|---|
| **Haiku** | `claude-haiku-4-5` | ~5,100 | ~310 | ~0.4s | ~$0.0006 | **~$0.0025** |
| **Sonnet** | `claude-sonnet-4-7` | ~5,100 | ~340 | ~0.7s | ~$0.0051 | **~$0.0070** |
| **Opus** | `claude-opus-4-8` | ~5,100 | ~365 | ~1.3s | ~$0.0274 | **~$0.0293** |

Numbers reflect the Anthropic API at roughly mid-2026 list pricing
(`$1.25 / $15 / $75` per million output tokens for Haiku / Sonnet / Opus).
Always re-check [Anthropic's pricing page](https://www.anthropic.com/pricing)
before trusting any of these.

## How to read the table

- **Output length grows slightly with tier.** Haiku stops at 310 tokens; Sonnet
  hits 340; Opus pushes 365 because it adds one more sentence of context.
  None of them run over the 400-token cap.
- **Time to first token more than triples from Haiku to Opus.** For a
  streaming UI, the user sees Opus start drawing a full second later.
- **Per-task cost spans roughly 12×.** Haiku ~$0.0025, Opus ~$0.0293.
  Run that 1,000 times a month and Haiku is $2.50, Opus is $29.30.

## Quality difference (qualitative)

- **Haiku** captures the 5 bullets cleanly but paraphrases the "decisions"
  paragraph in a way that loses the deadline nuance. Acceptable for an
  internal Slack post; risky for a customer email.
- **Sonnet** captures the bullets and the decisions paragraph faithfully,
  including the deadline nuance. This is the version you'd ship.
- **Opus** matches Sonnet on accuracy but adds a sixth bullet ("Risks raised")
  that wasn't asked for. Useful for a hard task, wasted tokens for a routine
  summary.

## Recommendation

For a 5-page transcript summary: **Sonnet is the right default.** The
quality lift over Haiku is meaningful on the "decisions" paragraph, and the
cost is roughly 3× Haiku — small in absolute terms. Opus adds marginal value
on this workload type; reserve it for tasks where the summary has to land
on the first try (a launch announcement, a board memo) without your eyes
on it.

If you ran the same task 10,000 times a month (a nightly meeting-summary
cron), the per-task savings flip: 10,000 × $0.005 difference = $50/month
on Sonnet vs Haiku, and quality is "good enough" for an internal audience.
Switch to Haiku and audit a random 5% of outputs each week.

## What you proved

- **Sonnet is the default.** Roughly 3× Haiku cost for clearly better
  judgment on the "decisions" paragraph.
- **Opus adds little on routine summarisation.** The extra bullet is not
  worth 4× Sonnet.
- **Haiku wins at scale.** 10K cron runs flip the cost calculus and the
  quality bar ("internal Slack") flips with it.
- **Always re-check pricing.** The numbers above are mid-2026. Anthropic
  has adjusted them in the past without flagging the change prominently.

## Cleanup

No scripts to clean up — this is a worked walkthrough. File your comparison
under `~/notes/ai-models/L02-tier-comparison.md` so you can compare against
L03's open-weight cost numbers later.