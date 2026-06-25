# What Is Hermes Agent? A Beginner's Guide to AI Agent Harnesses (2026)

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

If you've ever asked ChatGPT a question, watched it give you a confident answer, and then realised the answer was completely wrong, you already know the gap between "an AI can chat" and "an AI can do real work." That gap is exactly what an **AI agent harness** exists to close — and Hermes Agent is one of the most popular open-source harnesses in 2026.

In this first lesson, you'll learn what a harness actually is, why it matters more than which model you pick, and whether Hermes is the right starting tool for you. You will **not** install anything yet. This is pure concept.

### Who this is for

A complete beginner who has heard the words "AI agent" or "Claude Code" but has never used one. You should be comfortable opening a terminal app on your computer (we'll cover Hermes specifics in L02). You do not need to know what an "API" is — we'll define it when we get to it.

### Who this is NOT for

Existing Hermes users, anyone already running Claude Code daily, or anyone looking for a comparison of every agent harness on the market. (L09 covers that comparison once you've decided you actually want an agent.)

### What you'll be able to do

By the end of this lesson you will be able to:

- Explain what an AI agent harness is, in plain English, to a friend.
- Describe what Hermes does and what it does not do.
- Decide whether Hermes is the right tool for what you want to build or automate in 2026.

### Learning Objectives

- Use the words "AI model," "agent harness," "coding harness," and "loop" correctly in your own sentences.
- Identify whether a given task is a "build" task (use a coding harness) or a "make my life better" task (use an agent harness).
- Choose between Hermes, Claude Code, and a coding tool based on the work, not on marketing.

### Time estimate

8-minute read. No video required to read this lesson; the supporting video is included for visual learners.

### Prerequisites

None — this is L01.

### Why this matters in 2026

In 2026 the bottleneck for shipping AI work is no longer "which model is smartest." Models have converged — most frontier models now perform exceptionally well at common tasks. The bottleneck is the **harness** around the model: the runtime that lets the AI actually read files, run commands, persist memory across sessions, and verify its own work. Hermes is a strong option in this new category, but only if you understand what a harness is in the first place.

---

## 2. Core Content

### Chapters

- `00:00` — Why "model quality" stopped being the bottleneck
- `01:30` — Coding harness vs agent harness (the central distinction)
- `04:00` — When to pick which
- `08:00` — What Hermes specifically is (and isn't)
- `11:00` — Ron's mental model in one paragraph

> 💡 **Ron's Pro Tip** — The first question to ask is not "which AI tool." It's "what kind of work am I doing." Build work and life-automation work are two different jobs.

### Step 1 — A model is a brain, a harness is a body

A **model** (Claude, GPT, DeepSeek, Kimi, Qwen, etc.) is the AI itself. It's the thing that takes your text and produces a reply. On its own, a model can't read a file on your computer, can't run a command, can't remember what you said yesterday. It just generates text in response to text.

A **harness** is the program that wraps the model and gives it those abilities. The harness is what lets an AI actually *do* work in the world: read your codebase, execute shell commands, post to GitHub, schedule a task for 6am tomorrow, or remember a preference across sessions. The harness is the **body**. The model is the **brain**.

> Source: `GGtmmx0MKCI` — "So, how I've been approaching building stuff for AI has been sort of wrong or rather inaccurate. It's not a model issue, but rather a harness issue."

This is the single most important idea in this lesson. If you take away one thing, take this: when your AI messes up, the problem is almost always the harness, not the model.

### Step 2 — Two kinds of harness: coding vs agent

In 2026, harnesses split into two broad categories:

**Coding harnesses** are built around a codebase. Claude Code, Kilo Code, and the agent mode in Cursor are coding harnesses. They start from files, repositories, pull requests, IDEs, and CI pipelines. They run deterministic verification loops — meaning they actually run the code, check the test output, and iterate until the tests pass. They are designed to be the engineering shell of an agent: bounded authority, predictable side effects, and a human engineer (or CI pipeline) who owns the final merge.

**Agent harnesses** are built around a runtime. Hermes Agent and OpenClaw are agent harnesses. They start from sessions, tools, memory, scheduled jobs, channels (Discord, Telegram, Notion, etc.), and routing rules. They are designed to be the autonomous shell of an agent: persistence across sessions, multi-channel operation, and gradual improvement as you use them more.

> Source: `GGtmmx0MKCI` — "Coding harness belongs in the dev loop, whereas the general agent harness belongs in the runtime loop. Claude code and Kilo code, they're positioned around code bases, editors, command execution, and developer tooling. While agent harnesses, like Hermes agent and Open Claw, they're positioned around persistence, gateways, memory, tools, and multi-channel operation."

The shorthand is: **coding harnesses verify by running. Agent harnesses verify by inferring.** Both have trade-offs. Coding harnesses are stronger when you need ground-truth verification — "did the test pass?" Agent harnesses are stronger when you need long-running personal automation — "summarise my email every morning at 7am."

### Step 3 — When to pick which

Use this simple decision rule:

- If your goal is to **build software** (a website, an app, an API, a script), pick a **coding harness** first. Claude Code or Kilo Code are the most common starting points. They will run tests, catch syntax errors, and produce working code faster than an agent harness can.
- If your goal is to **automate ongoing work** (research, writing, summarising, scheduling, multi-channel ops), pick an **agent harness** like Hermes. It will keep state across sessions, learn your preferences over time, and free you from being at the keyboard.
- If you're not sure, ask: "Do I need a deliverable at the end of one session, or do I need a long-running helper?" Deliverable → coding harness. Long-running helper → agent harness.

> Source: `GGtmmx0MKCI` — "If the question is what helps me build an app, then coding harnesses are the strongest. But if the question is what can help me make my life better, that would be general agent harness."

> ⚠️ **Gotcha** — Beginners sometimes pick Hermes because it's free and open-source and assume it'll do everything. It won't. Hermes is for the second category. For the first, use a coding harness even if you have to pay for it.

### Step 4 — What Hermes specifically is

Hermes Agent is an open-source agent harness that runs on your own computer or on a small rented server (called a VPS — a virtual private server). It is one of the most-starred open-source AI projects on GitHub in 2026, with over 200,000 stars. It is not a model — it is the program that wraps a model.

Hermes is designed to be the **runtime shell** for an agent. From the project's own documentation: "We are not a coding co-pilot tethered to an IDE. We are an autonomous agent that gets more capable the longer it runs."

In practice, that means:

- Hermes can read and write files in a working directory you specify.
- Hermes can run shell commands and verify their output.
- Hermes can remember context across sessions, especially the things you flag as important.
- Hermes can be scheduled to run tasks at specific times (we'll cover this in L08).
- Hermes can connect to other apps like GitHub, Linear, Notion, and Discord via MCP — the Model Context Protocol (covered in L05).

What Hermes is **not**:

- Hermes is not a chat app. It's a terminal program. You can wrap it in a desktop UI, but the underlying interface is text.
- Hermes is not a model. You bring your own model API key (BYOK) — Anthropic, OpenAI, DeepSeek, Kimi, etc. The cost of using Hermes is mostly the cost of the model tokens you send and receive.
- Hermes is not magic. As the source video notes, "you'd have to imagine you have to spend hundreds or thousands of hours if you have no technical experience on training up your Hermes agent to function as well as if you could put the same model in a coding harness." Hermes improves with use and feedback, but only if you put in the time.

### Step 5 — Ron's mental model in one paragraph

Here's the mental model the source video uses to decide which tool to open:

> Source: `GGtmmx0MKCI` — "Hermes and Open Claw are trying to be the runtime shell for an agent, while Claude Code and Kilo Code are trying to be the engineering shell for an agent."

If your work is mostly inside a codebase — building, refactoring, testing — open a coding harness. If your work is mostly outside a codebase — research, scheduling, multi-channel automation, long-running personal tasks — open Hermes. If you do both, run both. They don't conflict.

---

## 3. Comparison & Decision Framework

This lesson is itself a decision framework. The table below maps common tasks to the right tool.

| Goal | Pick | Why |
|---|---|---|
| Build a full-stack app from scratch | Kilo Code / Claude Code | Coding harnesses verify by running tests; the work is inside a codebase. |
| Refactor an existing codebase | Claude Code | It owns the engineering shell and respects your Git workflow. |
| Run a daily research summary | Hermes | Long-running, persistent, runs at 7am without you. |
| Post to Discord / Telegram on a schedule | Hermes | Multi-channel is what agent harnesses were built for. |
| One-off code question | Claude Code | Single-session deliverable; no need for persistence. |
| Multi-day research project with notes that survive | Hermes | Memory across sessions is the differentiator. |
| You want to ship a real product in 30 days | Kilo Code | Deterministic loops catch mistakes Claude Code users pay $200/mo to avoid. |
| You want a daily-driver helper that learns your style | Hermes | Gets more capable the longer it runs. |

**Decision guide (when in doubt):**

- **If your main goal is to ship a product** in the next month → start with a coding harness.
- **If your main goal is to free up time** on tasks you do weekly → start with Hermes.
- **If you need both** → run both. Most power users in 2026 use a coding harness for the building and an agent harness for the running.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Confusing "AI agent" with "chatbot"

- **Symptom:** You expect Hermes to be like ChatGPT — a chat window you type questions into and get answers from.
- **Cause:** Hermes is a harness, not a chat UI. It executes tasks in a working directory. It will happily try to create files, run commands, and edit your system.
- **Fix:** Read L02 before launching Hermes for the first time. Understand that you're giving it a sandboxed directory to work in. Keep your real files outside that directory until you trust the setup.

### Pitfall 2 — Picking Hermes because you want to "learn AI"

- **Symptom:** You install Hermes, ask it a question, and get frustrated that it doesn't behave like a chatbot.
- **Cause:** Hermes is built for execution, not Q&A. ChatGPT-style chatting is a side effect, not the design.
- **Fix:** Use ChatGPT (or the model API directly) for one-off questions. Use Hermes for tasks where the AI should *do* something — read a file, write a script, schedule a job, post a message.

### Pitfall 3 — Skipping the install lesson because you "just want to read"

- **Symptom:** YouTube-channel-comment energy: "I'll just install it later." A month later, you still haven't.
- **Cause:** Concept-only learning doesn't build the muscle memory you need for the next lesson.
- **Fix:** After this lesson, immediately go to L02. The full install takes under 20 minutes on a fresh Mac. Doing it now means L03–L09 will actually stick.

### Pitfall 4 — Picking Hermes when you should be in a coding harness

- **Symptom:** You're trying to build an app, but you're using Hermes and getting confused why the code is full of syntax errors.
- **Cause:** Agent harnesses are inferential — they verify by checking if the output "looks right," not by running it. Coding harnesses run the actual code and catch errors.
- **Fix:** If you're building software, switch to Claude Code or Kilo Code. If you must stay in Hermes, learn to ask it explicitly to run the code and check the output (we'll cover this in L04).

### Pitfall 5 — Believing Hermes' 200K-star count means it's the best tool for you

- **Symptom:** "Hermes has 200K stars on GitHub. It's the most popular. So it must be the right choice."
- **Cause:** Star counts measure how popular the *project* is, not how well it fits your specific workflow. Coding harnesses live in different repositories and don't compete on the same metric.
- **Fix:** Use the decision framework above. Stars are a popularity signal, not a fit signal.

### Pitfall 6 — Expecting an AI agent to remember your work between sessions without setup

- **Symptom:** You start a new Hermes session, ask it to continue yesterday's work, and it acts like it has never met you.
- **Cause:** Agent harnesses persist memory, but only of things you mark as important — usually via `agents.md` files in your working directory.
- **Fix:** We cover `agents.md` and memory setup in L02 and L04. For now, know that "memory across sessions" is a feature you turn on, not a default.

---

## 5. Key Takeaways & Ron's Bottom Line

- The model is the brain. The harness is the body. In 2026, the bottleneck is the harness, not the model.
- Coding harnesses (Claude Code, Kilo Code) verify by running. They're for shipping software.
- Agent harnesses (Hermes, OpenClaw) verify by inferring. They're for long-running personal automation.
- Pick the harness based on the work, not on marketing or star counts.
- Hermes is open-source, BYOK (bring your own API key), and gets better the more you use it — but only with hundreds of hours of feedback if you're a non-engineer.
- "It's not a model issue. It's a harness issue." — Ron

> 🟦 **Ron's Bottom Line** — If your goal is to ship a real product this month, start with Claude Code or Kilo Code. If your goal is to free up time on recurring work you already do, start with Hermes. If you do both, run both — they don't conflict, and the cost of running two is much less than the cost of fighting the wrong tool.

---

## 6. Hands-On Practice

### Exercise

**Task:** Open a text file on your computer (Notes app, TextEdit, anything). Write down the answer to this question in your own words, no copy-paste:

> "If I want to post a summary of today's top 3 AI news stories to my Discord every morning at 7am, which kind of harness should I use, and why?"

**Success criteria:** Your answer names either Hermes (agent harness) or Claude Code (coding harness) and gives one concrete reason. If you can do that without rereading the lesson, you have the core idea. If you can't, re-read Step 2.

### Do this today

- [ ] Write the answer to the exercise above.
- [ ] Skim the rest of this lesson's "Decision guide" and pick one real task from your week that you'd automate with an agent harness.
- [ ] Watch the supporting video (`GGtmmx0MKCI`) — it's 13 minutes and covers everything in this lesson in Ron's voice.
- [ ] Go to L02 and install Hermes.

### What's next

- Next lesson: **L02 — How to Install Hermes Agent for Beginners (Mac and VPS, Step-by-Step)** — the first hands-on lesson in the course.
- Related: **L09 — Hermes Agent vs Claude Code vs Mavis** — if you're still not sure whether Hermes is right for you, that lesson is the deeper comparison.

> 💬 If you wrote the exercise answer and it felt easy, drop it in the Discord — I review the best ones and shout them out.

---

## 7. Self-Check / Mini-Quiz

**Q1.** Hermes Agent is best described as a:
- A) Chatbot
- B) Coding harness
- C) General-purpose agent harness
- D) Model

**Q2.** Short answer: Name one thing Hermes can do that a regular chatbot cannot.

**Q3.** You want to build a full-stack web app from scratch. Which kind of harness should you reach for first?
- A) Hermes
- B) Claude Code or Kilo Code
- C) Either works equally well
- D) Neither — you need a no-code tool

**Q4.** Short answer: True or false — Hermes is an AI model. Explain in one sentence.

**Q5.** Per the source video, what is the trade-off when using an agent harness instead of a coding harness?

**Q6.** Short answer: What does "BYOK" stand for, and why does it matter for Hermes?

### Answers

**A1.** C — General-purpose agent harness. Hermes wraps a model and gives it the ability to read files, run commands, and persist across sessions.

**A2.** Any of: read and write files in a working directory; run shell commands; remember context across sessions; schedule tasks at specific times; connect to Discord / Linear / Notion via MCP. (Any one of these is a valid answer.)

**A3.** B — Claude Code or Kilo Code. Coding harnesses verify by running tests, which is what you need for shipping software.

**A4.** False. Hermes is a harness, not a model. You bring your own model (Claude, GPT, DeepSeek, Kimi, etc.) and Hermes is the program that wraps it.

**A5.** Agent harnesses verify by inferring ("does this look right?") rather than by running tests. They are more flexible for ongoing work but less reliable for code where you need ground-truth verification.

**A6.** "Bring Your Own Key." It means Hermes doesn't bundle model access — you sign up with a model provider (Anthropic, OpenAI, etc.) and paste your own API key. Cost is whatever you spend on the model, not a flat subscription.

**Scoring:** 5–6 correct → ready for L02. 3–4 → re-read Steps 1–3. 0–2 → re-read the whole lesson and watch the supporting video.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Supporting video** — `Agent Harness vs Coding Harness (Know the Difference)` (`GGtmmx0MKCI`, 790s, May 2026). The mental model in this lesson comes directly from it.
- **`Specs/ChannelIdentity.md`** (in this repo) — the channel's documented beliefs about harnesses, model routing, and what real workflows look like.
- **Next lesson** — `L02 — How to Install Hermes Agent for Beginners (Mac and VPS, Step-by-Step)` (`lessons/hermes/L02-install-and-first-run.md`).
- **Comparison lesson** — `L09 — Hermes Agent vs Claude Code vs Mavis` (`lessons/hermes/L09-hermes-vs-alternatives.md`), if you want a deeper comparison once you've tried the basics.

### Glossary

- **AI model** — the AI itself. Takes text, returns text. Examples: Claude, GPT, DeepSeek, Kimi, Qwen, MiniMax.
- **Agent harness** — a program that wraps a model and gives it the ability to take actions in the world (read files, run commands, remember across sessions).
- **Coding harness** — an agent harness specialised for software engineering work. Claude Code and Kilo Code are coding harnesses.
- **Loop** — when the agent retries a task until a success check passes, instead of stopping at the first attempt.
- **Working directory** — the folder on your computer the agent can see and modify. Set this before launching Hermes.
- **MCP (Model Context Protocol)** — a standard that lets an AI harness talk to outside apps (GitHub, Linear, Notion, Discord). Covered in L05.
- **BYOK (Bring Your Own Key)** — using your own API key for the model instead of a vendor's bundled subscription.
- **Slash command** — a short command prefixed with `/` that triggers a built-in skill. Example: `/standup`.
- **Deterministic verification** — running the actual code and checking the output, rather than judging whether the output "looks right."

### Go deeper

- **Coding harness first?** → `L09 — Hermes Agent vs Claude Code vs Mavis` walks through the decision with cost tables.
- **Want the long-form mental model?** → Watch `GGtmmx0MKCI` (13 min). Ron walks through real examples and explains why this distinction matters.
- **Ready to install?** → `L02 — How to Install Hermes Agent for Beginners`.

---

## 9. FAQ

**Q: Is Hermes Agent free?**
A: The software is open-source and free to download. The model you run inside it is not free — you pay the model provider (Anthropic, OpenAI, DeepSeek, etc.) for the tokens you send and receive. Realistic beginner cost is $5–$20 per month.

**Q: Do I need a Mac?**
A: No. Hermes runs on macOS, Windows, and Linux. The cleanest install is on a fresh Mac or on a Linux VPS. L02 covers both.

**Q: What's the difference between Hermes and ChatGPT?**
A: ChatGPT is a chat app that runs OpenAI's models behind a subscription. Hermes is an open-source program you run on your own computer, which can use any model you give it an API key for. ChatGPT has a polished chat UI; Hermes has a terminal interface (TUI) and an optional desktop app (covered in L03).

**Q: Can Hermes write code?**
A: Yes — but it is better suited to ongoing automation than shipping production software. For shipping software, use a coding harness (Claude Code or Kilo Code). L09 covers when each is the right choice.

**Q: Will Hermes remember my work between sessions?**
A: Only what you explicitly mark as important — usually via an `agents.md` file in your working directory. L02 and L04 cover memory setup.

**Q: Is Hermes hard to learn?**
A: It has more setup than ChatGPT (you install it yourself, you bring your own API key, you learn the TUI). The first session is slower than the first ChatGPT message. After 5–10 hours of use, the muscle memory pays off.

**Q: What if I just want to try it before installing?**
A: That's exactly what this lesson is for. After this lesson, if you decide Hermes is for you, L02 walks you through install on a Mac or VPS in under 20 minutes.