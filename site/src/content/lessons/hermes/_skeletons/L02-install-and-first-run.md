# L02 — install-and-first-run

**Module:** Hermes agent
**Proposed by:** layer-2-hermes-2026-06-24
**Status:** proposed

---

## Title (SEO formula)

**Working title:** How to Install Hermes Agent for Beginners in 2026 (Mac and VPS, Step-by-Step)

**Meta title (50–60 chars):** How to Install Hermes Agent for Beginners (2026)
**Meta description (150–160 chars):** Two real install paths for Hermes: 5 minutes on a fresh Mac, or 4 clean steps on a VPS. No code required — copy, paste, run.
**URL slug:** how-to-install-hermes-agent

---

## Audience

**For:** A complete beginner who just watched L01 and decided Hermes is for them. Has a Mac (Apple Silicon or Intel) and either a spare laptop or is willing to rent a $5 VPS for a month.
**Not for:** Anyone already running Hermes or anyone who needs production-grade deployment (L08 covers advanced setups).

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Install Hermes Agent on a fresh Mac in under 10 minutes.
- Install Hermes Agent on a cheap VPS in 4 steps.
- Verify a working install by running your first command.

**Time estimate:** 12-min read + 20-min hands-on

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `lHVk1Agz3_I` | Hermes Agent Setup on Mac (Local Install Guide) | 412s | primary (Mac) |
| 2 | `UbK2kXygPUY` | Hermes Agent Setup on VPS | 424s | primary (VPS) |
| 3 | `vLEoYsJCYGs` | Here's the Fun Part - Choosing Your API - Hermes Agent Setup on Mac | ?s | supporting |

**Why these videos:** `lHVk1Agz3_I` is the canonical Mac install ("works in under 5 minutes once Xcode CLT 26.4 is installed"). `UbK2kXygPUY` is the canonical VPS install ("a clean four-step VPS install path"). Both are transcript-rich. `vLEoYsJCYGs` covers API-key selection which is the second step after install.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `lHVk1Agz3_I` | `00:00` | `06:50` | full video — Mac install, Xcode CLT, the 5-minute path |
| `UbK2kXygPUY` | `00:00` | `07:00` | full video — VPS 4-step path, do not import from OpenClaw |
| `vLEoYsJCYGs` | `00:00` | `00:60` | choosing the API provider (Kimi vs Claude vs DeepSeek) |

---

## Prerequisites

- L01: What Is Hermes Agent? (or equivalent understanding)
- A Mac running macOS 13+ OR a $5/month VPS (Hetzner, DigitalOcean, Vultr) running Ubuntu 22.04+
- A credit card to create an API account with one of: Anthropic, OpenAI, DeepSeek, or Kimi (Moonshot)

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [x] 3. Comparison & Decision Framework *(Mac vs VPS: which should you pick?)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Xcode CLT missing** — Mac install fails silently without it. Symptom: weird build errors. Fix: `xcode-select --install`.
2. **Wrong API key** — pasting a Claude key into the Kimi provider field. Symptom: auth errors. Fix: match key to provider.
3. **Forgetting to set the working directory** — Hermes runs in whatever folder you launched it. Fix: `cd` first.
4. **Importing from OpenClaw** — `UbK2kXygPUY`'s verdict says "skip the OpenClaw import, set up fresh." Don't try to migrate configs.
5. **Choosing VPS before trying local** — most beginners should install locally first; the $5/month is the *production* path, not the *learning* path.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: The first thing you should install on a fresh Mac for Hermes is… (Docker / Xcode CLT / Homebrew / Node)
2. Short answer: What does "fresh install" mean for the VPS path, per the source video?
3. Multiple choice: Pick the wrong reason to rent a VPS: (you want to run 24/7 / you're on Windows / you want to learn / you want to expose Hermes to the internet safely)

---

## Suggested FAQ (for §9)

- **Q: Do I need to pay for an API to use Hermes?**
- **Q: Can I install Hermes on Windows?**
- **Q: How much does the cheapest VPS cost that runs Hermes?**
- **Q: Should I install locally or on a VPS first?**

---

## Glossary Seeds

- **CLI (command line interface)** — the text-based window where you type commands instead of clicking icons. Hermes runs here by default (the "TUI").
- **Xcode CLT** — Apple's Command Line Tools. A small package Mac devs install to get basic build tools.
- **VPS (Virtual Private Server)** — a rented Linux computer in a data center, usually $5–$10/month.
- **API key** — a long string of letters and numbers that proves to a service (Anthropic, OpenAI) that you're allowed to use it.
- **Working directory** — the folder your terminal is "in" right now. Hermes only sees files inside this folder.

---

## Notes for the Drafter

- This is the **first hands-on lesson** in the course. It must work end-to-end on a real beginner's machine.
- **Decide which install path to lead with.** My recommendation: Mac (lower friction, more beginners have one) as the primary, VPS as the alternative.
- **Embed both videos** as supporting material. The text must stand alone without them.
- **The "fresh install" gotcha from `UbK2kXygPUY` is critical** — it goes in §4 and is the #1 thing beginners try to do that breaks.
- **Cost transparency**: list the real monthly costs of Mac (free) vs VPS ($5–$10) vs API usage ($1–$20/mo for beginner use).

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_