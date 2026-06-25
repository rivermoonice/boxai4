# L08 — automation-cron-kanban-sub-agents

**Module:** Hermes agent
**Proposed by:** layer-2-hermes-2026-06-24
**Status:** proposed

---

## Title (SEO formula)

**Working title:** Hermes Agent Automation: Cron Jobs, Kanban, and Sub-Agents Explained (2026)

**Meta title (50–60 chars):** Hermes Automation: Cron, Kanban, Sub-Agents (2026)
**Meta description (150–160 chars):** Three ways to make Hermes run without you: timed tasks (cron), task boards (Kanban), and worker agents (sub-agents). What each is good at — and when not to mix them.
**URL slug:** hermes-automation-cron-kanban-subagents

---

## Audience

**For:** A Hermes user who has used the TUI manually for a week and wants the agent to run tasks without them at the keyboard.
**Not for:** Anyone who hasn't installed Hermes yet (L02) or used skills (L04). This lesson assumes muscle memory.

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Explain the difference between a cron job, a Kanban board, and a sub-agent in plain English.
- Set up a single daily cron job that runs reliably.
- Decide which automation pattern fits a given task.

**Time estimate:** 14-min read + 45-min hands-on

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `R_aLVXYzDac` | Hermes Agent Kanban Setup Guide (Multi-Agent Task Board) | 905s | primary (Kanban) |
| 2 | `iN2fD36Sgdg` | Hermes Agent Kanban + Cron Job is POWERFUL (Setup Guide) | 1414s | primary (cron + Kanban) |
| 3 | `mrsJAhMq5QA` | Make Hermes AI Agent Cron Jobs Reliable: Parallel Execution + Error Handling | ?s | supporting (cron gotchas) |
| 4 | `cxF_F217r6I` | Hermes Agent: Why Sub Agents Fail in the Dumbest Ways | 55s | supporting (sub-agent pitfalls) |
| 5 | `701XCzDQVhA` | Hermes Agent: It Asked the Same Question Six Times | 63s | supporting (sub-agent gotchas) |
| 6 | `SdahAks9ffE` | Hermes Agent: It Took 81 Runs to Get the Automation Right | ?s | supporting (iteration cost) |

**Why these videos:** `R_aLVXYzDac` is the canonical Kanban setup ("a real upgrade over blind sub-agent delegation for multi-step work"). `iN2fD36Sgdg` covers the Kanban+Cron combo (1414s — heavy). The four short clips each cover one real failure mode beginners hit.

⚠️ **Evidence note:** L08's bucket has 28 videos, but only **4 have transcripts** (the rest are 55–64 second shorts from the Kanban tutorial era). The lesson will draw most of its body from `R_aLVXYzDac` and `iN2fD36Sgdg`. The shorts are evidence for gotchas in §4.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `R_aLVXYzDac` | `00:00` | `15:00` | full Kanban setup — assignees, profiles, Story 1 before Story 2 |
| `iN2fD36Sgdg` | `00:00` | `23:00` | full cron + Kanban combo — the four custom fixes the creator needed |
| `mrsJAhMq5QA` | `00:00` | `02:00` | cron reliability, parallel execution |
| `cxF_F217r6I` | `00:00` | `00:55` | sub-agent failure modes |

---

## Prerequisites

- L02: Install & first run (VPS recommended for 24/7 automation)
- L04: Skills & Skill Bundles (cron jobs typically invoke skills)
- L07: Security essentials (cron on a VPS requires Tailscale)

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [x] 3. Comparison & Decision Framework *(this lesson IS a decision framework)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Pairing Kanban with cron before Hermes ships delete + dedup** — `iN2fD36Sgdg`'s verdict is explicit: "don't pair Kanban with cron until Hermes ships a delete button and dedup logic."
2. **Sub-agents that loop on the same question** — `701XCzDQVhA`: "It Asked the Same Question Six Times." Sub-agents need explicit completion checks.
3. **Skipping the "iterate to fix" budget** — `SdahAks9ffE`: "81 Runs to Get the Automation Right." Set a hard iteration cap.
4. **Cron jobs that don't run because the VPS rebooted** — cron survives reboots, but your *working directory* might not. Always use absolute paths.
5. **Mixing manual TUI work with cron on the same agent** — the cron job will fight you for the lockfile. Use separate profiles per Kanban story, as `mdGGFZCIrKQ` covers.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: A Kanban board in Hermes is best described as… (a calendar / a task board with multiple assignees / a chat window / a database)
2. Short answer: Per the source, why shouldn't you pair Kanban with cron today?
3. Multiple choice: When should you use a sub-agent? (for one-shot questions / for parallel multi-step work / for everything / never)
4. Short answer: What's a safe iteration cap for a brand-new automation?

---

## Suggested FAQ (for §9)

- **Q: Do cron jobs run when my Mac is asleep?**
- **Q: Can a Kanban story call another Kanban story?**
- **Q: How do I see what my sub-agent is doing?**
- **Q: What's the difference between cron and Kanban for a beginner?**

---

## Glossary Seeds

- **Cron job** — a scheduled task. "Run this command at 6am every day." Named after the Unix `cron` daemon.
- **Kanban** — a visual task board. Each story has a status (todo / in progress / done) and an owner.
- **Sub-agent** — a worker agent spawned by your main agent to do one task. Has its own context window.
- **Assignee profile** — in Hermes Kanban, a separate Hermes instance per worker. Each profile has its own config and credentials.
- **Loop** — (re-define) a workflow that retries until a success check passes. The whole point of sub-agents.

---

## Notes for the Drafter

- **This is the longest lesson in the module.** Kanban setup takes real time and real reading. Don't compress it.
- **Lean on the two primary videos heavily.** The shorts are flavour, not structure.
- **The Kanban-only vs Kanban+cron question is the lesson's spine.** Most beginners want cron first. The source says don't. Explain why.
- **This lesson should set a hard "stop after 81 attempts" rule** — the source's own creator needed 81 runs. Beginners need a budget.
- **Mark this lesson "Last tested: June 2026" prominently.** The v0.16/v0.17 release cycle may have shipped the missing delete button; check before publishing.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_