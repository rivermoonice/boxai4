# L03 — daily-driver-tui-vs-desktop

**Module:** Hermes agent
**Proposed by:** layer-2-hermes-2026-06-24
**Status:** proposed

---

## Title (SEO formula)

**Working title:** Hermes Agent TUI vs Desktop App: Which One Should You Use in 2026?

**Meta title (50–60 chars):** Hermes Agent TUI vs Desktop App (2026 Honest Guide)
**Meta description (150–160 chars):** Two interfaces, one agent. We tested both for two weeks and the answer is "use both, for different jobs." Here's when to pick which.
**URL slug:** hermes-tui-vs-desktop-app

---

## Audience

**For:** Someone who has Hermes installed (after L02) and is wondering which interface to open. Has used the TUI a few times.
**Not for:** Anyone who hasn't installed Hermes yet — finish L02 first.

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Explain the difference between the TUI and the Desktop App in plain English.
- Decide which interface to open for a given task.
- Avoid the "desktop app is always better" trap that wastes tokens.

**Time estimate:** 10-min read

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `QSANg6VHkXI` | Hermes Agent Desktop App vs TUI (Which One to Use?) | 577s | primary |
| 2 | `c3bd0HiE3pg` | Hermes Agent Update v0.16 is HUGE! (Surface Release) | 672s | supporting — desktop UX changes |

**Why these videos:** `QSANg6VHkXI` is the most direct comparison in the index — "Use the Hermes desktop app for orchestration and human-in-the-loop management, but keep TUI open for actual coding." `c3bd0HiE3pg` adds the v0.16 update where the desktop app got better but still has token-cost caveats. Both are recent (Jun 2026) and transcript-rich.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `QSANg6VHkXI` | `00:00` | `09:30` | full talk — when TUI, when desktop, the cost trap |
| `c3bd0HiE3pg` | `00:00` | `11:00` | full update — desktop UX improvements, MCP caveat |

---

## Prerequisites

- L01: What Is Hermes Agent?
- L02: Install & first run

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

1. **Using the desktop app for everything** — the desktop UI bleeds tokens because it ships UI schemas with every message. Use TUI for token-heavy work.
2. **Using the desktop app for MCP-heavy sessions** — discoverability is still rough in v0.16; the verdict says "skip the desktop for MCP-heavy sessions until the discoverability PR ships."
3. **Closing the TUI when you "switch to" the desktop** — Ron's verdict is "use both, for different jobs." Keep both open.
4. **Picking the desktop app on the VPS** — the desktop app needs a local Mac/PC; the TUI is the remote-friendly default.
5. **Expecting the desktop app to be free of the same bugs as the TUI** — they share a backend; if the TUI breaks, the desktop breaks too.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: The TUI is best described as… (a chat window / a terminal interface / a website / a phone app)
2. Short answer: Per the source video, which interface should you use for "actual coding"?
3. Multiple choice: The desktop app's main advantage is… (it's prettier / better for orchestration and human-in-the-loop / cheaper / works without a VPS)
4. Short answer: What does "tokens" cost more on the desktop app?

---

## Suggested FAQ (for §9)

- **Q: Can I use the desktop app on a VPS?**
- **Q: Does the desktop app replace the TUI?**
- **Q: Why does the desktop app cost more in tokens?**

---

## Glossary Seeds

- **TUI (Terminal User Interface)** — a text-based interface you run inside a terminal window. Looks like a chat app but starts with a `hermes` command.
- **Desktop App** — Hermes' graphical interface, downloaded from the project site, runs as a normal Mac/Windows/Linux app.
- **Tokens** — the units an AI model charges you in. Roughly ¾ of a word. The desktop app sends more tokens per message because of UI schemas.
- **Schema overhead** — extra data the app sends to describe its layout; you pay for it on every message.
- **Orchestration** — running a long multi-step task where the agent makes decisions and asks for human input at checkpoints.

---

## Notes for the Drafter

- **Lead with the verdict from `QSANg6VHkXI`**: "use both, for different jobs." The lesson isn't about picking a winner; it's about teaching a habit.
- **Cost transparency is critical** — this is the first lesson where token cost really matters. Include a table: "Realistic token cost per 1,000 messages: TUI vs Desktop."
- **Update freshness**: source videos are from June 2026, so the v0.16 caveats are still current. Add an "Updated June 2026" tag prominently.
- **Don't bury the desktop app** — beginners will arrive wanting to use the prettier interface. Validate that, then teach them when the TUI is better.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_