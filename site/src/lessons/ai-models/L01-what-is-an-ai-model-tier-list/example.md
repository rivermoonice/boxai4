# L01 example — routing three workloads to three tiers

The smallest "do it" demo for [L01 — What Is an AI Model Tier List?](/lessons/ai-models/l01-what-is-an-ai-model-tier-list/).
Goal: take three real workloads you do this week, route each to the right tier, name a model,
estimate monthly cost in dollars.

No executable code — this is a worked walkthrough you pencil out on paper or in a text file.

## Inputs

Pick three workloads you do every week. To make this concrete, we'll use:

- **(a) Daily news summary** — summarise today's top 3 AI news stories each morning.
- **(b) Multi-file production refactor** — refactor the auth layer, write the migration, run tests, fix what breaks.
- **(c) Bulk extraction of 50K customer reviews** — pull sentiment + 3 key tags from each review, batch overnight.

## Workload × tier × model × cost

Route each workload to the cheapest tier that will handle it without burning your week on rework.

| Workload | Tier | Model | Volume | Cost |
|---|---|---|---|---|
| (a) Daily news summary | Tier 3 (Daily-Driver) | Kimi K2.7 or Qwen 3.5 | ~30 msgs/day | **~$2/month** |
| (b) Multi-file production refactor | Tier 2 (Frontier-Strong) | Sonnet 4.7 or GPT 5.4 or Gemini 3 Pro | ~5 sessions/week | **~$15/month** |
| (c) Bulk extraction of 50K customer reviews | Tier 4 (Cost-Efficient) | DeepSeek V4 Flash or GLM 5 or local 7B-20B | batch volume | **~$0.50/month** |

## Why each tier

**(a) Daily news summary → Tier 3.** Summarisation is well-defined: input is ~10 articles, output is 3 paragraphs. Tier 3 daily-driver models (Kimi K2.7, Qwen 3.5, MiniMax M3) hit 95% of frontier quality at 1/10th the price. At 30 msgs/day, monthly token spend is roughly 600K input + 300K output, which lands near $2/month on Qwen 3.5 pricing.

**(b) Multi-file production refactor → Tier 2.** Hard agentic coding — multi-file edits, test loops, recovery from broken builds — lives in Tier 2. Sonnet 4.7, GPT 5.4, and Gemini 3 Pro are within a few points of Tier 1 (Opus 4.8) on real coding benchmarks at 1/3 to 1/5 the cost. Tier 3 fails this roughly half the time; Tier 1 costs 3-5× more for a marginal quality bump. At ~5 sessions/week with ~2M tokens/session, monthly spend lands near $15/month on Sonnet 4.7 pricing.

**(c) Bulk extraction of 50K reviews → Tier 4.** Extraction is a high-volume, low-stakes-per-row task: 50K rows × ~500 input tokens + ~100 output tokens = ~30M tokens, all batchable. Tier 4 (DeepSeek V4 Flash, GLM 5, local 7B-20B) is built for this — "good enough" quality at a fraction of Tier 3 cost. If the reviews contain PII or trade secrets, run a local 7B-20B open-weight model so nothing leaves your laptop. At batch pricing on DeepSeek V4 Flash, total spend lands near $0.50/month.

## Total

Across all three workloads: **~$17.50/month.** The same three workloads run entirely on Tier 1 (Opus 4.8) would cost roughly $200-$400/month — a 12-20× premium for a 5% quality bump on the workloads that don't need it.

## What you proved

- **Tier routing beats tier shopping.** Pick by workload, not by leaderboard rank.
- **Daily-driver covers most of your week.** Tier 3 is the right default for ~80% of routine work.
- **Cost-efficient wins at volume.** Tier 4 is built for batch jobs and privacy-sensitive data, not peak quality.
- **Frontier is for the rare hard task.** Tier 1 is the right pick for novel architecture or research synthesis where "almost right" is unacceptable.

## Cleanup

No scripts to clean up — this is a paper exercise. File your tier routing under
`~/notes/ai-models/L01-routing.md` so you can compare against L05's decision framework later.