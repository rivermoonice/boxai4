# How to Use Claude Code for Beginners in 2026 (Step-by-Step Coding Workflow)

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

You've written code. You've used ChatGPT to debug it. But you've never used a **coding harness** — a dedicated AI agent that lives inside your project, reads every file, runs tests, and iterates until the work is done.

Two tools dominate this space in 2026: **Claude Code** (Anthropic's paid, polished harness) and **Kilo Code** (open-source, free tier, BYOK). They're not chat interfaces. They're coding teammates.

In this lesson you'll learn what a coding harness actually is, how to set one up, and how to use the loop pattern that separates real shipping from vibe coding.

### Who this is for

A reader who has used AI for code but never used a coding harness. Has a project (even a simple one) to apply the lesson to. Comfortable with a terminal.

### Who this is NOT for

Anyone who already runs Claude Code or Kilo Code in production. This is the beginner intro.

### What you'll be able to do

- Explain what a coding harness is and how it differs from a chat interface.
- Set up Claude Code (or Kilo Code) for a new project.
- Use the loop pattern to ship a small feature.

### Learning Objectives

- Describe the Claude Code daily workflow.
- Set up Claude Code for a new project.
- Use the loop pattern to ship a small feature.
- Recognise when to use a coding harness vs an agent harness (Hermes).

### Time estimate

12-minute read + 30-minute hands-on

### Prerequisites

- Comfortable running commands in a terminal.
- Have a real project (even a simple one) to apply the lesson to.
- A code editor installed (VS Code recommended).

### Why this matters in 2026

The channel's documented belief: "Loop-based agent workflows with validation harnesses (Playwright/Puppeteer checklists) are the new default for shipping with agents, replacing saved prompt lists." Coding harnesses are the practical realisation of this belief. They run the test suite. They iterate until the suite passes. They catch errors that prompt lists miss.

For a beginner who wants to ship real software in 2026, learning a coding harness is one of the highest-leverage skills you can develop.

---

## 2. Core Content

### Chapters

- `00:00` — What a coding harness actually does
- `02:00` — Claude Code vs Kilo Code vs Cursor
- `04:00` — The daily workflow
- `06:00` — The loop pattern
- `08:00` — Bringing your own model (BYOK)
- `10:00` — When to use Claude Code vs Hermes

> 💡 **Ron's Pro Tip** — Start with Kilo Code + a cheap MiniMax key. The free tier lets you learn the patterns before committing to a $200/mo Max plan.

### Step 1 — What a coding harness actually does

A coding harness is a dedicated AI agent that:
- **Reads your entire project.** It understands your codebase structure, not just the file you pasted.
- **Runs commands.** It can execute tests, build scripts, linters — anything you can run in a terminal.
- **Verifies by running tests.** Unlike a chat interface, it actually checks if the code works.
- **Iterates.** When a test fails, it tries to fix the code and re-runs the test. Loop until success.

This is fundamentally different from "paste code into ChatGPT and ask for help." The harness has full project context. It runs code. It tests. It's a teammate, not a chatbot.

> Source: `cwpykYGbICc` — "Kilo code provides you with basically a bunch of free tools you can use. And the best part is that you can bring your own model inside. … It's kind of like talking to your agent but because it's focused on coding it doesn't get distracted by everything else."

### Step 2 — Claude Code vs Kilo Code vs Cursor

Three coding harnesses matter in 2026:

**Claude Code** — Anthropic's polished harness. Best-in-class for hard problems. Tied to Anthropic's plan ($20/mo Pro, $200/mo Max). Closed-source.

**Kilo Code** — open-source alternative. Free tier available. BYOK (bring your own model key). 1.5M users per the source. Best for daily maintenance and incremental feature work.

**Cursor** — IDE-integrated. Best for visual coding workflows. Cursor has its own agent mode but isn't a pure coding harness.

> Source: `cwpykYGbICc` — "Claude Code is really really good at tackling really big problems. So if you're starting a new project out, you need to fix the stuff that the agent didn't do very well. … But if you're on a day-to-day maintenance or developing a minor feature or even a major feature, that's where Kilo Code shines."

**Decision guide:**
- **Big new project, hard refactor** → Claude Code.
- **Daily maintenance, incremental work** → Kilo Code.
- **Visual / IDE-integrated workflow** → Cursor with agent mode.

### Step 3 — The daily workflow

A typical Claude Code / Kilo Code session looks like:

1. **Open the harness in your project's root directory.** It scans the codebase automatically.
2. **Ask a specific question or give a specific task.** "What does this function do?" or "Refactor this file to use async/await."
3. **Watch it work.** The harness reads files, runs commands, and proposes changes. It shows you the diff before applying.
4. **Review the changes.** Don't blindly accept. Read the diff. Run the tests yourself.
5. **Iterate.** If the change isn't right, push back. "That breaks the test on line 47. Fix it."
6. **Commit when ready.** Use the harness to commit, or commit manually.

The key difference from chat interfaces: **step 4 is critical.** A coding harness proposes changes. You review them. You're the engineer; the harness is the implementer.

### Step 4 — The loop pattern

The loop is what makes coding harnesses different from prompt lists. The pattern:

1. Harness writes code.
2. Harness runs the test suite.
3. If tests fail, harness reads the error, fixes the code, re-runs.
4. Loop until tests pass.
5. Harness reports back.

This is the "loop until done" pattern the channel documents in `Specs/ChannelIdentity.md`. The harness handles the iteration. You set the success criteria.

> Source: `Specs/ChannelIdentity.md` — "Loop-based agent workflows with validation harnesses (Playwright/Puppeteer checklists) are the new default for shipping with agents, replacing saved prompt lists."

For web apps, the validation harness is usually a Playwright or Puppeteer checklist that clicks through the UI and asserts expected behaviour. For backend code, it's the unit test suite. For data pipelines, it's the schema validator.

### Step 5 — Bringing your own model (BYOK)

Kilo Code supports BYOK. You bring your own API key (MiniMax, Kimi, DeepSeek, Claude, etc.) and use it inside the harness.

**Why BYOK matters:**
- **Cost.** Kilo Code + MiniMax key = ~$15–$30/mo at realistic beginner usage. Claude Code Max = $200/mo.
- **Privacy.** Your code doesn't go to a third party (the model provider sees it, but the harness vendor doesn't store it).
- **Choice.** Use the model that fits the workload. MiniMax for daily. Opus for hard.

> Source: `cwpykYGbICc` — "I brought my own MiniMax 2.7 key inside. I can start using this at full power, but at the same time, I'm not, you know, spending bajillions of dollars."

**How to set up BYOK in Kilo Code:**
1. Sign up for your chosen model provider (MiniMax is a good default per L04 of the AI model comparison module).
2. Get an API key.
3. In Kilo Code, go to model settings and paste your key.
4. Pick the model.
5. Done. You pay the model provider per token.

### Step 6 — When to use Claude Code vs Hermes

The distinction is critical:

| Workload | Use | Why |
|---|---|---|
| Shipping production software | Claude Code / Kilo Code | Coding harness, test verification |
| Daily research summary | Hermes | Agent harness, multi-channel |
| Cron job at 6am | Hermes | Long-running automation |
| One-shot creative writing | Chat interface | Direct model access |
| Coding all day | Claude Code | Polished harness |
| Automating daily work | Hermes | Agent harness |

The channel's documented belief: "Use coding harnesses (Claude Code, Kilo Code) for any code-producing work; treat general agent harnesses (Hermes, OpenClaw) as long-running assistants." Pick the harness based on the workload.

---

## 3. Comparison & Decision Framework

| Dimension | Claude Code | Kilo Code | Cursor (with agent mode) |
|---|---|---|---|
| Pricing | $20–$200/mo | Free + BYOK | $20/mo |
| Best for | Hard problems, big refactors | Daily maintenance, incremental | Visual coding |
| Open source | No | Yes | No |
| BYOK | No | Yes | Yes |
| 1M user base | Yes | Yes | Yes |
| Test loop | Yes | Yes | Partial |
| Beginner-friendly | Moderate | Easier (free tier) | Easy (IDE) |

**Decision guide:**
- **Total beginner on a budget** → Kilo Code + MiniMax key.
- **Beginner with budget** → Claude Code Pro ($20/mo) + Kilo Code for daily.
- **Production-grade shipping** → Claude Code Max + Kilo Code for daily.
- **Visual / IDE workflow** → Cursor with agent mode.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Treating the harness like a chatbot

- **Symptom:** You paste code into Claude Code and ask "what does this do?" without giving it project context.
- **Cause:** Beginners default to chat-mode behaviour.
- **Fix:** Open Claude Code in your project root. Let it scan the codebase before asking.

### Pitfall 2 — Skipping the review step

- **Symptom:** You accept the harness's diff without reading it. Production breaks.
- **Cause:** Beginners trust the AI blindly.
- **Fix:** Always read the diff. Always run the tests yourself.

### Pitfall 3 — Burning through the Max plan

- **Symptom:** Your $200/mo Max plan is gone in two weeks.
- **Cause:** Heavy usage + Opus pricing + no daily limit set.
- **Fix:** Set a hard monthly cap in Anthropic's dashboard. Use Sonnet by default. Opus only for hard work.

### Pitfall 4 — Using Claude Code for non-coding tasks

- **Symptom:** You're running Claude Code to research topics or write blog posts.
- **Cause:** Beginners assume "AI coding harness" means "AI for anything."
- **Fix:** Use an agent harness (Hermes) for non-coding work. Use a chat interface for one-shots.

### Pitfall 5 — Expecting one-shot perfection

- **Symptom:** You give the harness a vague prompt and expect shipping-ready code on the first try.
- **Cause:** Beginners confuse "AI coding" with "magic."
- **Fix:** Iterate. The loop is the point. Expect 2–5 iterations for non-trivial work.

### Pitfall 6 — Not setting up project structure

- **Symptom:** The harness makes changes that conflict with your existing code.
- **Cause:** You didn't set up clear project structure, conventions, or testing.
- **Fix:** Define conventions upfront. Use `agents.md` for project context. Have a test suite the harness can run.

### Pitfall 7 — Ignoring the cost-tier alternative

- **Symptom:** You're paying $200/mo for Claude Max when Kilo Code + MiniMax at $15–$30/mo would do the same job.
- **Cause:** Beginners default to the most-expensive option.
- **Fix:** Per the AI model comparison module's L04, Tier 2 (cost-efficient) handles 80% of daily work. Try it before committing to Tier 1.

### Pitfall 8 — Picking Cursor when you need a real coding harness

- **Symptom:** Cursor's agent mode "kind of works" but doesn't iterate well.
- **Cause:** Cursor is primarily an IDE with an agent add-on. Claude Code / Kilo Code are dedicated harnesses.
- **Fix:** Use Cursor for visual coding. Use Claude Code / Kilo Code for serious work.

---

## 5. Key Takeaways & Ron's Bottom Line

- A coding harness reads your project, runs commands, verifies by testing, iterates until done. It's not a chatbot.
- Three coding harnesses matter in 2026: Claude Code (paid, polished), Kilo Code (open-source, BYOK), Cursor (IDE-integrated).
- The loop pattern is the differentiator. Harness writes code → runs tests → fixes → re-runs. Loop until tests pass.
- BYOK with Kilo Code + MiniMax = $15–$30/mo. Cheaper than Claude Max for similar daily-work capability.
- Set a hard monthly cap. Default to Tier 2 (cost-efficient). Upgrade to Tier 1 (Opus) only for hard work.
- Always review the diff. Always run the tests yourself. The harness proposes; you decide.
- "Loop-based agent workflows with validation harnesses (Playwright/Puppeteer checklists) are the new default for shipping with agents, replacing saved prompt lists." — `Specs/ChannelIdentity.md`

> 🟦 **Ron's Bottom Line** — Start with Kilo Code + a MiniMax key. Learn the loop pattern. Iterate. Move to Claude Code when you hit a wall that needs Opus. Don't pay $200/mo before you've earned it. The loop is the lesson, not the brand.

---

## 6. Hands-On Practice

### Exercise

**Task:** Set up Kilo Code with a MiniMax API key. Use it to fix one real bug in a project you own. Verify the fix by running the test suite.

**Success criteria:** The bug is fixed. The test suite passes. You can articulate the loop you used (write → test → fail → fix → re-run → pass).

### Do this today

- [ ] Install Kilo Code.
- [ ] Sign up for MiniMax API access ($5 starter).
- [ ] Connect MiniMax as your default model in Kilo Code.
- [ ] Pick a small bug in a real project (or a TODO comment you never finished).
- [ ] Run the loop: harness writes → harness tests → fix → re-run.
- [ ] Document the loop in a note for future reference.
- [ ] Set a hard monthly cap in your model provider's dashboard.

### What's next

- Next lesson: **L02 — Vibe Coding vs Real Coding** — when to use which.
- Related: **L04 of the AI model comparison module** — pick the cheapest model for your daily coding.
- Related: **Hermes module L06** — tiered routing across models.

> 💬 Drop your "I shipped my first feature with a coding harness" story in the Discord.

---

## 7. Self-Check / Mini-Quiz

**Q1.** The key difference between a coding harness and a chat interface is:
- A) Coding harnesses are slower
- B) Coding harnesses read your project, run commands, verify by testing
- C) Coding harnesses only work in VS Code
- D) Coding harnesses are more expensive

**Q2.** Short answer: What is the loop pattern?

**Q3.** For daily maintenance coding work, the channel's pick from the cost-efficient tier is:
- A) Claude Code Max
- B) Kilo Code + MiniMax key
- C) Cursor Pro
- D) ChatGPT

**Q4.** Short answer: Why is BYOK with Kilo Code cheaper than Claude Code Max?

**Q5.** Multiple choice: The biggest mistake beginners make with coding harnesses is:
- A) Picking the wrong model
- B) Treating the harness like a chatbot and skipping the review step
- C) Not paying for the Max plan
- D) Using a coding harness at all

**Q6.** Short answer: When should you use Claude Code vs Hermes?

### Answers

**A1.** B — Coding harnesses read your project, run commands, verify by testing. That's the whole point.

**A2.** Harness writes code → runs tests → if tests fail, reads error → fixes code → re-runs. Loop until tests pass.

**A3.** B — Kilo Code + MiniMax key. Per the source: "Kilo Code shines for daily maintenance or developing a minor feature."

**A4.** Kilo Code is free + open-source; you only pay the model provider. MiniMax is the cost-efficient Tier 2 model (covered in L04 of the AI model comparison module). Together: ~$15–$30/mo. Claude Code Max is $200/mo flat.

**A5.** B — Treating the harness like a chatbot and skipping the review step. The harness proposes; you decide.

**A6.** Claude Code for code-producing work (shipping software, refactoring). Hermes for long-running automation (cron jobs, daily research, multi-channel). Per `Specs/ChannelIdentity.md`: "Use coding harnesses for any code-producing work; treat general agent harnesses as long-running assistants."

**Scoring:** 5–6 correct → ready for L02. 3–4 → re-read Steps 1 and 4. 0–2 → restart from the top.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Kilo Code primary video** — `Kilo Code: Why You Should Try It (Tutorial)` (`cwpykYGbICc`, 1080s, March 2026).
- **Claude Code beginner command** — `This Claude Code Command is PERFECT for Beginners!` (`FYJ7hesrz4A`, 763s, ~April 2026).
- **Loops pattern** — `Advanced Loops in Claude Code (Our Setup)` (`Tw54psmZ4-k`, 696s, June 2026).
- **When NOT to use** — `Perplexity Computer Just KILLED Claude Code (Side-by-Side Test)` (`E4gc4-9O1JE`, 750s).
- **Channel beliefs** — `Specs/ChannelIdentity.md` in this repo.
- **Kilo Code docs** — `kilocode.ai` (verify current URL).

### Glossary

- **Coding harness** — an AI agent specialised for writing code (Claude Code, Kilo Code, Cursor's agent mode).
- **Loop** — when the agent retries a task until a success check passes.
- **BYOK (Bring Your Own Key)** — using your own API key instead of a vendor's bundled subscription.
- **Validation harness** — the test/check system that determines if a task succeeded (Playwright, Puppeteer, unit tests).
- **Max plan** — Claude Code's $200/month subscription.
- **Pro plan** — Claude Code's $20/month subscription.
- **MiniMax 2.7** — a Tier 2 cost-efficient model. Often used with Kilo Code for daily work.
- **PRD (Product Requirements Document)** — a written description of what you're building.

### Go deeper

- **Want to understand the cost-tier model choices?** → AI model comparison L04: Qwen, MiniMax, GLM.
- **Want to compare coding harnesses with agent harnesses?** → Hermes module L01 and L09.
- **Want a decision framework for which harness to use?** → Hermes module L09: Hermes vs Claude Code vs Mavis.

---

## 9. FAQ

**Q: Claude Code vs Cursor?**
A: Claude Code is a dedicated coding harness (read project, run tests, iterate). Cursor is an IDE with agent mode (more visual, less test-loop). Use Claude Code for serious work, Cursor for visual workflows.

**Q: Claude Code vs Kilo Code?**
A: Claude Code is paid and polished. Kilo Code is open-source and BYOK. For most beginners, Kilo Code + MiniMax is the cheapest path. Move to Claude Code when you hit a wall.

**Q: Do I need the Max plan?**
A: No. Start with Kilo Code + a cheap model. Upgrade to Claude Code Pro ($20/mo) if you need Sonnet in the harness. Upgrade to Max ($200/mo) only after you've validated the need.

**Q: How long does a typical coding harness session take?**
A: Depends on the task. A small bug fix: 5–15 minutes. A new feature: 30 minutes to 2 hours. A major refactor: hours to days (with iteration).

**Q: Will Claude Code write tests for me?**
A: Yes, if you ask. Specify the testing framework and the success criteria. The harness will write the test, run it, and iterate.

**Q: Can I use Claude Code with my own model?**
A: Not directly. Claude Code is tied to Anthropic's models. Use Kilo Code if you want BYOK.

**Q: How do I keep my code private when using Claude Code?**
A: Anthropic has a privacy mode, but the channel's `Specs/ChannelIdentity.md` flags this as not always honest. For sensitive code, use Kilo Code + a model provider whose privacy policy you trust.

**Q: What if the harness breaks my code?**
A: Use git. Commit before running the harness. If the harness breaks something, revert. The harness is a tool, not a replacement for version control.