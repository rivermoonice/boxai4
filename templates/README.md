# Templates

Two templates drive the lesson pipeline. Both are **fillable scaffolds** — inline `<!-- TODO: ... -->` markers show what the drafter needs to write; `<!-- GUIDANCE: ... -->` markers show the rules from the spec that the drafter should follow.

## `lesson.md` — the full lesson

12 sections matching `Specs/ai-academy-lesson-specification.md`:

1. Introduction & Hook
2. Core Content
3. Comparison & Decision Framework *(conditional)*
4. Common Pitfalls & Troubleshooting
5. Key Takeaways & Ron's Bottom Line
6. Hands-On Practice
7. Self-Check / Mini-Quiz
8. Resources, Glossary & Further Learning
9. FAQ

Plus authoring notes at the bottom covering voice, readability, and link/SEO rules.

**Used in:** Layer 3 (drafting), one fill-in per approved skeleton.
**Quality gate:** Layer 4 (`scripts/check-lesson.py`) asserts every section is present and non-empty. A smoke-test lesson that passes the gate lives at `lessons/hermes/L00-smoke-test.md`.

## `lesson-skeleton.md` — the short proposal

A reviewable form covering title, audience, source videos, segment plan, suggested sections, pitfalls, quiz, FAQ, and glossary seeds. About one page per lesson.

**Used in:** Layer 2 (clustering), one skeleton per proposed lesson. A human reviews every skeleton before any drafting starts.

## Pipeline

```
Layer 2 (LLM)                    Layer 3 (LLM + human)         Layer 4 (script)
─────────────                    ─────────────────────         ───────────────
fills in skeletons  ────►  approved skeleton  ────►  fills in lesson.md  ────►  check-lesson.py
(one per lesson)              (review checkpoint)             (one per lesson)         (gates commit)
```

## Conventions

- Both templates use **HTML comments** for placeholders and guidance so they don't render in the published lesson.
- The drafter **deletes** `<!-- GUIDANCE -->` blocks once the rule has been applied. Keeps the working file clean.
- The drafter **keeps** `<!-- TODO -->` blocks until the placeholder is filled in. Layer 4 will treat unfilled TODOs as missing content.
- Every claim in a lesson must trace back to a `video_id` in `index/videos.json` or be marked as Ron-tested framing.