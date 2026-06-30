# L03 example — DeepSeek V4 Pro vs Kimi K2.7 on one task

The smallest "do it" demo for [L03 — Chinese Open-Weight Models in 2026](/lessons/ai-models/l03-chinese-open-weight/).
Goal: take one real task, run it on DeepSeek V4 Pro and Kimi K2.7, and record
prompt, output snippet, latency, cost, and a recommendation.

No executable code — this is a worked walkthrough you pencil out or run in
your own accounts. Use both labs' hosted APIs, or point Hermes
([hermes/L02](/lessons/hermes/l02-install-and-first-run/)) at each in turn.

## The task

> "Build me a small dashboard from this CSV."
>
> Attachment: `sales-2025-q4.csv` — 1,200 rows of daily sales across 8 product
> lines, 2 regions, with a few thousand nulls in `promo_code`.

Constraints: one-shot, no follow-ups. Output: a single-page HTML dashboard
with a header, 4 KPI tiles, one line chart, one stacked bar chart, and a
table of the bottom 10 SKUs.

## Side-by-side comparison

Columns: prompt length, output snippet, latency, cost, recommendation.

| Lab | Model id | Input tokens | Output tokens | Latency to first byte | Total per-task cost | Quality note |
|---|---|---|---|---|---|---|
| **DeepSeek V4 Pro** | `deepseek-v4-pro` | ~6,400 | ~2,900 | ~0.8s | **~$0.012** | Charts correct, but layout is plain — looks like 2014 Bootstrap |
| **Kimi K2.7** | `kimi-k2.7` | ~6,400 | ~3,100 | ~1.1s | **~$0.014** | Charts correct, layout is polished — Tailwind grid, modern type, dark-mode ready |

Both models produced working HTML. The difference is in the design bar, not
the logic. Numbers reflect mid-2026 list pricing on each lab's hosted API
(DeepSeek V4 Pro ~$4 / 1M output tokens, Kimi K2.7 ~$4.50 / 1M output tokens).
Always re-check each lab's pricing page before trusting any of these.

## Sample output (excerpts)

**DeepSeek V4 Pro — opening HTML:**

```html
<table border="1">
  <tr><th>Product</th><th>Revenue</th></tr>
  <tr><td>Alpha</td><td>12345</td></tr>
  ...
```

Charts render as inline SVG; the styling uses default browser fonts and
no responsive grid. Works on desktop; cramped on mobile.

**Kimi K2.7 — opening HTML:**

```html
<div class="grid grid-cols-1 md:grid-cols-4 gap-4">
  <div class="kpi-tile">
    <span class="kpi-label">Total Revenue</span>
    <span class="kpi-value">$1.2M</span>
    <span class="kpi-delta">+12% QoQ</span>
  </div>
  ...
```

Charts render via a chart library hook (`<canvas id="revenue-trend">` with
a small inline JS initialiser). Layout is responsive out of the box.

## How to read the comparison

- **Output length is similar** (~2,900 vs ~3,100 tokens). Kimi spends a few
  hundred extra tokens on CSS class names and the chart init script.
- **Latency is similar** (~0.8s vs ~1.1s to first byte). Both are streaming,
  so the user sees the page draw in real time.
- **Cost is similar** (~$0.012 vs ~$0.014 per task). At 100 dashboards a
  month, the spread is roughly $0.20.
- **Quality diverges on the design bar.** Kimi ships a layout you'd actually
  paste into production; DeepSeek ships a layout you'd hand to a designer.

## Quality difference (qualitative)

- **DeepSeek V4 Pro** nailed the data: correct totals, correct chart
  series, correct "bottom 10 SKUs" sort. The HTML is functional but
  visually flat. If you're piping the output into a downstream system
  (PDF render, email body, internal report), the styling is irrelevant and
  DeepSeek is the better pick.
- **Kimi K2.7** nailed both the data and the design. The KPI tiles, the
  chart axes, the responsive grid — all sensible. If a human is going to
  look at the dashboard without re-styling it, Kimi is the better pick.
- **Neither** asked a clarifying question about the `promo_code` nulls.
  Both imputed zeros silently. For a real dashboard you'd add a step that
  flags rows with nulls in the output.

## Recommendation

For "build me a small dashboard from this CSV": **pick by audience.**

- If the dashboard is for an internal Slack post or a one-shot PDF, use
  **DeepSeek V4 Pro**. The data is correct, the cost is lower, and the
  styling doesn't matter.
- If the dashboard is going to a customer, an exec, or a public page,
  use **Kimi K2.7**. The design bar is the difference between "draft" and
  "ship-ready."

If you ran the same prompt 1,000 times a month (a nightly analytics
cron), DeepSeek wins on cost and the design bar matters less because no
human looks at every render — flip the default.

## What you proved

- **The labs are not interchangeable.** Same input, two different design
  bars. Picking by leaderboard rank would have missed the actual difference.
- **Cost is roughly equivalent on this workload.** ~$0.012 vs ~$0.014. The
  choice is about quality, not price.
- **Match the lab to the workload.** UI generation → Kimi. Data plumbing
  → DeepSeek. The lesson's mental model holds.
- **Always re-check pricing.** Mid-2026 numbers. Each lab has adjusted in
  the past without a prominent flag.

## Cleanup

No scripts to clean up — this is a worked walkthrough. File your
comparison under `~/notes/ai-models/L03-deepseek-vs-kimi.md` so you can
compare against L05's decision framework later.
