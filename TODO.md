# Course Build — TODO

Working backlog for the Boxmining AI Academy course. Four layers, each must finish cleanly before the next starts.

**Voice**: Ron's — direct, no-hype, "real usage over benchmarks."
**Audience**: true beginners (no assumed knowledge of tokens, MCPs, TUIs, or slash commands).
**Lesson structure**: 12 required sections, per `Specs/ai-academy-lesson-specification.md`.
**Source data**: `public.videos` in Supabase (transcripts + descriptions only).
**Channel voice reference**: `Specs/ChannelIdentity.md`.

---

## Layer 1 — Index (deterministic, no LLM)

Build a flat snapshot of source videos so every later step has ground truth.

- [x] **Hermes module** — done. 103 videos scoped (title OR summary_verdict contains "hermes"), 57 transcripts exported. See `docs/layer-1-log.md` for what was learned. Index lives in `index/`.
- [ ] **AI model comparison module** — same flow. Watch for tag-bundle pollution (see log).
- [ ] **New AI projects module** — same flow. Scope needs user input (Hermes projects? Claude Code? Both?).

## Layer 1.5 — Lesson template

Make lesson drafting "fill in the blanks," not free-form writing.

- [ ] Draft `templates/lesson.md` — 12 sections, placeholders, inline guidance.
- [ ] Draft `templates/lesson-skeleton.md` — short LLM output form (title, audience, source videos, segments, objectives, pitfalls).
- [ ] Inject voice constants from `Specs/ChannelIdentity.md` (signature phrases for flavour; **override audience assumptions** — true beginners, not builders).

## Layer 2 — Cluster (LLM, per module)

Propose lesson structure with sourced videos. User reviews every skeleton before any drafting.

- [ ] Module 1: **Hermes agent** — pull all `hermes agent*` tagged videos; propose 6–10 lessons.
- [ ] Module 2: **AI model comparison** — pull `model-tier-list`, `ai-models`, comparison/review videos; propose 4–6 lessons.
- [ ] Module 3: **New AI projects** — scope with user; propose 4–6 lessons.

## Layer 3 — Draft loop

Turn one approved skeleton into a full lesson. One lesson in flight at a time.

- [ ] Draft using `templates/lesson.md`.
- [ ] Run Layer 4 quality gate.
- [ ] User review and edits.
- [ ] Commit to `lessons/<module>/L##-<slug>.md`.

## Layer 4 — Quality gate

No half-finished lessons reach the repo.

- [ ] Write `scripts/check-lesson.py` — assert each of the 12 spec sections is present.
- [ ] Enforce rules: SEO title formula, action-verb objectives, word count ≥ 1,800, freshness date, FAQ, quiz.
- [ ] Wire into pre-commit or CI.

---

## Now

- **Layer 1 is done for Hermes.** Next is **Layer 1.5**: draft `templates/lesson.md` (12-section scaffold) and `templates/lesson-skeleton.md` (short LLM output form). Once those exist, run **Layer 2 for Hermes** to propose lesson structure for review.
- **Open questions for the user** (in `docs/layer-1-log.md`):
  1. Older Hermes videos have no transcripts — skip, link as "see also", or re-run pipeline?
  2. Layer 1 for the other two modules — confirm scope and we're good to run.