# L07 — security-essentials

**Module:** Hermes agent
**Proposed by:** layer-2-hermes-2026-06-24
**Status:** proposed

---

## Title (SEO formula)

**Working title:** How to Secure Your Hermes Agent in 2026 (Tailscale, Credentials, and the #1 Mistake)

**Meta title (50–60 chars):** How to Secure Your Hermes Agent (2026 Beginner Guide)
**Meta description (150–160 chars):** Hermes running with the wrong config can leak your API keys. The fix is 20 minutes and a free VPN. Here's what every beginner must do on day one.
**URL slug:** hermes-agent-security

---

## Audience

**For:** A Hermes user who has installed locally (L02) or on a VPS (L02) and is about to connect an API account with real money behind it.
**Not for:** Anyone who hasn't installed Hermes yet — finish L02 first.

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Describe the three main security risks of running an AI agent (API key leak, prompt injection, network exposure).
- Set up Tailscale on a VPS in under 20 minutes.
- Verify your Hermes install is not exposed to the public internet.

**Time estimate:** 8-min read + 20-min hands-on

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `5F1hFI2lZCg` | How to Connect Hermes Agent VPS to Desktop App (FREE Guide) | 475s | primary (Tailscale setup) |
| 2 | `52p-pnSptcs` | Why You MUST Secure Your Hermes Agent And How to Do It | 39s | supporting (PSA) |
| 3 | `OBb2k3wusjw` | Critical Security Warning for Hermes Agent V0 13 | 59s | supporting (specific version gotcha) |

**Why these videos:** `5F1hFI2lZCg` is the only video in the index with a transcript that walks through Tailscale setup; its verdict is unambiguous: "username/password method for remote Hermes is too risky for the public internet; Tailscale/VPN mandatory." The two short PSAs give the lesson urgency.

⚠️ **Evidence note:** L07's source material is thin (only 2 of 3 source videos have transcripts). The lesson should be marked as "evidence-light" in the layer-2 output and the drafter should plan to write the §2 and §4 content based on the channel-voice beliefs in `Specs/ChannelIdentity.md` (security is non-negotiable when exposing AI agents), not just the transcript quotes.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `5F1hFI2lZCg` | `00:00` | `08:00` | full video — Tailscale setup, the desktop-app connection, why this matters |
| `52p-pnSptcs` | `00:00` | `00:40` | the "MUST secure" framing |
| `OBb2k3wusjw` | `00:00` | `01:00` | v0.13 specific warning |

---

## Prerequisites

- L02: Install & first run (Mac or VPS)
- An API key from a paid provider (Anthropic, OpenAI, Kimi, DeepSeek, etc.) — security only matters once money is on the line

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [ ] 3. Comparison & Decision Framework *(not applicable for a security lesson)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Exposing the agent on the public internet without Tailscale** — the #1 risk; directly cited in `Specs/ChannelIdentity.md` and `5F1hFI2lZCg`.
2. **Reusing your personal API key for the agent** — agents store credentials in plain-text files. Use a separate, scoped key.
3. **Skipping the "rotate keys every 90 days" habit** — leaked keys can sit for months before they're used.
4. **Trusting a "privacy mode" toggle in your AI provider** — `Specs/ChannelIdentity.md` notes "Cursor can train on inputs even with privacy mode on." Don't assume privacy modes are real.
5. **Pasting credentials into chat when debugging** — beginners do this in the channel's own Discord. Don't.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: The recommended way to expose a remote Hermes is… (open port 22 / open port 80 / Tailscale / no port at all)
2. Short answer: Why is Tailscale safer than username/password for remote Hermes?
3. Multiple choice: When you create an API key for Hermes, the key should be… (your personal root key / a separate, scoped key / the same key you use in your IDE / a key shared with friends)
4. Short answer: What is the v0.13 security warning about?

---

## Suggested FAQ (for §9)

- **Q: Is Tailscale free?**
- **Q: Do I need Tailscale if I'm only running Hermes on my Mac?**
- **Q: What do I do if I think my API key has leaked?**
- **Q: Can I use a different VPN instead of Tailscale?**

---

## Glossary Seeds

- **Tailscale** — a free VPN that creates a private network between your devices. No ports exposed to the internet.
- **API key** — (re-define) a long string that authorises a service. Treat it like a password.
- **Prompt injection** — when a malicious input tries to trick your AI agent into running an unintended command.
- **Scope** — the permissions a key has. Read-only is safer than read-write.
- **Public internet** — the part of the network anyone can reach. Default for new servers. The opposite of what you want for a personal agent.

---

## Notes for the Drafter

- **This lesson is evidence-light.** Only 2 of 3 source videos have transcripts; the third (`OBb2k3wusjw`) is a 59-second PSA. The drafter must lean on `Specs/ChannelIdentity.md`'s security belief ("Security is non-negotiable when exposing AI agents: never expose remote agent credentials over the public internet — Tailscale/VPN is mandatory") for the bulk of §2 and §4. Note this prominently in the lesson's "Last tested and updated" note.
- **Tone is direct, not paranoid.** Beginners will tune out scare tactics. "Here is what to do, here is why, here is the 20-minute fix."
- **Channel voice is essential here.** Ron's "real usage over benchmarks" framing means: don't theorise about hypothetical attacks, point at the actual credential-sniffing risk that has happened.
- **This lesson is short on purpose.** Security is a checklist. Don't pad it.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_