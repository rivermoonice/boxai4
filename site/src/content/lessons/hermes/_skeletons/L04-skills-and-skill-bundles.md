# L04 — skills-and-skill-bundles

**Module:** Hermes agent
**Proposed by:** layer-2-hermes-2026-06-24
**Status:** proposed

---

## Title (SEO formula)

**Working title:** Hermes Agent Skills and Skill Bundles Explained for Beginners (2026)

**Meta title (50–60 chars):** Hermes Agent Skills & Skill Bundles (Beginner Guide)
**Meta description (150–160 chars):** Skills are how Hermes remembers what to do. Bundles group them so one slash command replaces five. Honest beginner walkthrough with real examples.
**URL slug:** hermes-skills-and-skill-bundles

---

## Audience

**For:** A Hermes user who has run a few commands and wants to teach the agent to do specific things without re-explaining them every session.
**Not for:** Anyone who hasn't installed Hermes (L02) or tried the TUI at least once (L03).

**Reading level:** grade 8–10. Every term defined on first use.

---

## Learning Objectives

- Create a basic skill in Hermes and call it with a slash command.
- Group related skills into a Skill Bundle for one-line invocation.
- Avoid the "skills that don't actually trigger" failure mode.

**Time estimate:** 14-min read + 30-min hands-on

---

## Source Videos

| Order | video_id | Title | Duration | Role |
|---|---|---|---|---|
| 1 | `_A02brv2Csg` | Hermes Agent NEW Skill Bundles (Setup Guide) | 612s | primary (deep dive) |
| 2 | `8ieTyrnCHYY` | Hermes Agent NEW Skill: The Simplest Explanation of Skill Bundles | 63s | supporting (concept) |
| 3 | `kuG5Z_MD-2U` | Hermes Agent NEW Skill: It Built Two Skill Bundles Without Being Asked | 64s | supporting (auto-creation) |
| 4 | `DXEj2XVIt6c` | Hermes Agent NEW Skill: The Missing Hermes Feature Everyone Wants | 60s | supporting (use case) |
| 5 | `1p0X7xqDxhw` | Hermes Agent NEW Skill: Are Bundled Agent Skills Actually Adaptive | 54s | supporting (gotcha) |

**Why these videos:** `_A02brv2Csg` is the canonical setup guide ("group skills once, invoke with one slash command instead of hoping the agent picks all five subtasks from one prompt"). The four 60-second clips each cover one angle of the same feature and let us include a real-world example for each.

---

## Segment Plan

| video_id | Start | End | What this segment covers |
|---|---|---|---|
| `_A02brv2Csg` | `00:00` | `10:00` | full setup — install a skill, group into a bundle, invoke with `/` |
| `8ieTyrnCHYY` | `00:00` | `01:00` | the simplest explanation of what a bundle is |
| `kuG5Z_MD-2U` | `00:00` | `01:00` | the surprise: the agent creates bundles without you asking |
| `1p0X7xqDxhw` | `00:00` | `00:50` | the gotcha: are bundles actually adaptive? (No, not yet) |

---

## Prerequisites

- L02: Install & first run
- L03: TUI vs Desktop App
- Comfortable running slash commands in the TUI

---

## Suggested Sections (per the 12-section spec)

- [x] 1. Introduction & Hook
- [x] 2. Core Content (with chapters and steps)
- [ ] 3. Comparison & Decision Framework *(not applicable — single tool)*
- [x] 4. Common Pitfalls & Troubleshooting
- [x] 5. Key Takeaways & Ron's Bottom Line
- [x] 6. Hands-On Practice
- [x] 7. Self-Check / Mini-Quiz
- [x] 8. Resources, Glossary & Further Learning
- [x] 9. FAQ

---

## Suggested Pitfalls (for §4)

1. **Skills that don't trigger** — the agent picks the wrong skill for the prompt. Fix: be explicit ("use the /standup skill").
2. **Bundles that aren't actually adaptive** — `1p0X7xqDxhw` confirms: bundles are static, not context-aware. Don't expect them to switch based on inputs.
3. **Modifying the wrong file** — skills live in a specific folder under `~/.hermes/skills/`. Modifying the wrong copy silently breaks things.
4. **Skill sprawl** — creating 50 skills you never use. The Curator Guide (covered in §8) helps clean up; the lesson should mention this.
5. **Skipping the auto-creation warning** — `kuG5Z_MD-2U` shows the agent creating bundles on its own. Beginners should know this happens so they're not surprised.

---

## Suggested Quiz Questions (for §7)

1. Multiple choice: A Skill Bundle is best described as… (a single powerful skill / a group of skills invoked with one command / a model / a feature of the desktop app)
2. Short answer: Per the source, are bundles adaptive to context? (Yes / No — explain)
3. Multiple choice: The first thing to do if your skill isn't triggering is… (delete and recreate it / be more explicit in your prompt / install a different model / switch to the desktop app)
4. Short answer: Where do Hermes skills live on your machine?

---

## Suggested FAQ (for §9)

- **Q: Can a skill call another skill?**
- **Q: How do I list all my installed skills?**
- **Q: Can the agent create new skills on its own?**
- **Q: What's the difference between a skill and a slash command?**

---

## Glossary Seeds

- **Skill** — a small file (markdown) that tells Hermes how to do one specific job. Triggered by a slash command like `/standup`.
- **Skill Bundle** — a group of related skills, invoked by a single slash command.
- **Slash command** — a `/` followed by a name, typed in the TUI. Like `/goal` or `/standup`.
- **Auto-skill creation** — when Hermes writes a new skill file based on a successful workflow. Surprising the first time it happens.
- **Curator** — a Hermes sub-tool that helps you find, merge, and clean up your skills. (Covered in a footnote here, full lesson in backlog.)

---

## Notes for the Drafter

- **This is the lesson where "what is a slash command" finally pays off** — refer back to L01's glossary but now with muscle memory.
- **Use a real example throughout.** Don't say "imagine you have a standup skill." Write out the actual content of a `standup.md` file and show the bundle file.
- **Embed the long video (10 min) AND the four 1-min clips.** Beginners may want the deep dive; intermediate users want the TL;DRs.
- **Be honest about the gotcha** — bundles aren't adaptive yet. Beginners will read marketing and expect magic; the lesson should set real expectations.

---

## Review

- [x] Skeleton matches an actual lesson gap in the module outline
- [x] Every video_id is in index/videos.json
- [ ] Segment starts/ends are real times (not placeholders)
- [x] Pitfalls are real mistakes a beginner would make
- [x] Quiz questions test application, not recall
- [x] FAQ targets real beginner searches
- [ ] Approved by: _pending_