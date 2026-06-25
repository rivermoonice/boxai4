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

- [x] Draft `templates/lesson.md` — 12 sections, placeholders, inline guidance.
- [x] Draft `templates/lesson-skeleton.md` — short LLM output form (title, audience, source videos, segments, objectives, pitfalls).
- [x] Inject voice constants from `Specs/ChannelIdentity.md` (signature phrases for flavour; **override audience assumptions** — true beginners, not builders).

## Layer 2 — Cluster (LLM, per module)

Propose lesson structure with sourced videos. User reviews every skeleton before any drafting.

- [x] Module 1: **Hermes agent** — 9 lessons proposed (L01–L09), 2 evidence-light (L07, L08). 27 backlog videos need a decision.
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

- [x] Write `scripts/check-lesson.py` — asserts every required section is present.
- [x] Enforce rules: action-verb objectives, word count ≥ 1,800, freshness date, 4–6 quiz questions, 5–8 pitfalls, ≥ 3 FAQ.
- [x] Smoke test lesson passes the gate — `lessons/hermes/L00-smoke-test.md`.
- [ ] Wire into pre-commit or CI (recommended: GitHub Action).

---

## Now

- **Layer 1, 1.5, 2, and 4 are done for the Hermes module.** All 9 lesson skeletons are in `lessons/hermes/_skeletons/` for review. Layer 3 drafting is blocked on user approval of the skeletons.
- **Open questions for the user** (in `docs/layer-2-log.md`):
  1. Course order L01→L09 — confirm or reorder.
  2. 27 backlog videos — accept as supporting material, or add an L10?
  3. L07 and L08 are evidence-light — ship with caveats, re-run transcripts, or cut to v2?
  4. Source-video picks — are the right primaries selected?