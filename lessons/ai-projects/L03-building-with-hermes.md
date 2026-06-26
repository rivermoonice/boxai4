# How to Build Real Projects with Hermes Agent (2026 Beginner Guide)

**Last tested and updated:** June 2026

> ⚠️ **Cross-reference lesson.** Most Hermes-build content lives in the Hermes module (L02 install, L04 skills, L08 automation). This lesson points back to that material and adds project-type guidance.

---

## 1. Introduction & Hook

You've finished the Hermes module. You can install Hermes, run it, set up Skills, configure MCPs, and automate cron jobs. Now the question: **what do you actually build with it?**

Hermes is a general-purpose agent harness. It's not a coding harness. It's not a chat interface. It's the body that wraps a model and lets it act on your behalf — research, write, schedule, post, summarise. The projects that fit Hermes are different from the projects that fit Claude Code.

In this lesson you'll learn which project types Hermes excels at, which it doesn't, and how to set up a project that uses Hermes' strengths.

### Who this is for

A reader who has completed the Hermes module (L01–L09) and wants to ship a real project.

### Who this is NOT for

Anyone who hasn't installed Hermes yet. Finish the Hermes module's L02 first.

### What you'll be able to do

- Identify three project types Hermes excels at.
- Set up a Hermes project from scratch.
- Recognise when to escalate to Claude Code for the production version.

### Learning Objectives

- Identify three project types where Hermes wins.
- Set up a Hermes project with proper structure.
- Recognise the limits of agent harnesses for code production.
- Recognise when an agent harness + coding harness combination is the right move.

### Time estimate

8-minute read + 1–2 hours hands-on

### Prerequisites

- Hermes module L01–L04 (concept, install, TUI/Desktop, Skills)
- A model API key (covered in the AI model comparison module)

### Why this matters in 2026

Hermes is the body that wraps a model. The channel's documented belief: "AI agents are leverage on top of a pre-existing human advantage (network, niche knowledge), not pure automation that replaces the founder." Hermes projects work when they amplify something you already have — niche knowledge, network, daily routine. They fail when you try to use them as a magic wand.

This lesson is short by design. The heavy lifting is in the Hermes module. Here we map the project space.

---

## 2. Core Content

### Chapters

- `00:00` — Three project types where Hermes wins
- `02:00` — Project type 1: research and writing
- `03:30` — Project type 2: daily automation
- `05:00` — Project type 3: multi-channel workflows
- `06:30` — What Hermes doesn't do well
- `07:30` — When to combine with Claude Code

> 💡 **Ron's Pro Tip** — Start with a research project. Hermes' Skill Bundles (L04 of the Hermes module) make research workflows trivial to set up.

### Step 1 — Three project types where Hermes wins

Hermes is built for three project types. If your project fits one of these, Hermes will serve you well. If it doesn't, consider Claude Code.

**Project type 1: Research and writing workflows.**
Examples: daily research summary, weekly newsletter, blog post drafting, competitive analysis.
Why Hermes wins: Skill Bundles can codify a multi-step research workflow. Cron jobs run them daily. MCPs fetch from GitHub, Linear, Notion, Discord.

**Project type 2: Daily automation.**
Examples: morning briefing, end-of-day wrap-up, weekly review, recurring tasks.
Why Hermes wins: Cron + Skills + Bundles = set-and-forget automation.

**Project type 3: Multi-channel workflows.**
Examples: post a summary to Discord and Telegram at 7am, archive Slack messages to Notion, sync GitHub issues to Linear.
Why Hermes wins: MCP catalog (L05 of the Hermes module) gives Hermes native access to the apps. The Desktop App coordinates the workflow visually.

### Step 2 — Project type 1: research and writing

**Setup:**
1. Create a project directory with `agents.md` capturing your research style.
2. Write a Skill file for each step (discovery, extraction, organisation, analysis, output).
3. Group the Skills into a Bundle (e.g. `/research`).
4. Set a cron job to run the Bundle daily at 7am.
5. Verify the output looks like what you want.

**Cost example:** Hermes + DeepSeek V4 Flash for daily research at 50 messages/day = ~$5/mo.

**Channel-voice alignment:** Per `Specs/ChannelIdentity.md`: "Practical, cost-efficient models like Kimi K2.7 and MiniMax M3 beat raw frontier capability for everyday use." Don't use Opus for daily research.

### Step 3 — Project type 2: daily automation

**Setup:**
1. Identify one task you do manually every day or week.
2. Write a Skill that does that task.
3. Set a cron job.
4. Verify the cron survives reboots (covered in Hermes module L08).

**Example tasks:**
- Daily 7am: scan AI news, summarise top 3 stories, post to Discord.
- Weekly Monday 9am: review saved links, draft a "weekly links" post.
- End of day: archive today's work-in-progress to a backup folder.

**Key habit:** Per the Hermes module L08, "set a hard iteration cap on sub-agents" and "log to a file and check it after the first scheduled run."

### Step 4 — Project type 3: multi-channel workflows

**Setup:**
1. Identify the apps involved (Discord, Telegram, Notion, Linear, etc.).
2. Install the relevant MCPs from the catalog (covered in L05).
3. Write Skills that orchestrate the MCPs.
4. Test manually before automating.

**Example workflow:**
- 7am: Hermes reads GitHub issues via GitHub MCP.
- 7:05am: Hermes reads Linear tickets via Linear MCP.
- 7:10am: Hermes drafts a "daily engineering brief" combining both.
- 7:15am: Hermes posts the brief to Discord and Telegram.
- All logged to a file for review.

**Caution:** Multi-channel MCPs are powerful but each one needs careful permission scoping (covered in Hermes module L05).

### Step 5 — What Hermes doesn't do well

**Production software development.** Hermes can write code, but it's not optimised for it. Use Claude Code / Kilo Code instead.

**Real-time UI work.** Hermes' TUI is great for terminal work. The Desktop App is good for orchestration. Neither is great for pixel-perfect UI design. Use Cursor or a dedicated UI tool.

**Long-running heavy compute.** Hermes' sub-agents are slow on cheap models. Heavy parallel work needs Opus, which is expensive. For compute-heavy tasks, use a coding harness or a dedicated service.

**Marketing copy and creative writing.** Hermes can do it but the channel-voice alignment is harder. Use a chat interface with a Tier 2 model for one-shot creative work.

### Step 6 — When to combine with Claude Code

The most common pattern: Hermes for the research and orchestration, Claude Code for the production code.

**Example:**
- Hermes drafts the spec for a new feature based on user feedback (research + writing).
- Claude Code implements the feature (production code).
- Hermes tests the feature against the spec (verification).
- Claude Code merges to main.

This combination is the channel's documented bet: "Use coding harnesses (Claude Code, Kilo Code) for any code-producing work; treat general agent harnesses (Hermes, OpenClaw) as long-running assistants."

---

## 3. Comparison & Decision Framework

| Project type | Use | Why |
|---|---|---|
| Research and writing | Hermes | Skill Bundles + cron |
| Daily automation | Hermes | Cron + Skills |
| Multi-channel workflow | Hermes | MCP catalog |
| Production software | Claude Code | Coding harness |
| UI design | Cursor + AI | IDE-integrated |
| Real-time heavy compute | Dedicated service | Hermes sub-agents too slow |
| Marketing copy | Chat interface | One-shot creative |
| Combinations (e.g. research → ship) | Hermes + Claude Code | Channel's documented bet |

**Decision guide:**
- **If your project amplifies a routine you already do** → Hermes.
- **If your project ships code to users** → Claude Code.
- **If your project does both** → Hermes for orchestration, Claude Code for shipping.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Using Hermes to ship production software

- **Symptom:** You build a web app in Hermes. The code is buggy. Users complain.
- **Cause:** Hermes is not optimised for production code. It doesn't run tests the way Claude Code does.
- **Fix:** Use Claude Code / Kilo Code for production software. Use Hermes for the orchestration around it.

### Pitfall 2 — Skipping the project structure

- **Symptom:** You run Hermes without an `agents.md` or clear working directory. Output is inconsistent.
- **Cause:** Hermes relies on project context to produce good output.
- **Fix:** Set up project structure first. `agents.md` is the bare minimum.

### Pitfall 3 — Running too many parallel agents

- **Symptom:** Your cron job burns through tokens for hours.
- **Cause:** Hermes sub-agents are slow on cheap models (covered in Hermes L06 / L08).
- **Fix:** Limit sub-agent delegation. Set iteration caps.

### Pitfall 4 — Not using Skills

- **Symptom:** You write the same prompt every day. Drift creeps in.
- **Cause:** You're using Hermes as a chat interface, not as an agent.
- **Fix:** Write Skills. Codify the workflow. Bundle them.

### Pitfall 5 — Forgetting to review cron output

- **Symptom:** Your cron job has been failing silently for weeks.
- **Cause:** You didn't log to a file. You didn't review the log.
- **Fix:** Always log to a file. Always review after the first scheduled run.

### Pitfall 6 — Assuming Hermes replaces your judgement

- **Symptom:** You ship Hermes-generated research without reading it. It's wrong.
- **Cause:** Trust in AI.
- **Fix:** Hermes is leverage on top of your judgement. You still review the output.

---

## 5. Key Takeaways & Ron's Bottom Line

- Hermes is for research, daily automation, and multi-channel workflows.
- Claude Code is for production software.
- The most common pattern: Hermes for orchestration, Claude Code for shipping.
- Start with research projects. Skill Bundles make them easy.
- Always set up project structure (`agents.md`) before automating.
- Always log cron output and review it.
- Always review Hermes output. It's leverage on your judgement, not a replacement.
- "AI agents are leverage on top of a pre-existing human advantage (network, niche knowledge), not pure automation that replaces the founder." — `Specs/ChannelIdentity.md`

> 🟦 **Ron's Bottom Line** — Hermes is for amplifying what you already do. If you don't have a daily routine to automate, don't build a Hermes project. If you do, write a Skill, set a cron, review the output. Use Claude Code for the production code. The combination is the channel's bet.

---

## 6. Hands-On Practice

### Exercise

**Task:** Pick one daily task you do manually. Build a Hermes Skill that does it. Set a cron job to run it daily. Review the output.

**Success criteria:** The cron job runs at the scheduled time. The output is saved to a known location. You actually use it.

### Do this today

- [ ] Pick a daily task (research summary, link archive, morning briefing, etc.).
- [ ] Write a Skill file for it.
- [ ] Group it into a Bundle if needed.
- [ ] Set a cron job.
- [ ] Log to a file.
- [ ] Verify after the first scheduled run.
- [ ] Document the workflow in your `agents.md`.

### What's next

- Next lesson: **L04 — Niche Directory Sites** — a Hermes-friendly business case study.
- Related: **Hermes module L08** — automation patterns in depth.
- Related: **AI model comparison module L05** — pick the right model tier.

> 💬 Drop your "I automated my morning briefing with Hermes" story in the Discord.

---

## 7. Self-Check / Mini-Quiz

**Q1.** The right project type for Hermes is:
- A) Production web app
- B) Daily research and writing workflow
- C) Pixel-perfect UI design
- D) Real-time heavy compute

**Q2.** Short answer: What is `agents.md` and why does it matter?

**Q3.** For shipping production software, the channel's recommendation is:
- A) Use Hermes
- B) Use Claude Code / Kilo Code
- C) Use ChatGPT
- D) Don't use AI

**Q4.** Short answer: What's the most common combination pattern for Hermes + Claude Code?

**Q5.** Multiple choice: The biggest mistake beginners make with Hermes projects is:
- A) Not setting up project structure
- B) Using the wrong model
- C) Not running enough parallel agents
- D) Using the Desktop App

**Q6.** Short answer: Why is reviewing Hermes output important?

### Answers

**A1.** B — Daily research and writing workflow. Hermes is built for orchestration, not production code.

**A2.** `agents.md` is a markdown file in your working directory that captures Hermes' persistent context. Without it, Hermes has no project memory.

**A3.** B — Use Claude Code / Kilo Code. Per `Specs/ChannelIdentity.md`: "Use coding harnesses for any code-producing work."

**A4.** Hermes for research and orchestration. Claude Code for the production code. Hermes drafts the spec, Claude Code implements, Hermes verifies.

**A5.** A — Not setting up project structure. Without `agents.md` and clear working directory, output is inconsistent.

**A6.** Hermes is leverage on your judgement, not a replacement. You still review the output.

**Scoring:** 5–6 correct → ready for L04. 3–4 → re-read Steps 1 and 6. 0–2 → restart the Hermes module.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Hermes module** — the foundational material. L01–L09 cover concepts, install, TUI/Desktop, Skills, MCPs, security, automation, alternatives.
- **AI model comparison module** — for picking the right model tier.
- **Channel beliefs** — `Specs/ChannelIdentity.md` in this repo.

### Glossary

- **`agents.md`** — the markdown file in your working directory that captures Hermes' persistent context.
- **Skill** — a markdown file that tells Hermes how to do one specific job.
- **Skill Bundle** — a named group of Skills that loads together.
- **Cron job** — a scheduled task.
- **MCP** — Model Context Protocol. Standard for connecting AI agents to outside apps.
- **Loop** — when the agent retries a task until a success check passes.

### Go deeper

- **Want to set up a Skill?** → Hermes module L04.
- **Want to set up an MCP?** → Hermes module L05.
- **Want to schedule a cron job?** → Hermes module L08.
- **Want to ship production code?** → L01: Coding with Claude Code.

---

## 9. FAQ

**Q: What can I build with Hermes?**
A: Research workflows, daily automation, multi-channel orchestration. Not production software or pixel-perfect UI.

**Q: Should I build in Hermes or Claude Code?**
A: Hermes for orchestration and automation. Claude Code for production software. Often both.

**Q: How long does a Hermes project take?**
A: A research workflow: 1–2 hours to set up, runs forever after. A daily cron: 30 minutes. A multi-channel workflow: 2–4 hours.

**Q: Can Hermes replace a human assistant?**
A: No. Per `Specs/ChannelIdentity.md`: "AI agents are leverage on top of a pre-existing human advantage." Hermes amplifies, doesn't replace.

**Q: How do I know if my project fits Hermes?**
A: Ask: does this project amplify a routine I already do? If yes, Hermes. If no, find another tool.