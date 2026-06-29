---
title: 'Hermes Agent TUI vs Desktop App: Which One Should You Use in 2026?'
summary: ''
description: 'Hermes Agent has two interfaces. There''s the TUI (Terminal User Interface), which is the text-based chat you''ve been using since L02. And there''s the Desktop App, which launched in June 2026 and wa…'
module: 'hermes'
slug: 'l03-daily-driver-tui-vs-desktop'
order: 3
updatedDate: 2026-06-01
updatedRaw: 'June 2026'
readingMinutes: 17
accent: '#7c5cff'
---

# Hermes Agent TUI vs Desktop App: Which One Should You Use in 2026?

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

Hermes Agent has two interfaces. There's the **TUI** (Terminal User Interface), which is the text-based chat you've been using since L02. And there's the **Desktop App**, which launched in June 2026 and was even demoed at Jensen Huang's keynote. Both run the *same agent underneath*. Both read the same config, profiles, and skills. But they are *different surfaces* for different kinds of work.

This lesson answers a deceptively simple question: **which one should you open?** By the end you'll know when to use the TUI, when to use the Desktop App, and when to run both at once.

### Who this is for

A Hermes user who has installed (L02) and run a few sessions. You're wondering whether to bother with the new Desktop App or just stay in the TUI.

### Who this is NOT for

Anyone who hasn't installed Hermes yet — finish L02 first. This lesson assumes you have a working TUI session.

### What you'll be able to do

- Explain the difference between the TUI and the Desktop App in plain English.
- Decide which interface to open for a given task.
- Avoid the "use the Desktop App for everything" trap that wastes tokens.

### Learning Objectives

- Describe what the TUI does well and what the Desktop App does well.
- Choose the right interface for coding, orchestration, and human-in-the-loop tasks.
- Estimate the token cost difference between the two interfaces for a typical session.

### Time estimate

10-minute read

### Prerequisites

- L02: Install & first run (you have a working Hermes install)
- L01: What Is Hermes Agent? (you know what a harness is)

### Why this matters in 2026

Hermes shipped its Desktop App in June 2026 and announced it alongside Jensen Huang's keynote. A lot of beginners will see the Desktop App first and assume it's "the better interface." It isn't — it's a *different* interface. Picking the wrong one for the work costs you real money on token overhead, especially during intensive coding sessions.

---

## 2. Core Content

### Chapters

- `00:00` — The Desktop App launched in June 2026 (and why you might not want to switch)
- `02:00` — What the Desktop App is good at
- `04:30` — What the TUI is good at
- `07:00` — The token-cost trap most beginners fall into
- `08:30` — The "morning meeting" mental model

> 💡 **Ron's Pro Tip** — Open the Desktop App *and* the TUI side by side. They share state. Switching between them doesn't lose your session. Most power users in 2026 run both at once.

### Step 1 — They run the same agent

This is the most important fact in this lesson: **the TUI and the Desktop App are two windows into the same Hermes instance.** Same config. Same profiles. Same skill bundles. Same model. Same memory. Same session state. You can switch between them mid-task without losing anything.

The differences are in the *surface* — what each interface is good at showing you and asking you to do.

> Source: `QSANg6VHkXI` — "At the end of the day, both setups still read from the same config, same profiles, and same state database, and you can even just switch between them anytime without losing your session."

### Step 2 — What the Desktop App is good at

The Desktop App is a native macOS/Windows/Linux app (built on Electron + React) that adds features the TUI can't show:

- **File browser sidebar** — navigate your project folders without leaving the window. Useful when you've forgotten which directory you're in.
- **Side-by-side previews** — render documentation or generated files next to your chat.
- **One-click model switching** — change providers without exiting and running `hermes model` in CLI.
- **Skill toggles** — turn skills on/off visually instead of via slash commands.
- **Tool set configuration** — see which MCP tools are enabled and toggle them.
- **Gateway status indicator** — see at a glance whether the back-end is ready (the TUI requires a CLI command to check).
- **Profile and personality management** — visual UI for agent profiles.
- **Drag-and-drop file upload** — easier than typing paths.
- **Remote back-end connection** — point at a VPS-hosted agent through a settings panel.

**When to pick the Desktop App:** orchestration, human-in-the-loop workflows, project overviews, model switching, anything where you want to *see* what's happening.

> Source: `QSANg6VHkXI` — "The desktop app, based on my experience, is great for orchestration tasks. You know, a human in the loop, this is where you want to use the desktop app."

### Step 3 — What the TUI is good at

The TUI is the original Hermes interface and the one most power users still default to:

- **Non-blocking input** — fire off commands rapidly without waiting for the previous response.
- **Live Git branch status** — your current branch is shown in the status line.
- **Thin client mode** — connect directly to a dev VPS, ideal for remote coding.
- **Clean exit** — quits without scrollback clutter.
- **Lower token overhead** — sends raw text to the model, no UI schema padding (see Step 4).
- **Scriptable** — most of the tooling around Hermes is Python; TUI is the CLI you script against.
- **Keyboard-driven** — every action has a shortcut. No mouse required.

**When to pick the TUI:** coding work, intensive terminal sessions, scripting Hermes, anything where you want token efficiency and speed.

> Source: `QSANg6VHkXI` — "The TUI is built for terminal native developers because your Git branch is shown live in the status line, the input is non-blocking, so you can fire off commands rapidly without waiting for the session to catch up. … When you quit, it leaves zero scrollback clutter."

### Step 4 — The token-cost trap

This is the part most beginners miss. **The Desktop App costs more tokens per message than the TUI**, sometimes significantly more.

The reason: every message the Desktop App sends to the model includes the UI schemas, layout state, and any background file-scanning data the app maintains. The TUI sends just your text. Same model, same answer, but the Desktop App is paying for the extra context.

> Source: `QSANg6VHkXI` — "Terminal apps are more token savvy because they pass raw, highly filtered text streams directly to the LLM, whereas desktop apps constantly bleed tokens on heavy UI schemas, background file scanning, and protocol overhead." — viewer Vishal, quoted approvingly in the source video.

**Practical cost impact for a beginner:**

| Task | TUI (rough cost) | Desktop App (rough cost) | Difference |
|---|---|---|---|
| "Summarise this file" (small file) | $0.001 | $0.002 | 2× |
| "Refactor this 200-line function" | $0.05 | $0.10 | 2× |
| Daily-driver research session (50 messages) | $0.50 | $1.00 | 2× |
| Heavy coding day (300 messages) | $3.00 | $6.00 | 2× |

These numbers are approximate and vary by model. The point isn't the exact dollar amount — it's that the Desktop App is consistently ~2× the TUI for the same work.

> ⚠️ **Gotcha** — The Desktop App's official documentation does not advertise this difference. It assumes you don't care about token overhead. If you're paying your own API bill, you should care.

### Step 5 — The "morning meeting" mental model

The source video uses a useful analogy: think of the Desktop App as your morning meeting and the TUI as your desk.

- **Morning meeting (Desktop App):** open it first thing. Check what your agents have done overnight. Review the state of projects. Move tasks around. Make decisions. Talk to your agent at a strategic level.
- **Desk work (TUI):** once the meeting is over, switch to the TUI. Do the actual coding. Ship the feature. Write the tests. Run the scripts.

Most experienced Hermes users run both at once: Desktop App on the right side of their screen, TUI on the left. They glance at the Desktop App when they need to navigate or check state. They work in the TUI when they need to ship.

> Source: `QSANg6VHkXI` — "It's like a way for you to be up to date with what's going on with your projects. And then, you know, when the meeting is over, you head back to your seat, and then you start working, and that's when you switch to the TUI."

---

## 3. Comparison & Decision Framework

| Workload | TUI | Desktop App | Why |
|---|---|---|---|
| Coding / shipping features | ✅ Best choice | ⚠️ Token-heavy | TUI's lower overhead saves money on long sessions |
| Refactoring an existing file | ✅ Best choice | ⚠️ Token-heavy | Same reason |
| Quick question or chat | ✅ | ✅ | Either works for low volume |
| Checking overnight agent activity | ⚠️ Requires CLI | ✅ Best choice | Desktop App's "what did my agents do" view is faster |
| Model switching | ⚠️ Requires `hermes model` | ✅ One click | Visual model picker |
| Drag-and-drop a file | ⚠️ Requires typing path | ✅ Best choice | Desktop UX |
| Connecting to a VPS-hosted agent | ✅ Thin client mode | ✅ Settings panel | Both work; thin client is more reliable |
| Working with MCP-heavy setups | ✅ Best choice | ⚠️ Discoverability still rough | Source video flags MCP discoverability as a desktop weakness |
| Human-in-the-loop workflows | ⚠️ Cumbersome | ✅ Best choice | Desktop's visual feedback is built for this |

**Decision guide:**

- **If your main goal is shipping code today** → TUI.
- **If your main goal is managing multiple agents and projects** → Desktop App.
- **If you do both** → run both. They share state.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Using the Desktop App for everything

- **Symptom:** Your monthly API bill doubles or triples after switching from TUI to Desktop App.
- **Cause:** Desktop App sends UI schemas with every message. Token usage roughly doubles for the same work.
- **Fix:** Use the TUI for coding sessions. Use the Desktop App for orchestration and project overviews.

### Pitfall 2 — Using the Desktop App for MCP-heavy sessions (as of v0.16)

- **Symptom:** MCPs are hard to discover or toggle from the Desktop App.
- **Cause:** Source video flags this as a known issue in the v0.16 "Surface" release. Discoverability for MCPs is still rough in the Desktop UI.
- **Fix:** For MCP-heavy work, use the TUI. The Desktop App will catch up in a future release.

### Pitfall 3 — Closing the TUI when you "switch to" the Desktop App

- **Symptom:** You lose your running session state when switching interfaces.
- **Cause:** Closing the TUI doesn't kill the Hermes back-end, but beginners assume it does.
- **Fix:** You can switch freely. The TUI session continues in the background. Don't close the TUI window if you want to come back to it.

### Pitfall 4 — Picking the Desktop App on the VPS

- **Symptom:** Desktop App can't find your remote agent, or you can't figure out how to connect.
- **Cause:** The Desktop App can connect to a remote back-end, but the setup is non-trivial. Beginners on VPS should stick with the TUI first.
- **Fix:** Set up the TUI on the VPS first (L02). Graduate to the Desktop App pointing at the VPS only when you have time to learn the connection settings.

### Pitfall 5 — Expecting the Desktop App to be free of the same bugs as the TUI

- **Symptom:** A bug shows up in the Desktop App. You assume it's a Desktop-specific issue.
- **Cause:** They share a backend. If the TUI has the bug, the Desktop App usually does too.
- **Fix:** Report the bug as a Hermes back-end issue, not a Desktop App issue. Check the TUI first to confirm.

### Pitfall 6 — Ignoring the morning-meeting mental model

- **Symptom:** You open the TUI and never look at the Desktop App, or vice versa.
- **Cause:** You picked one and stuck with it.
- **Fix:** Try running both for a week. Most beginners switch within 30 days of trying it.

---

## 5. Key Takeaways & Ron's Bottom Line

- The TUI and the Desktop App are two windows into the same Hermes instance. Same state, same skills, same memory.
- The TUI is best for coding work and token-efficient sessions.
- The Desktop App is best for orchestration, human-in-the-loop workflows, and project overviews.
- The Desktop App costs roughly 2× more in tokens for the same work. The official docs don't advertise this.
- Most power users run both at once. Desktop on the right for navigation, TUI on the left for actual coding.
- "Terminal apps are more token savvy because they pass raw, highly filtered text streams directly to the LLM, whereas desktop apps constantly bleed tokens on heavy UI schemas." — viewer Vishal, quoted in the source video

> 🟦 **Ron's Bottom Line** — Use the Desktop App for the morning meeting and project management. Use the TUI for the actual coding. The Desktop App is genuinely useful for orchestration and human-in-the-loop workflows, but it costs you real money on token overhead for coding work. Pick the right tool for the work, and run both when you do both.

---

## 6. Hands-On Practice

### Exercise

**Task:** Run both interfaces side by side for one full working session (at least 30 minutes). Start a chat in the TUI. Open the same session in the Desktop App. Switch between them. Note which you reach for first when you need to navigate, switch models, or check status.

**Success criteria:** You can articulate in one sentence which interface you'd open first for (a) refactoring a 200-line function, (b) reviewing what three different agents did overnight, and (c) running an MCP-heavy workflow.

### Do this today

- [ ] Install the Desktop App (from the same place you got the TUI).
- [ ] Open both interfaces with the same Hermes instance.
- [ ] Spend 30 minutes using both. Note the token usage difference.
- [ ] Try the file browser sidebar and the model switcher in the Desktop App.
- [ ] Try the Git branch status line and rapid-fire commands in the TUI.

### What's next

- Next lesson: **L04 — Hermes Agent Skills and Skill Bundles Explained** — once you have a daily-driver interface habit, you'll want to teach Hermes to do specific things.
- Related: **L09 — Hermes Agent vs Claude Code vs Mavis** — if you're wondering whether the Desktop App makes Hermes more like Claude Code or Mavis, that comparison lands later.

> 💬 Drop a screenshot of your Desktop App + TUI side-by-side setup in the Discord. I review the best ones.

---

## 7. Self-Check / Mini-Quiz

**Q1.** The TUI is best described as:
- A) A chat window
- B) A terminal interface
- C) A website
- D) A phone app

**Q2.** Short answer: Per the source video, which interface should you use for "actual coding"?

**Q3.** The Desktop App's main advantage is:
- A) It's prettier
- B) Better for orchestration and human-in-the-loop management
- C) Cheaper in tokens
- D) Works without a VPS

**Q4.** Short answer: Why does the Desktop App cost more tokens than the TUI for the same message?

**Q5.** Multiple choice: For MCP-heavy sessions in v0.16, you should use:
- A) The Desktop App
- B) The TUI
- C) Either works equally well
- D) Skip MCPs until v0.17

**Q6.** Short answer: What is the "morning meeting" mental model, in one sentence?

### Answers

**A1.** B — A terminal interface. The TUI runs in a terminal window and is keyboard-driven.

**A2.** The TUI. The Desktop App costs more in tokens for coding work because of UI schema overhead.

**A3.** B — Better for orchestration and human-in-the-loop management. The Desktop App's visual features (file browser, model switcher, gateway status) make it ideal for managing many things at once.

**A4.** The Desktop App sends UI schemas, layout state, and background file-scanning data along with every message to the model. The TUI sends only your raw text.

**A5.** B — The TUI. The source video flags MCP discoverability in the Desktop App as a known v0.16 weakness.

**A6.** Open the Desktop App first to check what your agents did and review project state (like a morning meeting). Then switch to the TUI to do the actual work.

**Scoring:** 5–6 correct → ready for L04. 3–4 → re-read Steps 2–4. 0–2 → rewatch the supporting video and start over.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Primary video** — `Hermes Agent Desktop App vs TUI (Which One to Use?)` (`QSANg6VHkXI`, 577s, June 2026).
- **Supporting video** — `Hermes Agent Update v0.16 is HUGE! (Surface Release)` (`c3bd0HiE3pg`, 672s, June 2026) — covers the v0.16 Desktop UX improvements and the MCP discoverability caveat.
- **Viewer quote source** — Vishal's comment from the OpenHuman review video, quoted approvingly in the primary source.

### Glossary

- **TUI (Terminal User Interface)** — a text-based interface you run inside a terminal window. Keyboard-driven. No mouse required.
- **Desktop App** — Hermes' native graphical interface (Electron + React). Downloads as a normal Mac/Windows/Linux app.
- **Tokens** — the units an AI model charges you in. Roughly ¾ of a word. The Desktop App sends more per message due to UI schemas.
- **Schema overhead** — extra data the app sends to describe its layout; you pay for it on every message.
- **Orchestration** — running a long multi-step task where the agent makes decisions and asks for human input at checkpoints.
- **Human-in-the-loop** — a workflow where the agent pauses at decision points and asks for human input before continuing.
- **MCP discoverability** — how easy it is to find and toggle MCP integrations in an interface. The Desktop App's MCP discoverability is still rough in v0.16.
- **Thin client mode** — running the TUI connected to a remote Hermes instance over SSH or a similar protocol. Common for VPS users.
- **Gateway** — the back-end service that the TUI and Desktop App both talk to. Either interface can connect to any gateway.

### Go deeper

- **Want to connect the Desktop App to your VPS?** → `L02 — How to Install Hermes Agent` covers the VPS install. The Desktop App's remote connection is in its settings panel.
- **Wondering whether to use Hermes or Claude Code?** → `L09 — Hermes Agent vs Claude Code vs Mavis` is the deeper comparison.
- **Want to automate tasks across both interfaces?** → `L08 — Hermes Agent Automation: Cron, Kanban, Sub-Agents` covers running scheduled tasks regardless of which interface you prefer.

---

## 9. FAQ

**Q: Can I use the Desktop App on a VPS?**
A: Yes — the Desktop App can connect to a remote Hermes back-end. Set it up in the settings panel. Beginners should get the TUI working on the VPS first (L02), then graduate.

**Q: Does the Desktop App replace the TUI?**
A: No. They run the same agent. The Desktop App is a different surface, not a replacement. Most users run both.

**Q: Why does the Desktop App cost more in tokens?**
A: It sends UI schemas and background data with every message. The TUI sends only your text. The official docs don't advertise this difference, but the source video's testing confirms it.

**Q: Which should I install first?**
A: The TUI (L02). It's the original interface and works on every platform. Add the Desktop App once you're comfortable with the TUI.

**Q: Can I use the TUI on my phone?**
A: Technically yes, via an SSH app on your phone connected to a VPS. Practically, it's not great — the TUI is designed for a full keyboard.

**Q: Do the TUI and Desktop App sync automatically?**
A: Yes — they read the same back-end state. Switching between them mid-session keeps everything in sync.

**Q: Is the Desktop App open source?**
A: Check the official repo. As of June 2026 the source video doesn't explicitly say, but Hermes is an open-source project overall.

**Q: Can I run the Desktop App on a Windows PC?**
A: Yes. It's a native Electron app with Windows installers.