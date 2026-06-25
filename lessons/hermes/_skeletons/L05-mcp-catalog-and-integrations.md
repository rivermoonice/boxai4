# L05 — mcp-catalog-and-integrations

**Module:** Hermes agent
**Proposed by:** layer-2-hermes-2026-06-24
**Status:** proposed

---

## Title (SEO formula)

**Working title:** How to Connect Hermes Agent to Other Apps with the MCP Catalog (2026)

**Meta title (50–60 chars):** Hermes MCP Catalog: Connect to Any App (2026)
**Meta description (150–160 chars):** MCP is how Hermes talks to GitHub, Linear, Notion, and more. The built-in catalog is the safest on-ramp. Here's how to use it without breaking your setup.
**URL slug:** hermes-mcp-catalog

---

## Audience

**For:** A Hermes user who wants their agent to read GitHub issues, post to Linear, or fetch from Notion without writing custom code.
**Not for:** Anyone who hasn't used the TUI yet (L03) — MCP talks assume that muscle memory.

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Explain what an MCP is, in plain English.
- Install an MCP from the built-in catalog in under 5 minutes.
- Add a custom MCP for an app the catalog doesn't yet cover.

**Time estimate:** 12-min read + 30-min hands-on

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `IMO8ooIqONM` | Hermes Agent MCP Catalog Guide (NEW) | 484s | primary |
| 2 | `zhznE_jOFVY` | Hermes Agent's HUGE New Update: Built-in MCP Catalog! | 52s | supporting — the launch announcement |

**Why these videos:** `IMO8ooIqONM` is the only deep walkthrough of the catalog. Its verdict — "underrated, safer on-ramp for new users; current snapshot only ships Linear and n8n" — is exactly the honest framing a beginner needs.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `IMO8ooIqONM` | `00:00` | `08:00` | full walkthrough — what an MCP is, how to install from catalog, what the catalog ships today |
| `zhznE_jOFVY` | `00:00` | `00:50` | the launch context — when the catalog shipped, why it matters |

---

## Prerequisites

- L02: Install & first run
- L03: TUI vs Desktop App

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [ ] 3. Comparison & Decision Framework *(covered in L09 — keep this focused)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **The catalog only ships Linear and n8n (as of June 2026)** — beginners assume the catalog is comprehensive. It isn't. Custom MCPs are still the path for most apps.
2. **Adding a malicious MCP** — MCPs run with full access to whichever app they connect. Don't install random community MCPs without reading the source.
3. **MCP-heavy sessions in the desktop app** — `c3bd0HiE3pg`'s v0.16 verdict says "skip the desktop for MCP-heavy sessions until the discoverability PR ships."
4. **Forgetting to scope the MCP token** — when you create a Linear API key for Hermes, use the most limited scope possible.
5. **Hard-coding MCP configs in the wrong place** — MCPs live in `~/.hermes/mcp/`. Putting them elsewhere breaks upgrades.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: MCP stands for… (Model Context Protocol / Multi-Channel Plugin / Master Control Program / Managed Claude Pipeline)
2. Short answer: As of June 2026, which two apps does the built-in MCP catalog ship with?
3. Multiple choice: When installing a custom MCP, the safest thing to do is… (use the most permissive API key / use the most limited API key / reuse your personal key / skip API auth)
4. Short answer: Why is the desktop app a poor choice for MCP-heavy work in v0.16?

---

## Suggested FAQ (for §9)

- **Q: What apps does the catalog support today?**
- **Q: Can I write my own MCP?**
- **Q: Is it safe to install community MCPs?**
- **Q: How is MCP different from a skill?**

---

## Glossary Seeds

- **MCP (Model Context Protocol)** — an open standard that lets AI agents talk to outside apps (GitHub, Linear, Notion, etc.) in a uniform way. Like a USB port for AI.
- **Catalog** — Hermes' built-in list of pre-configured MCPs. Currently ships Linear and n8n as of June 2026.
- **API key** — (re-define briefly) a long string that authorises a service to talk to another service on your behalf.
- **Scope** — the permissions a key has. Read-only is safer than read-write.

---

## Notes for the Drafter

- **Date the catalog content**: as of June 2026, the catalog has Linear and n8n. Update this list when the next release ships. (Spec demands a "Last tested and updated" line — do it.)
- **Honest framing wins here.** The catalog is *small* and *new*. The lesson should not oversell it.
- **Embed `IMO8ooIqONM` as the primary video.** The 52-second clip is too thin on its own.
- **Add a sidebar about the OpenClaw / Hermes "Tool Gateway" history** — `VIpMz5uz4Cc` (v0.10 Tool Gateway Release) is in the index as background but not the primary source. Worth one paragraph for context.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_