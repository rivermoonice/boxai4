---
title: 'Hermes Agent Automation: Cron Jobs, Kanban, and Sub-Agents Explained (2026)'
summary: '> ⚠️ **Evidence-light lesson.** The Kanban + Cron combination has one deep walkthrough (`iN2fD36Sgdg`, 1414s) and one Kanban-only walkthrough (`R_aLVXYzDac`, 905s). The sub-agent gotcha clips (`cxF_F217r6I`, `701XCzDQVhA`, `SdahAks9ffE`) are 55–63 seconds each — flavour, not body…'
description: 'After a week of using Hermes manually, you''ll want it to run tasks without you at the keyboard. Maybe a daily research summary at 7am. Maybe a Kanban board with multiple worker agents collaborating…'
module: 'hermes'
slug: 'l08-automation-cron-kanban-sub-agents'
order: 8
updatedDate: 2026-06-01
updatedRaw: 'June 2026'
readingMinutes: 21
accent: '#7c5cff'
---

# Hermes Agent Automation: Cron Jobs, Kanban, and Sub-Agents Explained (2026)

**Last tested and updated:** June 2026

> ⚠️ **Evidence-light lesson.** The Kanban + Cron combination has one deep walkthrough (`iN2fD36Sgdg`, 1414s) and one Kanban-only walkthrough (`R_aLVXYzDac`, 905s). The sub-agent gotcha clips (`cxF_F217r6I`, `701XCzDQVhA`, `SdahAks9ffE`) are 55–63 seconds each — flavour, not body content. The lesson is grounded in the two long videos plus the channel's documented beliefs about loop-based agent workflows.

---

## 1. Introduction & Hook

After a week of using Hermes manually, you'll want it to run tasks without you at the keyboard. Maybe a daily research summary at 7am. Maybe a Kanban board with multiple worker agents collaborating on a project. Maybe sub-agents doing parallel research.

This lesson covers the three main automation patterns Hermes supports, when to use each, and the failure modes that waste hours if you don't know about them in advance.

By the end you'll know which pattern fits which task, how to set up your first one, and how to avoid the gotchas that have burned other beginners.

### Who this is for

A Hermes user who has run the TUI manually for at least a week and wants the agent to run tasks without them. You are comfortable with the TUI (L03) and have at least a few Skills configured (L04).

### Who this is NOT for

Anyone who hasn't installed Hermes yet (L02). This lesson assumes muscle memory.

### What you'll be able to do

- Explain the difference between a cron job, a Kanban board, and a sub-agent in plain English.
- Set up a single daily cron job that runs reliably.
- Set up a basic Kanban board with one named profile.
- Decide which automation pattern fits a given task.

### Learning Objectives

- Set up a daily cron job that runs reliably and survives VPS reboots.
- Create a Kanban board with a named profile and one task.
- Distinguish between sub-agent delegation (in-context) and Kanban workers (separate profiles).
- Avoid the gotchas that make automation unreliable.

### Time estimate

14-minute read + 45-minute hands-on practice

### Prerequisites

- L02: Install & first run (VPS recommended for 24/7 automation)
- L04: Skills & Skill Bundles (cron jobs typically invoke Skills)
- L07: Security essentials (cron on a VPS requires Tailscale)

### Why this matters in 2026

Manual agent work has a hard ceiling: you can only be at the keyboard so many hours a day. Automation is how you go from "demo" to "production." Hermes supports three distinct patterns — cron, Kanban, sub-agents — and each fits a different kind of work. Picking the right pattern is the difference between a daily-driver that runs itself and a frustrating pile of cron jobs that keep breaking.

---

## 2. Core Content

### Chapters

- `00:00` — The three automation patterns and when to use each
- `02:00` — Cron jobs: the simple daily driver
- `05:00` — Kanban boards: the multi-agent collaboration pattern
- `08:00` — Sub-agents: the in-context parallel pattern
- `10:30` — The four Kanban "stories" (use cases) from the source video
- `12:00` — Common gotchas that waste hours

> 💡 **Ron's Pro Tip** — Don't pair Kanban with cron until Hermes ships a delete button and dedup logic. The source video's creator tried it and ran into four bugs. Run them separately first.

### Step 1 — The three automation patterns

Hermes supports three distinct patterns. They look similar but solve different problems.

**Pattern 1 — Cron jobs.** A scheduled task. "Run this command at 7am every day." Best for: simple, repeatable, single-task automation. Examples: daily research summary, weekly newsletter, hourly price check.

**Pattern 2 — Kanban boards.** A task board with multiple named worker profiles (each a separate Hermes instance) collaborating on a project. Best for: multi-step projects with defined roles and visible progress. Examples: "research → draft → review → publish" pipeline.

**Pattern 3 — Sub-agents.** A worker agent spawned by your main agent within the same session to do one task in parallel. Best for: fast parallel research within a single workflow. Examples: "search three sources at once and combine the results."

| Pattern | Best for | State | Failure mode |
|---|---|---|---|
| Cron | Single recurring task | Independent per run | Silent failure if the cron daemon isn't running |
| Kanban | Multi-step project with roles | Persistent across runs | Add/remove complexity, profile management overhead |
| Sub-agent | Quick parallel work in one session | Lives and dies in one session | Slow on cheap models; can loop on bad prompts |

> Source: `R_aLVXYzDac` — "If you want a more hands-on process from your agents, the Kanban lets multiple named agents collaborate on work together and they actually have a defined role that separates themselves from your typical sub agents."

### Step 2 — Cron jobs: the simple daily driver

Cron jobs are the simplest automation. The pattern:

1. Define a task in Hermes (often a Skill or a prompt).
2. Schedule it with the system cron daemon or with `hermes cron`.
3. Verify it runs.

**Example: daily 7am research summary.** The source video doesn't walk through cron setup explicitly, but the channel has covered it in earlier videos. The pattern is:

```bash
# Edit your crontab
crontab -e

# Add a line that runs your Hermes task at 7am every day
0 7 * * * cd /home/ubuntu/my-project && hermes run /summarize-today
```

**Critical cron habits:**

- **Always use absolute paths.** Cron doesn't inherit your shell's PATH. `hermes` might not be found if you wrote `~/bin/hermes`.
- **Always set the working directory.** Cron starts in `$HOME`. `cd` to your project folder first.
- **Log to a file.** Cron jobs that fail silently are the #1 source of "I thought this was working" frustration. Append stdout and stderr to a log file.
- **Test the command manually first.** If `hermes run /summarize-today` doesn't work in your terminal, it won't work in cron.
- **Use `tmux` or `systemd` for long-running tasks.** Cron kicks off the job but doesn't keep it alive if the command exits.

**Cron gotcha — parallel execution.** If you have multiple cron jobs that touch the same files (e.g. two research jobs writing to the same output folder), they can collide. The source video's recommendation: use parallel execution with explicit error handling, or schedule them with sufficient gap.

> Source: `mrsJAhMq5QA` (mentioned in the L07 backlog) — "Make Hermes AI Agent Cron Jobs Reliable: Parallel Execution + Error Handling."

### Step 3 — Kanban boards: the multi-agent collaboration pattern

Kanban is Hermes' multi-agent task board. Each task has one or more **assignee profiles** — separate Hermes instances with their own config, API keys, and specialisation. The source video walks through setting one up.

**Step 3.1 — Update Hermes.** Kanban shipped in v0.15 era (May 2026). Make sure you're on a recent version.

**Step 3.2 — Create the board.** Run `hermes kanban init`. Hermes creates a kanban DB for your project.

**Step 3.3 — Create assignee profiles.** Run `hermes profile create <name>` for each worker you want. The source video creates a "researcher" profile. Each profile gets its own API key setup, its own config, its own specialisation.

**Step 3.4 — Start the gateway.** Run `hermes gateway start`. The Kanban needs a running gateway to coordinate workers.

**Step 3.5 — Create a task.** Run `hermes kanban task create` and assign it to a profile. Hermes executes the task and shows progress on the dashboard.

> Source: `R_aLVXYzDac` — "It's basically a live dashboard where multiple agents are working together to finish a project and you get to see it unfold in real time."

**Why Kanban is different from sub-agents:** Sub-agents are ephemeral workers spawned within a single session, with no specialisation. Kanban profiles are persistent, named, configurable worker instances. A "researcher" profile gets a system prompt tuned for research, a specific API key, and its own working directory. Sub-agents get whatever the orchestrator decides at spawn time.

> Source: `R_aLVXYzDac` — "Because keep in mind, if you're doing that approach where you just open a new session and then you chat with them, your agent is still a jack of all trades, not specialized in a particular skill or in a particular role despite having so many different skills."

### Step 4 — Sub-agents: the in-context parallel pattern

Sub-agents are the lightest-weight automation. Your main agent decides to delegate a task, spawns a sub-agent to do it, and combines the result. No persistent state. No specialisation. Just quick parallel work.

**Step 4.1 — Trigger sub-agent delegation in your prompt.** Tell the main agent what you want; it decides whether to delegate. Example: "Search three sources for the latest on AI regulation and combine the results." Hermes will spawn three sub-agents in parallel.

**Step 4.2 — Read the worker logs.** The Kanban dashboard shows sub-agent activity in real time. You can see which sub-agents are running, what they're doing, and when they finish.

**Sub-agent gotchas:**

- **Cheap models are slow at sub-agent delegation.** The L06 source video tested this: parallel research with V4 Flash took 14 minutes, much longer than doing it directly.
- **Sub-agents can loop on bad prompts.** If a sub-agent gets stuck on a question it can't answer (the "asked the same question six times" clip), it burns tokens without producing output.
- **You can't see sub-agent thinking blocks directly.** When Hermes uses the `/goal` command to delegate, the sub-agents run in a separate interface. You see tasks being delegated, not their internal reasoning.

> Source: `cxF_F217r6I` (short clip) — "Hermes Agent: Why Sub Agents Fail in the Dumbest Ways."

### Step 5 — The four Kanban "stories" from the source video

The source video's creator describes four Kanban use cases, from beginner to advanced:

**Story 1 — Solo dev shipping a feature.** One assignee profile, one task. This is what the source video demonstrates. Perfect for a beginner's first Kanban.

**Story 2 — Fleet farming.** Multiple schemas (data structures), multiple assignees per schema. The Kanban orchestrates a fleet of workers, each handling one schema. Useful for parallel data processing.

**Story 3 — Multi-role pipeline with retries.** A pipeline with nodes — research, draft, review, publish — each handled by a different profile. Includes retry logic for failed steps. This is "N8N territory" per the source video. Powerful but hands-on.

**Story 4 — Circuit breaker and crash recovery.** An add-on to Story 3. If a step fails repeatedly, the Kanban stops trying and surfaces the failure to you. Useful for production.

**Recommendation:** Start with Story 1. Graduate to Story 2 once you're comfortable. Stories 3 and 4 are advanced and require significant customisation.

> Source: `R_aLVXYzDac` — "If you're a beginner, just focus on story one. Then we can move on to story two, three, and four."

### Step 6 — Common gotchas that waste hours

**Gotcha 1 — Kanban + cron without delete/dedup.** Per the source video's testing: "don't pair Kanban with cron until Hermes ships a delete button and dedup logic." If you try it, you'll get duplicate tasks, stale data, and hours of debugging.

**Gotcha 2 — Sub-agents asking the same question six times.** A bad sub-agent prompt can cause the worker to loop. Set a hard iteration cap in your sub-agent config. The source video recommends a cap based on real testing.

**Gotcha 3 — 81 attempts to get automation right.** The source video's creator needed 81 runs to get a complex automation stable. Budget for this. Set realistic expectations — complex automations take days to tune.

**Gotcha 4 — Cron jobs that don't survive reboots.** Cron survives reboots, but your *working directory* might not. If you rely on a path that gets wiped on reboot (e.g. ephemeral VM), your cron jobs will fail silently. Use absolute paths and verify after every reboot.

**Gotcha 5 — Mixing manual TUI work with cron on the same agent.** If you have a cron job running Hermes and you also start a manual TUI session, they can fight over the same lockfile or working directory. Use separate profiles per workflow.

**Gotcha 6 — Profile API key inheritance.** New profiles do NOT inherit API keys from your main Hermes agent. You have to set up the API key for each profile individually. If you forget, the profile will fail silently when it tries to call a model.

> Source: `R_aLVXYzDac` — "This profile has no API keys yet. Now once we've created the profile, we need to set up the API key for that agent otherwise it will inherit keys from our shell environment which is no problem."

---

## 3. Comparison & Decision Framework

| Task | Cron | Kanban | Sub-agent |
|---|---|---|---|
| Daily research summary | ✅ | ❌ Overkill | ❌ Ephemeral |
| Hourly price check | ✅ | ❌ | ❌ |
| Multi-step project (research → draft → review) | ⚠️ Multiple crons | ✅ Best fit | ❌ |
| Multi-source parallel research in one session | ❌ | ⚠️ Heavy | ✅ Best fit |
| Pipeline with retries | ⚠️ DIY | ✅ Story 3 | ❌ |
| Quick one-off parallel work | ❌ | ❌ | ✅ Best fit |
| Long-running 24/7 personal assistant | ✅ (VPS + Tailscale) | ❌ | ❌ |

**Decision guide:**

- **Recurring single task, no human review needed** → Cron.
- **Multi-step project with defined roles and visible progress** → Kanban.
- **Quick parallel work in one session** → Sub-agent.
- **Production pipeline with retries and crash recovery** → Kanban Story 3+.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Pairing Kanban with cron before v0.16+

- **Symptom:** Duplicate tasks pile up. Workers race to write the same file. Hours of debugging.
- **Cause:** Hermes didn't have a delete button or dedup logic when the source video was made.
- **Fix:** Run Kanban and cron separately. Or upgrade to the latest Hermes and check whether the issue is fixed before combining.

### Pitfall 2 — Sub-agents that loop on the same question

- **Symptom:** Sub-agent asks the same clarifying question repeatedly. Task never completes.
- **Cause:** Bad prompt, ambiguous task, or model that doesn't know when to stop.
- **Fix:** Set a hard iteration cap in the sub-agent config. If it loops more than 3–5 times, abort and re-prompt.

### Pitfall 3 — Sub-agents that work but never save output

- **Symptom:** Sub-agent reports success but the output file doesn't exist.
- **Cause:** The sub-agent wrote to a different directory than expected. The Kanban dashboard says "done" but the file is in `kanban/` not `profiles/`.
- **Fix:** Verify the output path explicitly in your prompt. Check both `~/.hermes/kanban/` and `~/.hermes/profiles/` after each run.

### Pitfall 4 — Cron jobs that don't survive reboots

- **Symptom:** Your cron worked yesterday. After a VPS reboot, it silently stopped.
- **Cause:** The cron daemon isn't running, the working directory got wiped, or the user changed.
- **Fix:** Verify cron is enabled (`systemctl status cron`). Use absolute paths. Test after every reboot.

### Pitfall 5 — Manual TUI + cron on the same agent

- **Symptom:** Your cron job and your manual session fight over the lockfile. One wins, the other silently fails.
- **Cause:** Both try to access the same Hermes state file at once.
- **Fix:** Use separate profiles for manual vs cron workflows. The profile's working directory is isolated.

### Pitfall 6 — Forgetting to set up API keys on new profiles

- **Symptom:** A Kanban profile fails every task with "no inference provider configured."
- **Cause:** You created the profile but didn't run `hermes profile setup` with an API key.
- **Fix:** Run `hermes profile setup <name>` and provide an API key. Repeat for every profile.

### Pitfall 7 — Setting unrealistic iteration caps

- **Symptom:** Complex automations abort before they finish. You wonder if Hermes is broken.
- **Cause:** You set a 5-iteration cap on a task that needs 81 iterations per the source video's creator.
- **Fix:** Budget realistic iteration caps. Start with 20–50 and adjust based on observed behaviour. Some tasks need more.

### Pitfall 8 — Cron job that outputs a 10MB log file

- **Symptom:** Your disk fills up because a cron job has been logging every run for months.
- **Cause:** No log rotation.
- **Fix:** Use `logrotate` or write cron jobs that append to a rotating log file. Check disk usage monthly.

---

## 5. Key Takeaways & Ron's Bottom Line

- Three patterns: cron (single recurring task), Kanban (multi-agent project), sub-agent (quick parallel work).
- Cron is the simple daily driver. Use it for "do this thing at 7am every day."
- Kanban is the multi-agent project board. Use it when you have defined roles and visible progress to track.
- Sub-agents are the fastest parallel pattern but the most fragile. Use for in-session work, not long-running automation.
- Don't pair Kanban with cron until Hermes ships a delete button and dedup logic.
- Set a hard iteration cap on sub-agents. Some tasks need 50+ iterations to complete.
- Use separate profiles for cron vs manual workflows. They share state if you don't.
- Every new profile needs its own API key. Profiles don't inherit from the main agent.
- "If you're a beginner, just focus on Story 1." — Ron, on Kanban complexity

> 🟦 **Ron's Bottom Line** — Most beginners should start with cron for simple daily tasks. Graduate to Kanban Story 1 when you have a multi-step project that benefits from visible progress. Skip Stories 3 and 4 until you've shipped Stories 1 and 2 reliably. Sub-agents are useful but unreliable on cheap models — reserve them for in-session work where you can see the loop if it happens.

---

## 6. Hands-On Practice

### Exercise

**Task:** Set up one cron job that runs a Hermes Skill daily. Pick a Skill that produces useful output (e.g. `/summarize-today` if you have one, or write a Skill for "summarise my saved links"). Schedule it for 7am. Verify it runs by checking the log file the next morning.

**Success criteria:** The cron job runs at the scheduled time. The log file shows successful completion. The output is saved to a known location.

### Do this today

- [ ] Identify one task you do manually every day that Hermes could do automatically.
- [ ] Write or pick the Skill that does it.
- [ ] Test the Skill manually until it produces the output you want.
- [ ] Add a crontab entry to run it at your chosen time.
- [ ] Verify the log file location and check it after the first scheduled run.
- [ ] If on VPS, verify the cron survives a reboot.

### What's next

- Next lesson: **L09 — Hermes Agent vs Claude Code vs Mavis** — once you have a working automation pattern, you may want to compare the bigger ecosystem to decide whether Hermes is still right for you.
- Related: **L04 — Hermes Agent Skills and Skill Bundles** — your cron jobs will typically invoke Skills.

> 💬 Drop a screenshot of your `crontab -l` output (with sensitive paths redacted) in the Discord. I review the best ones.

---

## 7. Self-Check / Mini-Quiz

**Q1.** A Kanban board in Hermes is best described as:
- A) A calendar
- B) A task board with multiple assignees, each a separate profile
- C) A chat window
- D) A database

**Q2.** Short answer: Per the source, why shouldn't you pair Kanban with cron today?

**Q3.** When should you use a sub-agent?
- A) For one-shot questions
- B) For parallel multi-step work in a single session
- C) For everything
- D) Never

**Q4.** Short answer: What's a safe iteration cap for a brand-new automation?

**Q5.** Multiple choice: When you create a new Kanban profile, what must you do before it can run tasks?
- A) Nothing — profiles inherit from the main agent
- B) Set up an API key for the profile
- C) Restart Hermes
- D) Add the profile to the crontab

**Q6.** Short answer: Name one habit that prevents cron jobs from silently failing after a reboot.

### Answers

**A1.** B — A task board with multiple assignees, each a separate profile. Each profile has its own config and specialisation.

**A2.** Per the source video: Hermes didn't have a delete button or dedup logic at the time. Pairing them caused duplicate tasks and race conditions. Check the current release notes before trying.

**A3.** B — For parallel multi-step work in a single session. Sub-agents are in-context workers, not persistent automation.

**A4.** 20–50 iterations is a reasonable starting cap. Some complex tasks need 50+ (the source video's creator needed 81). Set the cap, then adjust based on observed behaviour.

**A5.** B — Set up an API key for the profile. Profiles do NOT inherit API keys from the main agent.

**A6.** Use absolute paths (cron doesn't inherit your shell's PATH). Verify cron is enabled after reboot. Log to a file and check it after the first scheduled run.

**Scoring:** 5–6 correct → ready for L09. 3–4 → re-read Steps 2–4. 0–2 → rewatch the primary Kanban video.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Primary Kanban video** — `Hermes Agent Kanban Setup Guide (Multi-Agent Task Board)` (`R_aLVXYzDac`, 905s, May 2026). The whole Kanban walkthrough is grounded in this video.
- **Kanban + Cron deep dive** — `Hermes Agent Kanban + Cron Job is POWERFUL (Setup Guide)` (`iN2fD36Sgdg`, 1414s, May 2026). Long walkthrough of the combination. ⚠️ Source video flags this combination as not yet ready for production.
- **Cron reliability** — `Make Hermes AI Agent Cron Jobs Reliable: Parallel Execution + Error Handling` (`mrsJAhMq5QA`, ?s, May 2026). ⚠️ No transcript in current index.
- **Sub-agent gotcha clips:**
  - `Hermes Agent: Why Sub Agents Fail in the Dumbest Ways` (`cxF_F217r6I`, 55s, May 2026)
  - `Hermes Agent: It Asked the Same Question Six Times` (`701XCzDQVhA`, 63s, May 2026)
  - `Hermes Agent: It Took 81 Runs to Get the Automation Right` (`SdahAks9ffE`, ?s, May 2026)
- **Channel beliefs** — `Specs/ChannelIdentity.md` in this repo. Documents the "Loop-based agent workflows with validation harnesses" belief.

### Glossary

- **Cron job** — a scheduled task. "Run this command at 7am every day." Named after the Unix `cron` daemon.
- **Kanban** — a visual task board. Each task has a status (todo / in progress / done) and an assignee.
- **Assignee profile** — in Hermes Kanban, a separate Hermes instance per worker. Each profile has its own config and credentials.
- **Sub-agent** — a worker agent spawned by your main agent within the same session to do one task in parallel. Has its own context window but no persistent state.
- **Gateway** — the back-end service that coordinates Kanban workers. Started with `hermes gateway start`.
- **Iteration cap** — a hard limit on how many times a sub-agent (or loop) can retry before aborting.
- **`crontab`** — the Unix configuration file that defines scheduled tasks.
- **Log rotation** — automatically archiving old log files so they don't fill up the disk.
- **tmux** — a terminal multiplexer that keeps sessions alive across logouts.
- **systemd** — the Linux service manager. Can keep processes alive across reboots, but more complex to configure than tmux.

### Go deeper

- **Want to schedule Skill Bundle invocations?** → `L04 — Hermes Agent Skills and Skill Bundles Explained`.
- **Want cron jobs that survive VPS reboots?** → `L02 — How to Install Hermes Agent` covers VPS setup, and `L07 — Security Essentials` covers Tailscale.
- **Wondering whether Hermes is right for your automation use case?** → `L09 — Hermes Agent vs Claude Code vs Mavis`.

---

## 9. FAQ

**Q: Do cron jobs run when my Mac is asleep?**
A: No. Cron requires the system to be awake. For 24/7 cron, use a VPS (covered in L02).

**Q: Can a Kanban story call another Kanban story?**
A: Not directly. Stories are independent tasks. Use Story 3 (multi-role pipeline) if you need dependency chains.

**Q: How do I see what my sub-agent is doing?**
A: The Kanban dashboard shows sub-agent activity in real time. For the `/goal` command specifically, sub-agents run in a separate interface and you see only the task assignment, not the internal reasoning.

**Q: What's the difference between cron and Kanban for a beginner?**
A: Cron runs the same task at the same time every day. Kanban orchestrates multiple named workers on a multi-step project. Start with cron. Move to Kanban when you need visible progress tracking and role separation.

**Q: Can I run a Kanban profile on a different VPS than the orchestrator?**
A: Theoretically yes, but the source video doesn't cover this in depth. Most beginners run all profiles on the same VPS.

**Q: How long does it take to set up a Kanban Story 1?**
A: About 15–20 minutes per the source video, including creating the profile, starting the gateway, creating the task, and watching it execute.

**Q: What's a reasonable cron job to start with?**
A: A daily research summary at 7am, or a weekly review of saved links. Pick something you already do manually — that's the easiest automation to verify.

**Q: Can Kanban workers see each other's output?**
A: Yes — Kanban coordinates shared state. Each worker reads the task description and writes its output to a shared location, so the next worker in the pipeline can pick it up.