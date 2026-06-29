# L01 — coding-with-claude-code

**Module:** New AI projects
**Proposed by:** layer-2-ai-projects-2026-06-26
**Status:** proposed

---

## Title (SEO formula)

**Working title:** How to Use Claude Code for Beginners in 2026 (Step-by-Step Coding Workflow)

**Meta title (50–60 chars):** Claude Code for Beginners (2026 Step-by-Step)
**Meta description (150–160 chars):** Claude Code is Anthropic's coding harness — the alternative to building inside an IDE. Learn the daily workflow, the loop pattern, and when to use it.
**URL slug:** how-to-use-claude-code

---

## Audience

**For:** A reader who has used AI for code but never used a coding harness. Wants to ship real software with Claude Code.
**Not for:** Anyone already running Claude Code in production. This is the beginner intro.

### What you'll be able to do

- Explain what Claude Code is and how it differs from a chat interface.
- Set up Claude Code for a new project.
- Use Claude Code's loop pattern to ship a real feature.

### Learning Objectives

- Describe the Claude Code daily workflow.
- Set up Claude Code for a new project.
- Use Claude Code's loop to ship a small feature.
- Recognise when to use Claude Code vs an agent harness.

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `cwpykYGbICc` | Kilo Code: Why You Should Try It (Tutorial) | 1080s | primary (coding harness intro) |
| 2 | `FYJ7hesrz4A` | This Claude Code Command is PERFECT for Beginners! | 763s | primary (beginner-friendly) |
| 3 | `Tw54psmZ4-k` | Advanced Loops in Claude Code (Our Setup) | 696s | supporting (loop pattern) |
| 4 | `E4gc4-9O1JE` | Perplexity Computer Just KILLED Claude Code (Side-by-Side Test) | 750s | supporting (when not to use) |

**Why these videos:** Kilo Code (the open-source alternative to Claude Code) is the cleanest tutorial in the index. Claude Code's beginner command video is the most beginner-friendly. The advanced loops video shows the real production pattern. The Perplexity test video gives an honest "when not to use" framing.

⚠️ **Evidence note:** Most "Claude Code / Kilo Code" videos are framework-specific rather than first-principles. The lesson will lean on `Specs/ChannelIdentity.md` for body content about coding harnesses vs agent harnesses.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `cwpykYGbICc` | `00:00` | `18:00` | full tutorial — why Kilo Code exists, how it compares |
| `FYJ7hesrz4A` | `00:00` | `13:00` | full beginner command walkthrough |
| `Tw54psmZ4-k` | `00:00` | `12:00` | full advanced loops walkthrough |
| `E4gc4-9O1JE` | `00:00` | `13:00` | side-by-side comparison |

---

## Prerequisites

- Comfortable running commands in a terminal.
- Have a real coding project (even a simple one) to apply the lesson to.

---

## Suggested Sections

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [ ] 3. Comparison & Decision Framework *(optional — covered in AI models L05)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Treating Claude Code like a chatbot.** It's a coding harness — it executes commands and verifies by running tests.
2. **Skipping the loop.** Claude Code's strength is the iterative verification loop (write → test → fix → repeat).
3. **Burning through the Max plan.** Set a hard monthly cap.
4. **Using Claude Code for non-coding tasks.** Use an agent harness (Hermes) instead.
5. **Expecting one-shot perfection.** Claude Code's strength is iteration, not magic.

---

## Suggested FAQ (for §9)

- **Q: Claude Code vs Cursor?**
- **Q: Claude Code vs Kilo Code?**
- **Q: Do I need the Max plan?**

---

## Glossary Seeds

- **Coding harness** — an AI agent specialised for writing code (Claude Code, Kilo Code, Cursor's agent mode).
- **Loop** — when the agent retries a task until a success check passes.
- **Max plan** — Claude Code's $200/month subscription.

---

## Notes for the Drafter

- **Lead with the harness-vs-chat distinction.** Claude Code is a harness, not a chat. This is the conceptual anchor.
- **Cross-reference the AI model comparison module.** Tiered routing matters here: Opus for hard, Sonnet for default.
- **Frame the loop pattern as the channel's documented belief.** Per `Specs/ChannelIdentity.md`: "Loop-based agent workflows with validation harnesses (Playwright/Puppeteer checklists) are the new default for shipping with agents, replacing saved prompt lists."

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index-ai-projects/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real beginner mistakes
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_