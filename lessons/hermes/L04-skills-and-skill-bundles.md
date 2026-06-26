# Hermes Agent Skills and Skill Bundles Explained for Beginners (2026)

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

After a few sessions of asking Hermes one-off questions, you'll notice a pattern: you keep asking the same kind of thing. "Summarise this article." "Format this as a table." "Search GitHub for the issue and reply with the link." Skills let you stop re-asking. Skill Bundles let you group skills so one command replaces five.

In this lesson you'll learn what a Skill is, what a Skill Bundle is, how to make your first one, and how to avoid the gotcha that makes bundles silently less useful than they look.

### Who this is for

A Hermes user who has run a few sessions and wants to teach the agent recurring tasks without re-explaining them every session. You are comfortable running slash commands in the TUI (L03).

### Who this is NOT for

Anyone who hasn't installed Hermes yet (L02). This lesson assumes muscle memory with the TUI.

### What you'll be able to do

- Create a Skill file and invoke it with a slash command.
- Group related Skills into a Skill Bundle for one-line invocation.
- Avoid the "skill that doesn't actually trigger" failure mode that wastes your time.

### Learning Objectives

- Explain what a Skill is, where it lives on your computer, and how Hermes finds it.
- Create a Skill Bundle that groups three or more related skills.
- Invoke a Skill Bundle with a single slash command.
- Decide whether to create a Skill, a Bundle, or just type the prompt directly.

### Time estimate

14-minute read + 30-minute hands-on practice

### Prerequisites

- L02: Install & first run
- L03: TUI vs Desktop App

### Why this matters in 2026

Hermes shipped Skill Bundles in May 2026. Before Bundles, you'd invoke skills one at a time as you thought of them. The problem: AI agents are *probabilistic*. They don't reliably pick the right skill for a multi-step task just because you described the task in natural language. Bundles solve this by saying explicitly "when I type this command, load these skills together." The whole point is to make multi-step workflows reliable.

---

## 2. Core Content

### Chapters

- `00:00` — Why "ask the agent to do the whole thing" doesn't work
- `02:00` — What a Skill is (and where it lives)
- `04:30` — What a Skill Bundle is
- `07:00` — Build your first Bundle step-by-step
- `09:30` — Are Bundles adaptive? (The honest answer)
- `11:00` — How to use Bundles day-to-day

> 💡 **Ron's Pro Tip** — When you build a Bundle, *consult with Hermes first*. Ask the agent which skills it would group for your workflow, then review the plan, then commit. Bundles that you design by yourself are usually worse than Bundles you co-design with the agent.

### Step 1 — Why "ask the agent to do the whole thing" doesn't work

Hermes is *probabilistic*. That means for the same prompt, it might pick different skills on different runs. If your task is "do my morning research workflow" and that workflow needs five skills (discovery, extraction, organisation, analysis, output), the agent might use only three of them on a given run. The result will feel inconsistent.

The traditional workaround: invoke the skills one at a time, manually, as you think of them. That works but is slow and burns through your context window.

**The better solution: Skills + Bundles.** Make each skill a named file the agent *must* use. Group them in a Bundle so one command loads them all.

> Source: `_A02brv2Csg` — "AI agents are probabilistic in nature. You cannot assume that they know all of the skills you want them to use to finish those tasks. They might leave out two, three skills out of the five skills that you need them to finish that task. So, basically, skill bundles is a way to fix that by giving you a named set of skills behind the slash bundles command."

### Step 2 — What a Skill is

A Skill is a small markdown file that tells Hermes how to do one specific job. Skills live in `~/.hermes/skills/`. Each file has a name that becomes its slash command.

When you type `/standup` in Hermes, the agent reads the file `~/.hermes/skills/standup.md` and follows whatever instructions are in it. If `standup.md` says "summarise the last 24 hours of my Discord activity and format it as three bullets," then `/standup` does exactly that.

You can write Skills by hand (they're just markdown) or you can ask Hermes to write one for you based on a successful workflow. The latter is the magic moment — Hermes notices it did something useful and saves the recipe so it can do it again next time.

> Source: `_A02brv2Csg` — "Take the official documentation and say, 'Can you create a skill bundles for this so I can load them up with one slash command whenever I need general research.' Take a look at the skill bundles documentation and create it accordingly."

### Step 3 — What a Skill Bundle is

A Skill Bundle is a named group of Skills that loads them all at once. It lives as a small YAML file under `~/.hermes/skill-bundles/`. The format is roughly:

```yaml
name: research
description: General-purpose research workflow
skills:
  - web-discovery
  - article-extraction
  - topic-organisation
  - synthesis-analysis
  - report-output
instruction: |
  When invoked, produce a research report covering the topic end-to-end.
  Use the discovery skills first, then extraction, then organisation, then
  analysis, then output. Include citations.
```

When you type `/research` in Hermes, it loads all five skills and runs the instruction. The agent knows exactly which skill to use in which order because you told it.

The `instruction` field is a "mini agents.md" — it captures your habits and conventions for this workflow so you don't have to retype them every time.

> Source: `_A02brv2Csg` — "The instruction is where you bake in your house rules. So, it's sort of like a mini agents.md. So, you don't have to type that context over and over whenever you invoke the this skill bundle."

### Step 4 — Build your first Bundle step-by-step

**Step 4.1 — Update Hermes.** Make sure you're on a recent version. The Bundle feature shipped in May 2026; if your install is from before that, run `hermes update` first.

**Step 4.2 — Run the bundle command.** In the TUI, type:

```
/bundles
```

You'll see a list of existing bundles (probably empty) and create / list / reload options.

**Step 4.3 — Create a Bundle.** Run:

```
hermes bundles create research
```

Replace `research` with whatever workflow you're building. Hermes will prompt you to pick the skills you want in the bundle.

**Step 4.4 — Co-design with Hermes.** Instead of picking skills blind, ask Hermes first:

> "Suggest which skills we need to bundle for a general research workflow."

Hermes will read its own skill catalog and propose a grouping. Review the plan. If it looks right, commit. If not, iterate.

> Source: `_A02brv2Csg` — "So, my Hermes took a look at its skills, and the assessment is pretty large just for a general research workflow. There's even four phases, four skills for discovery, three skills for extraction, three skills for organisation, three skills for analysis, and five skills for output. So, the recommendation here is to create one umbrella skill."

**Step 4.5 — Edit the YAML.** Open `~/.hermes/skill-bundles/<your-bundle>.yaml` and add the `instruction` field. This is your house rules — the conventions Hermes should follow when this Bundle is invoked.

**Step 4.6 — Reload and test.** Run:

```
hermes bundles reload
```

Then invoke your Bundle with `/research` (or whatever you named it). Watch the system message — Hermes should announce "User has invoked the research skill bundle."

> Source: `_A02brv2Csg` — "There we go. So, that's what you want to see. Instead of having to invoke one skill at a time, so they're all bundled together, and the agent knows exactly which skill to use depending on where it is in the task."

### Step 5 — Are Bundles adaptive? (The honest answer)

The source video asks this directly: are the skills in a Bundle run sequentially in a fixed order, or does Hermes adapt?

**The honest answer: not adaptive yet, as of June 2026.** Bundles run in the order you specify (or in the order Hermes picks when co-designing). They don't dynamically re-order based on intermediate results.

This is a real limitation. If your workflow needs different skills depending on what the agent discovers, a Bundle alone won't handle it. The workaround is to either:
1. Break the workflow into multiple Bundles and chain them manually.
2. Write a single Skill with branching logic inside (more advanced; covered in advanced tutorials).
3. Wait — adaptive Bundles are a likely roadmap item.

> Source: `_A02brv2Csg` — "So far in the documentation I don't see any mentions that it is adaptive. But in any case, I think that's why it's very important to consult with your Hermes agent first."

### Step 6 — How to use Bundles day-to-day

Once you have a few Bundles built, the day-to-day habit is:

- **Morning:** `/research <topic>` — your research Bundle does the morning news scan.
- **Before standup:** `/standup` — your standup Bundle summarises overnight agent activity.
- **Before code review:** `/pr-review` — your code review Bundle pulls the PR diff and gives you a critique.
- **End of day:** `/wrap-up` — your wrap-up Bundle commits any uncommitted work and drafts tomorrow's TODO.

The pattern: one Bundle per recurring workflow. Don't over-Bundle. Three to five Bundles covers most daily-driver use.

> Source: `_A02brv2Csg` — "Lastly, if you're working with a team and you want to share those skill bundles what you can do is you can commit the bundle files into your dot files or a shared repo."

---

## 3. Comparison & Decision Framework

This lesson is not a comparison — it's a how-to. The comparison (Hermes vs Claude Code vs Mavis) lives in L09.

| Should I make a Skill, a Bundle, or just type the prompt? | Answer |
|---|---|
| One-off task you'll never repeat | Just type the prompt. No Skill needed. |
| Task you've done three times and want to remember | Make a Skill. |
| Task that needs three or more Skills together | Make a Bundle. |
| Multi-step workflow with fixed order | Bundle. |
| Multi-step workflow that needs branching | Multiple Bundles or one Skill with branching. |
| Workflow that's the same for your whole team | Commit the Bundle YAML to a shared repo. |

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Skills that don't trigger

- **Symptom:** You type `/standup` and the agent responds as if you asked a fresh question.
- **Cause:** The Skill file is in the wrong location, has a typo in its name, or the slash command doesn't match the filename.
- **Fix:** Check that `~/.hermes/skills/<name>.md` exists and matches the slash command exactly. Hermes is strict about filenames.

### Pitfall 2 — Bundles that aren't adaptive

- **Symptom:** You expected the Bundle to pick the right skill based on intermediate results, but it ran them in a fixed order.
- **Cause:** Bundles are not adaptive as of June 2026.
- **Fix:** Break the workflow into multiple Bundles, or write a single Skill with branching logic. Don't expect adaptive ordering.

### Pitfall 3 — Modifying the wrong file

- **Symptom:** Your edits to a Skill don't seem to take effect.
- **Cause:** Skills live in `~/.hermes/skills/`. There can be a backup or a duplicate in a different location.
- **Fix:** Run `find ~ -name "*.md" -path "*hermes*" | grep skills` to see all Skill files. Edit the canonical one.

### Pitfall 4 — Skill sprawl

- **Symptom:** You have 50 Skills, half of which you never use.
- **Cause:** Skill creation is easy; cleanup is not.
- **Fix:** Use the Hermes Curator feature (mentioned in the L04 backlog) to find and merge duplicate Skills. Delete the ones you haven't used in 30 days.

### Pitfall 5 — Skipping the auto-creation warning

- **Symptom:** Hermes creates a Skill file based on something you did, and you didn't expect it.
- **Cause:** Hermes has an "auto-skill" feature where it writes a Skill file after a successful workflow.
- **Fix:** This is a feature, not a bug. But check `~/.hermes/skills/` periodically so you know what's there.

### Pitfall 6 — Bundle instructions that contradict each other

- **Symptom:** The Bundle's behaviour is inconsistent because the `instruction` field says two different things.
- **Cause:** You wrote the instruction at different times and forgot to update earlier parts.
- **Fix:** Re-read the entire `instruction` field after editing. Delete contradictions.

---

## 5. Key Takeaways & Ron's Bottom Line

- A Skill is a named markdown file that tells Hermes how to do one specific job. Invoke it with `/<name>`.
- A Skill Bundle groups Skills together so one slash command loads them all.
- Bundles fix the "AI agents are probabilistic" problem by making skill use explicit.
- Bundles are *not adaptive* as of June 2026 — they run skills in a fixed order.
- The `instruction` field in a Bundle YAML is your "mini agents.md" — bake your house rules in once.
- Co-design Bundles with Hermes. Ask the agent to suggest the grouping, then review and commit.
- Commit Bundle YAMLs to a shared repo if your team should use the same ones.

> 🟦 **Ron's Bottom Line** — Make a Skill the third time you do a task. Bundle it when you have three or more Skills that always go together. Don't over-Bundle — three to five Bundles covers most daily-driver work. The `instruction` field is where you save yourself the most typing: bake your house rules in once and you stop re-explaining them every session.

---

## 6. Hands-On Practice

### Exercise

**Task:** Build your first Skill Bundle. Pick a recurring workflow you do at least once a week (morning research, end-of-day wrap-up, weekly report, etc.). Use `hermes bundles create` and ask Hermes to suggest the skills. Write a YAML Bundle with at least three skills and a clear `instruction` field. Test it three times.

**Success criteria:** All three test invocations produce consistent output (same structure, same sections, same level of detail). If they vary wildly, your `instruction` field needs more specificity.

### Do this today

- [ ] List the Skills currently in `~/.hermes/skills/`. Delete any you don't use.
- [ ] Identify one recurring task you do at least weekly.
- [ ] Run `hermes bundles create <task-name>` and pick three or more Skills.
- [ ] Edit the YAML to add a clear `instruction` field.
- [ ] Test the Bundle three times. Refine the instruction until output is consistent.
- [ ] Commit the Bundle YAML to a git repo if you'll share it with a team.

### What's next

- Next lesson: **L05 — How to Connect Hermes Agent to Other Apps with the MCP Catalog** — once you have daily-driver Skills and Bundles, you'll want Hermes to talk to GitHub, Linear, Notion, etc.
- Related: **L08 — Hermes Agent Automation: Cron, Kanban, Sub-Agents** — covers scheduled Bundle invocations.

> 💬 Drop your favourite Bundle YAML (or a screenshot of it) in the Discord. I review the best ones.

---

## 7. Self-Check / Mini-Quiz

**Q1.** A Skill Bundle is best described as:
- A) A single powerful skill
- B) A group of skills invoked with one command
- C) A model
- D) A feature of the desktop app

**Q2.** Short answer: Per the source, are Bundles adaptive to context? (Yes / No — explain.)

**Q3.** The first thing to do if your Skill isn't triggering is:
- A) Delete and recreate it
- B) Check that the filename matches the slash command and lives in `~/.hermes/skills/`
- C) Install a different model
- D) Switch to the desktop app

**Q4.** Short answer: Where do Hermes Skills live on your computer?

**Q5.** The `instruction` field in a Bundle YAML is best described as:
- A) Optional metadata
- B) A "mini agents.md" that captures your house rules
- C) The model name to use
- D) A list of available skills

**Q6.** Multiple choice: Per the source, the best way to design a Bundle is:
- A) Pick the skills yourself based on what you think is right
- B) Ask Hermes to suggest the skills, then review and commit
- C) Use all available skills in one Bundle
- D) Copy a Bundle from the Hermes docs

### Answers

**A1.** B — A group of skills invoked with one command. Bundles replace the need to invoke skills individually.

**A2.** No. Bundles run skills in a fixed order as of June 2026. They are not adaptive to intermediate results.

**A3.** B — Check the filename and location. Hermes is strict about Skill filenames matching slash commands.

**A4.** `~/.hermes/skills/<name>.md`. Each Skill is a markdown file in that directory.

**A5.** B — A "mini agents.md" that captures your house rules. The instruction is where you bake in conventions so Hermes does the right thing by default.

**A6.** B — Ask Hermes to suggest the skills, then review and commit. The source video explicitly recommends co-designing Bundles with the agent.

**Scoring:** 5–6 correct → ready for L05. 3–4 → re-read Steps 3 and 4. 0–2 → rewatch the primary video.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Primary video** — `Hermes Agent NEW Skill Bundles (Setup Guide)` (`_A02brv2Csg`, 612s, May 2026). The whole lesson is grounded in this video.
- **Concept clip** — `Hermes Agent NEW Skill: The Simplest Explanation of Skill Bundles` (`8ieTyrnCHYY`, 63s, May 2026) — a 1-minute overview if you want a TL;DR.
- **Auto-creation clip** — `Hermes Agent NEW Skill: It Built Two Skill Bundles Without Being Asked` (`kuG5Z_MD-2U`, 64s, May 2026) — shows Hermes auto-creating Bundles from successful workflows.
- **Gotcha clip** — `Hermes Agent NEW Skill: Are Bundled Agent Skills Actually Adaptive` (`1p0X7xqDxhw`, 54s, May 2026) — the honest answer about non-adaptive Bundles.
- **Curator feature** — `Hermes Agent: See Every Skill Your AI Agent Has—Instantly` (`SqO-nVIARy0`, 61s, April 2026) — useful for cleaning up Skill sprawl.

### Glossary

- **Skill** — a markdown file in `~/.hermes/skills/` that tells Hermes how to do one specific job. Invoked with `/<name>`.
- **Skill Bundle** — a named group of Skills that loads together. Stored as YAML in `~/.hermes/skill-bundles/`.
- **Slash command** — a `/` followed by a name. The TUI parses this and loads the corresponding Skill or Bundle.
- **Probabilistic** — when the same prompt can produce different results on different runs. AI agents are probabilistic; Skills and Bundles make their behaviour more deterministic.
- **`agents.md`** — a markdown file in your working directory that captures the agent's persistent context. Bundles have a "mini agents.md" in their `instruction` field.
- **Auto-skill creation** — when Hermes writes a new Skill file based on a successful workflow. Surprising the first time it happens.
- **YAML** — a configuration file format using indentation. Hermes uses YAML for Bundle definitions.
- **Co-design** — designing something (like a Bundle) *with* the agent rather than alone. The source video explicitly recommends this for Bundles.

### Go deeper

- **Want to schedule a Bundle to run automatically?** → `L08 — Hermes Agent Automation: Cron, Kanban, Sub-Agents`.
- **Want your Bundle to talk to GitHub, Linear, or Notion?** → `L05 — How to Connect Hermes Agent to Other Apps with the MCP Catalog`.
- **Want to share Bundles with your team?** → Commit the YAML files to a shared repo. The source video recommends this explicitly.

---

## 9. FAQ

**Q: Can a Skill call another Skill?**
A: Yes — list the second Skill in the first Skill's instructions, or include both in the same Bundle.

**Q: How do I list all my installed Skills?**
A: Run `/bundles list` in the TUI, or `ls ~/.hermes/skills/` in your terminal.

**Q: Can the agent create new Skills on its own?**
A: Yes — Hermes has an auto-skill creation feature. After a successful workflow, it can save the recipe as a Skill. Check `~/.hermes/skills/` periodically.

**Q: What's the difference between a Skill and a slash command?**
A: They're the same thing. The slash command is the trigger; the Skill file is the content. `/standup` is the slash command; `~/.hermes/skills/standup.md` is the Skill.

**Q: Can I edit a Bundle without re-running `hermes bundles create`?**
A: Yes — edit the YAML directly. Then run `hermes bundles reload` to pick up your changes.

**Q: How many Skills should a Bundle have?**
A: Three to seven is a good range. Fewer than three is usually better as individual Skills. More than seven is hard to maintain.

**Q: Can I share Bundles between machines?**
A: Yes — commit the YAML files to a git repo and pull them on your other machines. The source video recommends this for teams.

**Q: What happens if two Bundles have the same name?**
A: Hermes will use the last one loaded. Pick unique names.