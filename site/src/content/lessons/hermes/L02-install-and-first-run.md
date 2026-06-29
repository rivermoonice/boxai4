---
title: 'How to Install Hermes Agent for Beginners in 2026 (Mac and VPS, Step-by-Step)'
summary: ''
description: 'You finished L01 and decided Hermes is for you. Now you actually have to install the thing. Hermes runs in two places — on your laptop, or on a rented Linux server called a VPS. Either path takes u…'
module: 'hermes'
slug: 'l02-install-and-first-run'
order: 2
updatedDate: 2026-06-01
updatedRaw: 'June 2026'
readingMinutes: 19
accent: '#7c5cff'
---

# How to Install Hermes Agent for Beginners in 2026 (Mac and VPS, Step-by-Step)

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

You finished L01 and decided Hermes is for you. Now you actually have to install the thing. Hermes runs in two places — on your laptop, or on a rented Linux server called a VPS. Either path takes under 20 minutes if nothing breaks, and this lesson walks through both.

In this lesson you'll install Hermes, point it at a model provider, and run your first command. By the end you will have a working Hermes setup you can come back to in L03.

### Who this is for

A beginner who just finished L01. You have either a Mac running macOS 13 or newer, or you're willing to rent a $2–$5/month VPS. You are comfortable pasting a command into a terminal. You have not installed Hermes before.

### Who this is NOT for

Anyone already running Hermes, anyone who needs production-grade deployment (L08 covers that), or anyone on a Windows PC for the local path — Windows install works but is rougher; we recommend the VPS path for Windows users.

### What you'll be able to do

- Install Hermes Agent on a fresh Mac in under 10 minutes.
- Install Hermes Agent on a cheap Linux VPS in four steps.
- Verify a working install by running your first chat command.

### Learning Objectives

- Install Hermes on a Mac using the official installer and Xcode Command Line Tools.
- Install Hermes on a Linux VPS using SSH and the official installer.
- Pick the right model provider for your first session and paste in an API key.
- Confirm a working install by running your first chat command in Hermes.

### Time estimate

12-minute read + 20-minute hands-on practice

### Prerequisites

- L01: What Is Hermes Agent? (or equivalent understanding of what a harness is)
- A Mac running macOS 13+, OR a credit card to rent a $2–$5/month Linux VPS (Hetzner, DigitalOcean, Vultr, etc.)
- An account with a model provider: Anthropic, OpenAI, DeepSeek, Kimi (Moonshot), MiniMax, or any other Hermes-supported provider. Most have free credits or low-cost entry tiers.

### Why this matters in 2026

Hermes updates frequently — versions 0.8 through 0.17 shipped between March and June 2026. The install path changes as the project evolves. This lesson was last verified in June 2026 against Hermes v0.17-era documentation. If your install fails on a step, check the date stamp at the top of this lesson and the official install page linked in §8.

---

## 2. Core Content

### Chapters

- `00:00` — Pick your path: Mac or VPS
- `01:00` — Mac install: prerequisites
- `03:00` — Mac install: the four commands
- `06:00` — VPS install: rent a server and SSH in
- `08:00` — VPS install: the install command
- `09:30` — Both paths: pick a model and paste your API key
- `11:00` — Verify it works

> 💡 **Ron's Pro Tip** — If you've never used a terminal before, choose the VPS path. The setup is identical to what a Linux server admin would do, and you'll learn one transferable skill (SSH) that you'll use forever.

### Step 1 — Pick your path: Mac or VPS

Before you install anything, decide where Hermes will live:

- **Mac (local)** — Hermes runs as a process on your laptop. Pros: zero monthly cost, fastest iteration when you're learning. Cons: only runs when your laptop is on and awake; not ideal for 24/7 automation.
- **VPS (rented Linux server)** — Hermes runs as a process on a small rented server in a data centre. Pros: runs 24/7, isolated from your laptop, $2–$5/month. Cons: small monthly cost, you need to learn SSH to connect.

> Source: `UbK2kXygPUY` — "The VPS method is still our favorite way. This is the cleanest. This gives you 24/7 runtime. This keeps everything in your VPS separated from your local machine, so it doesn't touch your local files."

**For first-time learners, we recommend the Mac path.** It's faster to iterate when you're just exploring. Once you want a 24/7 setup (for cron jobs, automated research, scheduled messages), the VPS path is worth the $3/month.

### Step 2 — Mac install: prerequisites

You need two things before the installer will work:

1. **macOS 13 or newer.** Check by clicking the Apple menu → About This Mac.
2. **Xcode Command Line Tools.** This is a small Apple package that gives your Mac basic build tools. Open Terminal (Finder → Applications → Utilities → Terminal) and run:

```
xcode-select --install
```

A popup will appear asking you to confirm. Click "Install" and wait. The first time, this can take 5–10 minutes while macOS downloads the package.

> Source: `lHVk1Agz3_I` — "So, the first one it's saying no developer tools were found requesting install. So, we need to install these developer tools."

> ⚠️ **Gotcha** — If you skip this step, the Hermes installer will fail with a confusing "command not found" error and you'll spend 20 minutes debugging the wrong thing. Install Command Line Tools first, always.

### Step 3 — Mac install: the four commands

Once Xcode Command Line Tools are installed, you have four commands to run in Terminal:

**1. Visit the official install page.** Go to `hermes-agent.newsresearch.com` (or check the current URL in §8 — these change occasionally). Find the one-line install command for macOS.

**2. Copy and paste the install command into Terminal.** It will look something like:

```
curl -fsSL https://hermes-agent.newsresearch.com/install.sh | bash
```

**3. Wait for the installer to finish.** It will print a series of progress messages. Don't type anything while it's running.

**4. Run the setup wizard.** When the installer finishes, it will offer a "quick setup" and a "full setup" option. Choose **quick setup** for your first install — the source video recommends it explicitly because you can customise later.

> Source: `lHVk1Agz3_I` — "It's recommended to go quick setup first because that way you'll be able to customize bit by bit later on. And it's much more convenient to go for this method."

The setup wizard will then ask you to:
- Choose a model provider (Anthropic, Kimi, DeepSeek, OpenAI, etc.).
- Paste your API key from that provider.
- Pick a default model.
- Optionally connect a messaging platform (Telegram or Discord) — skip this on first install.
- Choose whether to launch the Hermes chat now.

### Step 4 — VPS install: rent a server and SSH in

**1. Rent a VPS.** Any of Hetzner, DigitalOcean, Vultr, or Linode work. The source video recommends Hetzner for price. For a beginner Hermes install:

- **OS:** Ubuntu 22.04 LTS or Ubuntu 24.04 LTS
- **RAM:** 2 GB is enough for learning, 4 GB is more comfortable
- **Cost:** $2–$5/month
- **Region:** pick one close to you for lower latency

**2. Get your connection credentials.** After you create the server, the provider will give you an IP address, a username (usually `root` or `ubuntu`), and a password. Save these.

**3. SSH in.** On Mac or Linux, open Terminal and run:

```
ssh ubuntu@<your-server-ip>
```

Replace `<your-server-ip>` with the IP your provider gave you. Type `yes` when asked to trust the host. Paste the password when prompted (the cursor won't move — that's normal).

> Source: `UbK2kXygPUY` — "Once you've connected, you've already SSH'd into your VPS. And here is where you're going to want to install Hermes."

> 💡 **Ron's Pro Tip** — Install a free SSH client with a graphical file browser like Termius. You'll be able to drag files in and out of your server, which makes the rest of the lessons much easier.

### Step 5 — VPS install: the install command

Once you're SSH'd into your VPS, run two commands:

**1. Update the system (skip if your VPS is fresh):**

```
sudo apt update && sudo apt install -y git curl
```

**2. Install Hermes.** Go to the official install page and copy the one-line install command. Paste it into your SSH session. Wait for it to finish.

When the installer prompts you with "OpenClaw installation detected — would you like to import from OpenClaw?" answer **No**. You're starting from scratch.

> Source: `UbK2kXygPUY` — "If you're starting from scratch, you've never touched OpenClaw before, you go no. … I found there to be a lot of discrepancies and error. I noticed that the cron jobs from my Open Claw didn't move to my Hermes agent."

> ⚠️ **Gotcha** — The "import from OpenClaw" prompt looks like a helpful shortcut if you've used OpenClaw before. Don't take it. The source video's creator tried it and found that cron jobs didn't migrate cleanly. Set up Hermes fresh, even if it feels redundant.

### Step 6 — Pick a model and paste your API key

The setup wizard (on both paths) asks you to pick a model provider. Here are the practical choices for a beginner in June 2026:

- **Kimi K2.6 / K2.7** (Moonshot) — Cheap, strong for daily use, good for non-English users. Pick this if cost matters.
- **Claude Sonnet / Opus 4.8** (Anthropic) — Highest quality for hard reasoning, more expensive. Pick this if you're doing serious work.
- **DeepSeek V4 Pro** (DeepSeek) — Best tool-call reasoning per the index, weaker at one-shot output.
- **OpenAI GPT-5.x** — Solid general-purpose.
- **MiniMax M3** — Cost-efficient execution model, weak on big-picture planning.

For a beginner doing 50–100 messages a day, **DeepSeek V4 Pro or Kimi K2.6 will run you $5–$10/month.** Claude Opus is roughly 4–5× that.

To get an API key:
1. Create an account at the provider's website.
2. Add a credit card and set a monthly budget cap. (The single most important step. Don't skip it.)
3. Generate a new API key. Copy it.

When the wizard asks, paste the key. Don't paste it into chat or share it with anyone — treat it like a password.

> Source: `lHVk1Agz3_I` — "So, we are we do have the Kimi plan, and we want to try out the Kimi K2.6, so we're going for the Kimi coding plan. Remember to go for this one if you're not on China, uh this applies to MiniMax as well."

### Step 7 — Verify it works

Once the wizard finishes, you should see the Hermes TUI (terminal interface) launch. Type a simple greeting:

```
hi
```

If Hermes responds with a greeting back, the install is complete and you have a working agent. If you see an error, the most common cause is a wrong API key or a missing dependency.

> Source: `lHVk1Agz3_I` — "So, if that happens, you can just terminate the current session, open a new one, run Hermes, and then you can chat with it. So, hi. Um How are you? Okay, and if you get it to respond, then the setup is complete."

---

## 3. Comparison & Decision Framework

| Question | Mac (local) | VPS (rented server) |
|---|---|---|
| Monthly cost | $0 (just API usage) | $2–$5 + API usage |
| Setup time | 5–10 min | 15–20 min (includes SSH learning) |
| Always-on (24/7) | No (laptop must be awake) | Yes |
| Touches your local files | Yes (in working directory) | No (isolated) |
| Best for learning | ✅ First 30 days | After you're comfortable |
| Best for production automation | ❌ | ✅ Cron jobs, scheduled messages |
| Backup discipline | Your responsibility | Provider's snapshots |
| Skills you need to learn | Terminal basics | Terminal + SSH |

**Decision guide:**

- **If you're brand new** to AI agents and terminals → Mac. Lower friction, faster iteration.
- **If you want to run cron jobs** (covered in L08) that fire at 6am while you sleep → VPS.
- **If you have a Windows PC** → VPS (Windows install is rougher; SSH-ing into Linux teaches a portable skill).
- **If you outgrow your Mac install** → you can move your skills to a VPS later. Your API key and configuration carry over.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Xcode Command Line Tools not installed (Mac)

- **Symptom:** Installer fails with "command not found" or "no developer tools were found."
- **Cause:** macOS doesn't ship with build tools by default.
- **Fix:** Run `xcode-select --install` and wait for it to finish. Then re-run the Hermes installer.

### Pitfall 2 — Importing from OpenClaw on the VPS path

- **Symptom:** Installer completes, but cron jobs and skills don't appear.
- **Cause:** The OpenClaw import is buggy per the source video's testing.
- **Fix:** Wipe the VPS, re-create it fresh, and answer **No** to the import prompt.

### Pitfall 3 — Wrong API key in the wrong provider field

- **Symptom:** Auth errors or "401 Unauthorized" when Hermes tries to send a message.
- **Cause:** You pasted your Anthropic key into the Kimi field, or vice versa.
- **Fix:** Re-run the setup wizard (`hermes setup` from the command line) and paste the matching key.

### Pitfall 4 — Setting up in the wrong working directory

- **Symptom:** Hermes acts like it can't see any files, or it creates files in a confusing location.
- **Cause:** You didn't `cd` into a project folder before launching Hermes.
- **Fix:** Always `cd ~/projects/<my-project>` first, then run `hermes`. The working directory is everything.

### Pitfall 5 — Choosing VPS before trying local

- **Symptom:** You burn an hour setting up SSH, only to find that Hermes isn't what you wanted.
- **Cause:** You skipped L01's "should I be here at all" check.
- **Fix:** If you haven't actually used Hermes for at least a week, install locally first. The VPS is the *production* path, not the *learning* path.

### Pitfall 6 — Not setting a monthly API budget

- **Symptom:** A runaway session at 3am burns $50 in two hours.
- **Cause:** You skipped the budget cap in the provider's dashboard.
- **Fix:** Day one: log in to your provider's dashboard, find the billing section, set a hard monthly cap. $20 is a reasonable ceiling for a beginner.

### Pitfall 7 — Forgetting that API keys are passwords

- **Symptom:** You paste your key into a public Discord for "help debugging" and start seeing $200 of fraudulent usage within an hour.
- **Cause:** API keys grant access. Once they're public, attackers will find and use them within minutes.
- **Fix:** Never paste an API key into chat, email, or screenshots. Rotate (delete and regenerate) any key you think you've exposed.

---

## 5. Key Takeaways & Ron's Bottom Line

- Two install paths: Mac (free, fast iteration) or VPS ($2–$5/month, 24/7). Mac is the beginner default.
- Mac needs Xcode Command Line Tools first, or the installer fails with a misleading "command not found" error.
- VPS needs four steps: rent, SSH in, install, pick a model. Don't import from OpenClaw.
- The setup wizard asks for a model provider and an API key. Pick a cheap model (DeepSeek V4 Pro or Kimi K2.6) for learning, an expensive one (Claude Opus) only when you need it.
- Set a hard monthly API budget cap on day one. $20 is a reasonable ceiling for a beginner.
- Verify your install by typing `hi` and getting a reply back.

> 🟦 **Ron's Bottom Line** — Install on a Mac first, even if you plan to move to a VPS later. The first install is about muscle memory, not production. Once you've used Hermes for a week, the VPS path will feel obvious. Before that, you're still learning what the agent even does.

---

## 6. Hands-On Practice

### Exercise

**Task:** Install Hermes using whichever path matches your situation (Mac or VPS). When you're done, type "what's the date today?" into the Hermes TUI.

**Success criteria:** Hermes responds with the correct current date within 5 seconds, and you can see your API key in `~/.hermes/config.yaml` (or wherever your wizard wrote it).

### Do this today

- [ ] Complete the install path you chose (Mac or VPS).
- [ ] Set a monthly budget cap in your model provider's dashboard.
- [ ] Send five test messages to Hermes (e.g. "summarise today's news," "what's 2+2," "tell me a joke," "explain APIs like I'm 10," "what's the date").
- [ ] Note which model you picked and how many tokens each test message used (visible in the provider's dashboard).
- [ ] If on Mac: bookmark the Hermes install page so you can re-install after a future Mac reset.

### What's next

- Next lesson: **L03 — Hermes Agent TUI vs Desktop App** — once you have Hermes installed, you need to know which interface to use.
- Related: **L07 — How to Secure Your Hermes Agent** — read this within a week of installing, especially if you chose the VPS path.

> 💬 Drop a screenshot of your first successful `hi` message in the Discord — I review the best ones and shout them out.

---

## 7. Self-Check / Mini-Quiz

**Q1.** The first thing you should install on a fresh Mac before running the Hermes installer is:
- A) Docker
- B) Xcode Command Line Tools
- C) Homebrew
- D) Node.js

**Q2.** Short answer: What does "fresh install" mean for the VPS path, per the source video?

**Q3.** Pick the wrong reason to rent a VPS:
- A) You want to run cron jobs at 6am while you sleep
- B) You're on Windows
- C) You want to learn
- D) You want to expose Hermes to the internet safely (with Tailscale — L07)

**Q4.** Short answer: Why shouldn't you import from OpenClaw during the VPS install, even if you've used OpenClaw before?

**Q5.** Which of these is the cheapest realistic monthly cost for a beginner running Hermes 50 messages/day?
- A) $0 (Hermes is free)
- B) $2–$10
- C) $50–$100
- D) $200+

**Q6.** Short answer: What is the most important day-one habit in your model provider's dashboard?

### Answers

**A1.** B — Xcode Command Line Tools. Without them, the Hermes installer fails with "no developer tools were found."

**A2.** It means you have a brand-new VPS with no prior Hermes install. The installer will not offer the OpenClaw import (or you should answer No if it does). You set up Hermes as if from scratch.

**A3.** C — "You want to learn." The VPS adds SSH learning overhead. The Mac path is faster for first-time learners. Pick VPS only when you have a concrete 24/7 use case.

**A4.** The source video's creator tried the OpenClaw import and found that cron jobs didn't migrate cleanly. A fresh install is more reliable, even if you have to rebuild some skills.

**A5.** B — $2–$10 covers a cheap VPS plus DeepSeek V4 Pro or Kimi K2.6 at beginner volume. (Add another $0 if you only use a free Mac, but the API cost stays.)

**A6.** Set a hard monthly budget cap. This is the single most important defensive habit. Without it, a runaway session can burn real money in minutes.

**Scoring:** 5–6 correct → ready for L03. 3–4 → re-read Steps 2, 5, and 6. 0–2 → restart the lesson; you may need to revisit L01 first.

---

## 8. Resources, Glossary & Further Learning

### Resources

- **Mac install video** — `Hermes Agent Setup on Mac (Local Install Guide)` (`lHVk1Agz3_I`, 412s, April 2026). The exact steps in this lesson's Mac path come from this video.
- **VPS install video** — `Hermes Agent Setup on VPS` (`UbK2kXygPUY`, 424s, April 2026). The exact steps in this lesson's VPS path come from this video.
- **Official install page** — `hermes-agent.newsresearch.com/install` (verify URL is current; Hermes updates frequently).
- **SSH client** — Termius (free tier) is what the source video uses.
- **VPS providers** — Hetzner (recommended in the source video for price), DigitalOcean, Vultr, Linode.

### Glossary

- **CLI (command line interface)** — the text-based window where you type commands instead of clicking icons. Hermes runs here by default (the "TUI").
- **TUI (Terminal User Interface)** — a text-based app that runs in a terminal. Looks like a chat window but starts with the `hermes` command.
- **Xcode CLT** — Apple's Command Line Tools. A small package Mac devs install to get basic build tools. Required for the Hermes Mac install.
- **VPS (Virtual Private Server)** — a rented Linux computer in a data centre, usually $2–$10/month.
- **SSH** — a protocol that lets you open a text-based terminal session on a remote computer. Used to log into your VPS.
- **API key** — a long string of letters and numbers that proves to a model provider (Anthropic, OpenAI, etc.) that you're allowed to use their service. Treat it like a password.
- **Working directory** — the folder your terminal is "in" right now. Hermes only sees files inside this folder.
- **BYOK (Bring Your Own Key)** — using your own API key instead of a vendor's bundled subscription. Required for Hermes.
- **Quick setup vs full setup** — the install wizard's two modes. Quick setup picks sensible defaults; full setup lets you customise every step. Use quick setup for your first install.

### Go deeper

- **VPS not connecting?** → Check the provider's "firewall" or "security group" settings. Most providers block inbound SSH by default. Allow port 22 from your IP.
- **Want to run cron jobs?** → `L08 — Hermes Agent Automation: Cron, Kanban, Sub-Agents` covers scheduled tasks once you have a working install.
- **Worried about exposing your VPS?** → `L07 — How to Secure Your Hermes Agent` is required reading before you connect a messaging platform.

---

## 9. FAQ

**Q: Do I need to pay for an API to use Hermes?**
A: Yes. Hermes is free (open-source), but the model you run inside it isn't. You pay the model provider per token. Set a hard budget cap on day one.

**Q: Can I install Hermes on Windows?**
A: Yes, but the local install is rougher than on Mac. The source video doesn't cover it. We recommend the VPS path for Windows users — SSH into a Linux server and you get the same install experience as everyone else.

**Q: How much does the cheapest VPS cost that runs Hermes?**
A: $2–$3/month for 2 GB of RAM, which is enough for a beginner Hermes setup. The source video recommends Hetzner's $3/month tier.

**Q: Should I install locally or on a VPS first?**
A: Mac locally. The VPS path adds SSH learning overhead that's worth it only when you have a concrete 24/7 use case. Install on your laptop, use it for a week, then decide.

**Q: My install failed halfway. What do I do?**
A: Most common cause on Mac: Xcode Command Line Tools aren't installed. Run `xcode-select --install`, wait for it to finish, then re-run the installer. Most common cause on VPS: missing `git` or `curl`. Run `sudo apt install -y git curl` first.

**Q: Can I switch model providers later?**
A: Yes. Run the setup wizard again (`hermes setup`) and pick a different provider. Your skills and config carry over.

**Q: How long does a fresh install take?**
A: Mac: 5–10 minutes if Command Line Tools are already installed; up to 30 minutes if they're not. VPS: 15–20 minutes including the SSH learning curve.

**Q: Do I need to keep my laptop on after the install?**
A: Only if you chose the Mac path. Hermes only runs while your Mac is awake. The VPS path runs 24/7 regardless of your laptop's state.