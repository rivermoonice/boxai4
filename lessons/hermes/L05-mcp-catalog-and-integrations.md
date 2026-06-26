# How to Connect Hermes Agent to Other Apps with the MCP Catalog (2026)

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

Once Hermes is your daily driver, you'll want it to do more than chat. You'll want it to read GitHub issues, post to Linear, fetch a Notion page, or trigger an n8n workflow. That's what **MCP** is for — Model Context Protocol, the standard that lets an AI harness talk to outside apps.

Hermes shipped a built-in **MCP Catalog** in May 2026 that lets you install pre-approved MCP servers with one command. Before the catalog, you had to hunt down GitHub repos, copy JSON snippets into `config.yaml`, manage API keys yourself, and hope the code was safe. After the catalog, it's four commands.

In this lesson you'll learn what an MCP is, how to install one from the catalog, and how to whitelist only the tools you actually need.

### Who this is for

A Hermes user who has the TUI muscle memory (L03) and wants the agent to talk to outside apps — GitHub, Linear, Notion, Discord, etc.

### Who this is NOT for

Anyone who hasn't installed Hermes yet (L02). This lesson assumes you've sent a few messages.

### What you'll be able to do

- Explain what an MCP is, in plain English.
- Install an MCP from the built-in catalog in under five minutes.
- Whitelist only the specific tools you want exposed, instead of giving an MCP full access.

### Learning Objectives

- Use the four commands that make up the MCP catalog workflow.
- Install an MCP from the catalog (Linear or n8n as of June 2026).
- Configure which tools a specific MCP exposes to your agent.
- Add a custom MCP for an app the catalog doesn't yet cover.

### Time estimate

12-minute read + 30-minute hands-on practice

### Prerequisites

- L02: Install & first run
- L03: TUI vs Desktop App

### Why this matters in 2026

The MCP catalog shipped in May 2026 and made connecting Hermes to outside apps dramatically safer. Before the catalog, installing a random community MCP was the main attack vector for new users — you'd copy a JSON snippet from a GitHub repo, paste it into your config, and hope it wasn't malicious. The catalog fixes this by requiring every entry to pass a PR review by the Hermes team.

**Important freshness note:** as of June 2026, the catalog ships **Linear and n8n only**. GitHub was expected but is disabled. This list will change — check the catalog with `hermes mcp` after every `hermes update`.

---

## 2. Core Content

### Chapters

- `00:00` — What an MCP actually is (in plain English)
- `02:00` — Why the catalog is safer than the old way
- `04:00` — The four commands you need to know
- `06:00` — Install Linear from the catalog step-by-step
- `08:30` — Install n8n from the catalog
- `10:00` — Add a custom MCP for an app the catalog doesn't cover
- `11:30` — When MCPs go wrong (and how to recover)

> 💡 **Ron's Pro Tip** — Use the catalog for your first MCP install. Once you're comfortable, you can install custom MCPs from the community. Beginners should not skip the catalog step.

### Step 1 — What an MCP actually is

An **MCP** (Model Context Protocol) is a small server program that lets an AI agent talk to one specific outside app. Each MCP speaks one app's API: there's a Linear MCP, a GitHub MCP, a Notion MCP, etc.

When you install the Linear MCP, your agent can read issues, create tickets, and update projects in Linear — all through natural language in the Hermes chat. The MCP is the bridge between Hermes (the harness) and Linear (the app).

MCPs run as separate processes on your machine. They have credentials (API keys or OAuth tokens) and a list of "tools" they expose (e.g. `find_issues`, `create_issue`, `update_status`).

> Source: `IMO8ooIqONM` — "What this update entails is we get a curated list of MCP servers that live in the optional MCPs directory in the official repo. And every single one is reviewed by the News research team before it ships."

### Step 2 — Why the catalog is safer than the old way

Before the catalog, installing a custom MCP looked like this:

1. Find a random MCP server on GitHub.
2. Read its README to find the right command and env variables.
3. Copy them into your `config.yaml`.
4. Generate an API key from the app.
5. Paste the key into your config.
6. Hope the code is safe.

The catalog replaces steps 1–3 with one command. The Hermes team reviews every entry's source code and bootstrap commands before it ships. If you only ever install catalog MCPs, you're running code the team has personally audited.

> Source: `IMO8ooIqONM` — "If you want to try out MCPs, we recommend that you try out first from their catalog, and then once you get a better feel for it, then you can expand to, you know, installing your own custom MCP servers."

> ⚠️ **Gotcha** — The catalog only ships Linear and n8n as of June 2026. Don't assume the catalog is comprehensive. If you need GitHub, Notion, Discord, etc., you'll need a custom MCP (Step 7) until the catalog adds them.

### Step 3 — The four commands you need to know

The whole MCP catalog workflow is four commands. Memorise these.

**`hermes update`** — pulls the latest Hermes release, including the latest catalog manifests.

**`hermes mcp`** — shows the catalog. Lists every approved MCP server with its name and a short description.

**`hermes mcp install <name>`** — installs a specific MCP from the catalog. Prompts you for credentials and shows a tool whitelist.

**`hermes mcp configure <name>`** — re-opens the tool whitelist for an installed MCP so you can change permissions later.

That's it. Four commands.

> Source: `IMO8ooIqONM` — "The commands are very simple. You just need to remember these four."

### Step 4 — Install Linear from the catalog step-by-step

Linear is the cleanest first MCP install because it uses OAuth (no API key to copy/paste).

**Step 4.1 — Update Hermes.** Run `hermes update` to pull the latest catalog.

**Step 4.2 — Check the catalog.** Run `hermes mcp`. You should see at least Linear and n8n listed.

**Step 4.3 — Install Linear.** Run `hermes mcp install linear`. Hermes will:
1. Show you a link to authenticate with Linear.
2. Click the link, log in to your Linear workspace, and grant access.
3. Return you to Hermes, which now shows you the **tool whitelist**.

**Step 4.4 — Whitelist your tools.** By default, "find issues," "create issues," and similar safe tools are checked. Dangerous tools like "delete workspace" are unchecked. Review the list. Toggle what you want.

**Step 4.5 — Save.** Hit enter. The OAuth tokens are cached in `~/.hermes/mcp-tokens/linear.json`. You're done.

Now you can ask Hermes: "Find all issues assigned to me in Linear this week." The agent will use the Linear MCP under the hood.

> Source: `IMO8ooIqONM` — "If you've used Linear before, you can now connect your Hermes to your Linear workspace to search issues, create tickets, and manage projects just using natural language on your TUI."

### Step 5 — Install n8n from the catalog

n8n is the second catalog entry. It's useful if you already have n8n workflows running and want Hermes to inspect, trigger, or edit them.

**Step 5.1 — Run `hermes mcp install n8n`.**

**Step 5.2 — Provide credentials.** n8n uses an API key, not OAuth. Hermes will prompt for your n8n base URL (e.g. `https://your-n8n.example.com`) and your API key. The credentials are written to `~/.hermes/.env` automatically.

**Step 5.3 — Probe your instance.** Hermes will inspect your n8n instance and list every workflow, execution, and tool your n8n exposes.

**Step 5.4 — Pick the tools.** Same as Linear — toggle which tools the agent can call.

> Source: `IMO8ooIqONM` — "You can let your Hermes inspect, trigger, and edit your N8N workflows. So, this is mostly for people who already have a working workflow on N8N."

### Step 6 — Add a custom MCP for an app the catalog doesn't cover

GitHub isn't in the catalog as of June 2026. To connect Hermes to GitHub today, you need a custom MCP. Two paths:

**Path A — Use an established community MCP.** The Hermes ecosystem has community-maintained MCPs for GitHub, Notion, Discord, Telegram, etc. Check the Hermes docs or community Discord for the current list.

Install pattern:

1. Find the MCP server's repo (e.g. `github.com/<author>/hermes-github-mcp`).
2. Read the README for the exact `command` and `env` variables.
3. Add a new entry to your `~/.hermes/mcp.yaml` with the command and env.
4. Add your API key to `~/.hermes/.env`.
5. Run `hermes mcp reload`.
6. Test by asking Hermes to do something the MCP supports.

**Path B — Write your own MCP.** Advanced. The Model Context Protocol has a Python SDK. You write a small server that wraps the app's API and exposes it as MCP tools. Cover this in a future lesson.

> Source: `IMO8ooIqONM` — "That's how the normal way works. You'd find a random MCP server on GitHub, and then you take a look at its readme file, you'd copy the command args and env variables into your config.yaml file. Then you have to manage the API keys yourself, and then you'd have to hope that the code is safe."

### Step 7 — When MCPs go wrong (and how to recover)

MCPs run as separate processes with credentials. When one misbehaves, here's how to recover.

**Symptom:** Agent says it can't reach the MCP. **Fix:** Check the MCP's status with `hermes mcp`. Look at the credentials in `~/.hermes/.env` — they may have expired.

**Symptom:** Agent is calling tools you didn't whitelist. **Fix:** Run `hermes mcp configure <name>` and re-tighten the tool list. This is the single most important defensive habit.

**Symptom:** MCP is hammering the API (rate limit errors). **Fix:** Most MCPs have rate-limit handling. If yours doesn't, add it or uninstall the MCP until a fixed version is available.

**Symptom:** You don't recognise the MCP or don't remember installing it. **Fix:** Run `hermes mcp list` and uninstall anything you don't recognise with `hermes mcp uninstall <name>`.

---

## 3. Comparison & Decision Framework

This lesson is not a comparison — the comparison (Hermes vs Claude Code vs Mavis) lives in L09. The decision here is whether to use the catalog or a custom MCP.

| Should I use the catalog or a custom MCP? | Answer |
|---|---|
| The app I need is in the catalog | Use the catalog. Always. |
| The app isn't in the catalog but has a community MCP | Check the repo's reputation. If it's well-maintained and widely used, install it carefully. |
| The app isn't in the catalog and has no community MCP | Write your own, or wait for the catalog. |
| I'm a beginner | Stick to the catalog. Don't install custom MCPs until you're comfortable with how they work. |

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Assuming the catalog has GitHub, Notion, Discord, etc.

- **Symptom:** You run `hermes mcp install github` and get "not in manifest."
- **Cause:** The catalog is small as of June 2026. Only Linear and n8n ship.
- **Fix:** Run `hermes mcp` to see the current list. Use a community MCP for apps not in the catalog (carefully).

### Pitfall 2 — Whitelisting every tool by default

- **Symptom:** The MCP exposes "delete workspace" and you didn't uncheck it. The agent deletes something by accident.
- **Cause:** The default whitelist is sensible but not minimal. "Delete" tools are unchecked by default, but other dangerous tools may not be.
- **Fix:** Review the tool list carefully during install. Re-run `hermes mcp configure <name>` to tighten later.

### Pitfall 3 — Using the desktop app for MCP-heavy sessions in v0.16

- **Symptom:** MCPs are hard to find or toggle from the Desktop App.
- **Cause:** Source video flags MCP discoverability in the Desktop App as a v0.16 weakness.
- **Fix:** Use the TUI for MCP-heavy work. The Desktop App will catch up.

### Pitfall 4 — Forgetting to scope the API key

- **Symptom:** Your Linear API key has full workspace access. A malicious or buggy agent can do anything you can do in Linear.
- **Cause:** Beginners create API keys with the broadest possible scope.
- **Fix:** When creating the API key in the source app, use the most limited scope that still does the job. Read-only is safer than read-write.

### Pitfall 5 — Hard-coding MCP configs in the wrong place

- **Symptom:** You edit `~/.hermes/config.yaml` to add an MCP, but `hermes update` overwrites your changes.
- **Cause:** MCP configs live in `~/.hermes/mcp.yaml`, not `~/.hermes/config.yaml`.
- **Fix:** Always edit `mcp.yaml`. If you put MCP config in `config.yaml`, it'll get clobbered on update.

### Pitfall 6 — Installing a random community MCP without reading the source

- **Symptom:** The agent starts behaving strangely. You discover the MCP is exfiltrating data.
- **Cause:** The source video explicitly warns about this. Some community MCPs are malicious.
- **Fix:** Only install MCPs from reputable authors. Read the source code, or at least the issue tracker, before installing.

### Pitfall 7 — Letting OAuth tokens accumulate

- **Symptom:** You have 10 OAuth tokens cached in `~/.hermes/mcp-tokens/` from MCPs you no longer use.
- **Cause:** Tokens persist after you uninstall an MCP.
- **Fix:** Periodically review `~/.hermes/mcp-tokens/` and delete tokens for MCPs you've uninstalled.

---

## 5. Key Takeaways & Ron's Bottom Line

- An MCP is a small server that lets Hermes talk to one outside app. Each MCP speaks one app's API.
- The Hermes MCP Catalog is a curated list of pre-approved MCPs. It's safer than installing random community MCPs.
- As of June 2026, the catalog only ships Linear and n8n. The list will change — run `hermes mcp` after every `hermes update`.
- The catalog workflow is four commands: `hermes update`, `hermes mcp`, `hermes mcp install`, `hermes mcp configure`.
- Always whitelist only the specific tools you need. Don't accept the defaults blindly.
- Custom MCPs exist for GitHub, Notion, Discord, etc. — use them carefully, only from reputable sources.
- OAuth tokens cache in `~/.hermes/mcp-tokens/`. API keys cache in `~/.hermes/.env`. Clean these up periodically.

> 🟦 **Ron's Bottom Line** — Beginners should start with the catalog and only the catalog. The four commands are all you need. Once you're comfortable and you need an app the catalog doesn't cover, graduate to community MCPs from reputable authors. Don't accept default tool whitelists — review them every time. The catalog is the safest on-ramp; community MCPs are where you take real responsibility for what runs on your machine.

---

## 6. Hands-On Practice

### Exercise

**Task:** Install Linear from the catalog and run one real query against it.

**Success criteria:** You can ask Hermes "find issues assigned to me this week" and get back a real Linear result. The MCP is using a properly-scoped OAuth token, and you've reviewed the tool whitelist.

### Do this today

- [ ] Run `hermes update` to pull the latest catalog.
- [ ] Run `hermes mcp` to see what's available.
- [ ] If you use Linear, install it from the catalog. Otherwise, install n8n (you'll need an n8n instance).
- [ ] Review the tool whitelist carefully. Tighten if needed.
- [ ] Run one real query through the MCP.
- [ ] Run `hermes mcp configure <name>` to see how permissions can be tightened later.
- [ ] Check `~/.hermes/mcp-tokens/` and `~/.hermes/.env` to see where credentials live.

### What's next

- Next lesson: **L06 — How to Pick the Cheapest AI Model for Hermes Agent** — once you have MCPs, you'll want to control the cost of running them.
- Related: **L07 — How to Secure Your Hermes Agent** — required reading if you installed any MCP that touches production data.

> 💬 Drop a screenshot of your `hermes mcp` output in the Discord. I review the best ones.

---

## 7. Self-Check / Mini-Quiz

**Q1.** MCP stands for:
- A) Model Context Protocol
- B) Multi-Channel Plugin
- C) Master Control Program
- D) Managed Claude Pipeline

**Q2.** Short answer: As of June 2026, which two apps does the built-in MCP catalog ship with?

**Q3.** When installing a custom MCP, the safest thing to do is:
- A) Use the most permissive API key
- B) Use the most limited API key
- C) Reuse your personal root key
- D) Skip API auth

**Q4.** Short answer: Why is the desktop app a poor choice for MCP-heavy work in v0.16?

**Q5.** The four commands of the MCP catalog workflow are: (fill in the blanks)

**Q6.** Multiple choice: After uninstalling an MCP, you should:
- A) Nothing — Hermes cleans up automatically
- B) Manually delete the cached OAuth tokens in `~/.hermes/mcp-tokens/`
- C) Re-install the MCP
- D) Run `hermes update`

### Answers

**A1.** A — Model Context Protocol. It's the open standard that lets AI agents talk to outside apps.

**A2.** Linear and n8n. GitHub was expected but disabled as of June 2026. Check `hermes mcp` for the current list.

**A3.** B — Use the most limited API key. Read-only is safer than read-write. Scope to the minimum permissions needed.

**A4.** Discoverability for MCPs in the Desktop App is still rough in v0.16. The TUI has better tooling for managing MCPs as of this writing.

**A5.** `hermes update`, `hermes mcp`, `hermes mcp install <name>`, `hermes mcp configure <name>`.

**A6.** B — Manually delete the cached OAuth tokens. Uninstalling an MCP doesn't automatically clean up the credentials.

**Scoring:** 5–6 correct → ready for L06. 3–4 → re-read Steps 3 and 6. 0–2 → rewatch the primary video.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Primary video** — `Hermes Agent MCP Catalog Guide (NEW)` (`IMO8ooIqONM`, 484s, May 2026).
- **Launch announcement** — `Hermes Agent's HUGE New Update: Built-in MCP Catalog!` (`zhznE_jOFVY`, 52s, May 2026) — a 1-minute overview.
- **v0.16 Desktop UX video** — `Hermes Agent Update v0.16 is HUGE! (Surface Release)` (`c3bd0HiE3pg`, 672s, June 2026) — covers the Desktop App's MCP discoverability caveat.
- **Historical context** — `Hermes Agent Update v0.10 is POWERFUL! (Tool Gateway Release)` (`VIpMz5uz4Cc`, ?s, April 2026) — the v0.10 release that introduced the tool gateway architecture.

### Glossary

- **MCP (Model Context Protocol)** — an open standard that lets AI agents talk to outside apps (GitHub, Linear, Notion, etc.) in a uniform way. Like a USB port for AI.
- **MCP Catalog** — Hermes' built-in list of pre-approved MCP servers. Reviewed by the Hermes team. As of June 2026: Linear and n8n.
- **Tool whitelist** — the list of specific tools an MCP exposes to the agent. You choose during install and can change later.
- **OAuth** — an authentication flow where you click a link, log in to the app, and grant access. No API key to copy/paste.
- **API key** — a long string that authorises a service. Used when the app doesn't support OAuth.
- **Scope** — the permissions a key has. Read-only is safer than read-write.
- **Custom MCP** — an MCP not in the catalog, typically from a community repo. Higher risk, more flexibility.
- **OAuth token cache** — `~/.hermes/mcp-tokens/`. Stores OAuth credentials after install. Clean up after uninstalling.
- **`.env` file** — `~/.hermes/.env`. Stores API keys for MCPs that use them.

### Go deeper

- **Want to talk to GitHub?** → Use a community GitHub MCP from a reputable source. Don't paste your personal access token into public channels.
- **Worried about MCPs touching production data?** → `L07 — How to Secure Your Hermes Agent` is required reading.
- **Need to schedule an MCP-driven task?** → `L08 — Hermes Agent Automation: Cron, Kanban, Sub-Agents`.

---

## 9. FAQ

**Q: What apps does the catalog support today?**
A: Linear and n8n as of June 2026. Run `hermes mcp` to see the current list.

**Q: Can I write my own MCP?**
A: Yes — the Model Context Protocol has a Python SDK. You'll write a small server that wraps the app's API and exposes tools. This is an advanced topic; cover it in a future lesson.

**Q: Is it safe to install community MCPs?**
A: It depends on the author. The catalog is safest because the Hermes team reviews every entry. Community MCPs vary widely in quality and safety. Only install from reputable sources, and read the source code if you can.

**Q: How is MCP different from a Skill?**
A: A Skill is a markdown file that tells Hermes how to *think about* a task. An MCP is a server that lets Hermes *do* things in outside apps. Skills are internal instructions; MCPs are external capabilities.

**Q: Can I have multiple MCPs running at once?**
A: Yes. They run as separate processes and Hermes routes tool calls to the right one based on the tool name.

**Q: How do I uninstall an MCP?**
A: `hermes mcp uninstall <name>`. Manually clean up the cached credentials afterward.

**Q: Will the catalog add more apps?**
A: Almost certainly yes. The Hermes team adds entries after PR review. Run `hermes update` regularly to see new additions.