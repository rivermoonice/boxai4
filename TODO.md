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

- [x] **Hermes module** — done. 103 videos scoped, 57 transcripts. See `docs/layer-1-log.md`.
- [x] **AI model comparison module** — done. 134 videos scoped, 102 transcripts. See `docs/layer-1-log-ai-models.md`.
- [x] **New AI projects module** — done. 96 videos scoped, 58 transcripts. See `docs/layer-1-log-ai-projects.md`.

## Layer 1.5 — Lesson template

Make lesson drafting "fill in the blanks," not free-form writing.

- [x] Draft `templates/lesson.md` — 12 sections, placeholders, inline guidance.
- [x] Draft `templates/lesson-skeleton.md` — short LLM output form (title, audience, source videos, segments, objectives, pitfalls).
- [x] Inject voice constants from `Specs/ChannelIdentity.md` (signature phrases for flavour; **override audience assumptions** — true beginners, not builders).

## Layer 2 — Cluster (LLM, per module)

Propose lesson structure with sourced videos. User reviews every skeleton before any drafting.

- [x] Module 1: **Hermes agent** — 9 lessons proposed, drafted, passed the gate.
- [x] Module 2: **AI model comparison** — 5 lessons proposed, drafted, passed the gate.
- [x] Module 3: **New AI projects** — 5 lessons proposed (L01–L05), awaiting user review before Layer 3 drafting.

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

- **All three modules complete end-to-end.** 19 lessons drafted and pushed (9 Hermes + 5 AI model comparison + 5 New AI projects). All pass the quality gate.
- **Remaining work**: full-course overview document, cross-module references, any final cleanup.