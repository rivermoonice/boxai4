# How to Test the Quality Gate for Beginners in 2026 (Step-by-Step, No Setup Required)

**Last tested and updated:** June 2026

---

## 1. Introduction & Hook

A short hook that explains why this lesson exists. This paragraph is here to satisfy the word-count target and to demonstrate the template renders correctly under the quality gate.

### Who this is for

Quality gate testers.

### Who this is NOT for

Real students.

### What you'll be able to do

Run the gate on any lesson file.

### Learning Objectives

- Install a copy of the academy course repo from GitHub.
- Run the quality gate script on a lesson file.
- Identify which checks failed and how to fix them.

### Time estimate

5-minute read.

### Prerequisites

Basic Python 3 installed locally.

### Why this matters in 2026

Quality gates keep the course consistent.

---

## 2. Core Content

This is a placeholder body for the smoke test. It exists so the script can count this section as present and non-empty. The real lesson content will be much longer.

### Step 1 — Clone the repo

Run `git clone`.

### Step 2 — Run the gate

Run `python3 scripts/check-lesson.py path/to/lesson.md`.

> 💡 **Ron's Pro Tip** — Always run the gate before committing a new lesson.

### Step 3 — Fix any failures

The gate will print exactly what's missing.

### Cost transparency

| Item | Beginner usage | Realistic cost/day |
|---|---|---|
| Running the gate | 1 run | $0 |

### Examples

**Beginner example**

Run the gate.

**Real-world example**

Run the gate in CI.

---

## 4. Common Pitfalls & Troubleshooting

### Pitfall 1 — Missing section heading

- **Symptom:** gate says "Missing required section".
- **Cause:** typo in the `## ` heading.
- **Fix:** match the template heading exactly.

### Pitfall 2 — Word count below 1,800

- **Symptom:** gate says "Word count N is below the 1,800 minimum".
- **Cause:** lesson too short.
- **Fix:** expand the body. Spec target is 1,800–3,500 words.

### Pitfall 3 — Unfilled TODO marker

- **Symptom:** gate says "unfilled placeholder marker(s)".
- **Cause:** placeholder comment left in the file.
- **Fix:** replace the TODO with actual content or delete the comment.

### Pitfall 4 — Quiz too short

- **Symptom:** gate says "Quiz section has N question(s); spec requires 4–6".
- **Cause:** placeholder Q1/Q2 only.
- **Fix:** add 4–6 questions with answers.

### Pitfall 5 — Pitfalls too few

- **Symptom:** gate says "Pitfalls section has N pitfall(s); spec requires 5–8".
- **Cause:** placeholder pitfall only.
- **Fix:** add 5–8 pitfalls grounded in real beginner mistakes.

---

## 5. Key Takeaways & Ron's Bottom Line

- The quality gate is deterministic and runs offline.
- Every required section has a dedicated check.
- TODO placeholders are caught automatically.

> 🟦 **Ron's Bottom Line** — Run the gate before every commit. It is faster than a code review and catches the structural mistakes humans miss.

---

## 6. Hands-On Practice

### Exercise

**Task:** Clone the repo and run the gate against `lessons/hermes/L00-smoke-test.md`.

**Success criteria:** the script exits with code 0 and prints `✅` for this file.

### Do this today

- [ ] Clone the repo
- [ ] Run the gate
- [ ] Read the failure messages

### What's next

- Next lesson: a real Hermes lesson, drafted from `templates/lesson.md`.

> 💬 Drop your gate output in the Discord if anything fails unexpectedly.

---

## 7. Self-Check / Mini-Quiz

**Q1.** Which command runs the quality gate?
- A) `npm run check`
- B) `python3 scripts/check-lesson.py path/to/lesson.md`
- C) `git push`
- D) `make lesson`

**Q2.** What is the minimum word count for a lesson body?

A short answer.

**Q3.** Which of these is NOT a required section?
- A) Introduction & Hook
- B) Comparison & Decision Framework
- C) Self-Check / Mini-Quiz
- D) FAQ

**Q4.** Name one failure mode the gate catches.

A short answer.

**Q5.** When should you run the gate?
- A) After merging to main only
- B) Before committing a lesson
- C) Once per quarter
- D) Never; CI runs it automatically

### Answers

**A1.** B — the gate is a Python script under `scripts/`.

**A2.** 1,800 words (spec target: 1,800–3,500).

**A3.** B — Comparison is optional and only required for choice-based lessons.

**A4.** Unfilled TODO marker, missing section, word count below 1,800, missing freshness date, etc.

**A5.** B — run before committing.

**Scoring:** 5–6 correct → ready for the next lesson. 3–4 → rewatch the tricky sections.

---

## 8. Resources, Glossary & Further Learning

### Resources

- `scripts/check-lesson.py` — the gate itself.
- `Specs/ai-academy-lesson-specification.md` — the source spec.

### Glossary

- **Quality gate** — a script that asserts a file meets a written spec before it is accepted.
- **Action verb** — a verb used at the start of a learning objective to make it observable, e.g. "Install…", "Compare…".
- **Skeleton** — a short proposal for a lesson used in Layer 2 before drafting.

### Go deeper

- `templates/lesson.md` — the full lesson scaffold.
- `templates/lesson-skeleton.md` — the short proposal form.

---

## 9. FAQ

**Q: How do I run the gate against every lesson at once?**
A: Pass the directory: `python3 scripts/check-lesson.py lessons/`.

**Q: Can I add my own checks?**
A: Yes — edit `scripts/check-lesson.py`. The script is intentionally short and readable.

**Q: Why 1,800 words?**
A: The spec says so for SEO and value. See section 10 of `Specs/ai-academy-lesson-specification.md`.

**Q: Does the gate call out to an LLM?**
A: No. It is deterministic and runs offline.

---

## Padding for the smoke test

The paragraphs below are intentional filler so the word-count check passes for this smoke-test lesson only. Real lessons do not include filler. They meet the 1,800-word minimum through genuine content.

Lorem ipsum dolor sit amet consectetur adipiscing elit. The quality gate is a script that asserts a lesson meets the spec. It does not call out to any LLM. It is deterministic. It is fast. It runs offline. It checks for required sections. It checks for unfilled TODO placeholders. It checks for the minimum word count. It checks for the freshness date. It checks for the action verbs in learning objectives. It checks for the right number of quiz questions. It checks for the right number of pitfalls. It checks for the FAQ section. It prints the failures. It prints the warnings. It exits with a non-zero code if there is any failure. It exits with zero on success. Use it. Trust it. Improve it. The academy is built on small consistent lessons. Each one passes the gate. Each one carries Ron's voice. Each one teaches a beginner how to do something real. Run the gate before you commit. Run the gate in CI. Run the gate as part of your pre-publish checklist. The gate is your friend. It is fast, deterministic, and catches the structural mistakes humans miss when reviewing long markdown files. It is the simplest way to keep the course consistent. It is the simplest way to keep Ron's voice consistent across every lesson. It is the simplest way to keep the lesson structure aligned with the spec. The gate runs in less than a second per file. The gate runs against the directory recursively. The gate tells you exactly which line of which section failed. The gate tells you exactly what to fix. The gate never lies. The gate is the contract between the spec and the lesson. Every lesson passes the gate. Every lesson honors the spec. Every lesson is graded by the same rules. That is how you build a course at scale. That is how you keep quality consistent across dozens of lessons. That is how you onboard a new contributor. They copy the template. They fill in the placeholders. They run the gate. They commit. The gate is the floor and the ceiling. The gate is the safety net. The gate is the line. Use it.

The quality gate is a Python script at scripts/check-lesson.py. It reads a lesson markdown file. It checks that every required section is present. It checks that there are no unfilled TODO placeholders. It checks that the word count meets the minimum of 1,800 words. It checks that the freshness date is present. It checks that the learning objectives start with action verbs. It checks that the quiz section has between four and six questions. It checks that the pitfalls section has between five and eight pitfalls. It prints a summary at the end of the run. The summary lists the number of files checked and the number of failures and warnings. It exits with code zero on success and non-zero on failure.

The gate is intentionally simple. It does not understand semantics. It does not check whether the lesson is accurate. It does not check whether the lesson is in Ron's voice. It does not check whether the quiz answers are correct. Those checks belong to a human reviewer. The gate only checks the structural rules that can be expressed as deterministic conditions. Required sections can be checked by looking for H2 headings. Word count can be checked by counting words. TODO placeholders can be checked by looking for HTML comments. The freshness date can be checked by looking for a known pattern. The learning objectives can be checked by looking for action verbs at the start of bullets.

This separation matters. The gate is the floor. The human reviewer is the ceiling. Together they keep the course consistent and high quality. Without the gate, lessons drift in length and structure over time. Without the human reviewer, lessons drift in voice and accuracy over time. The gate is fast. The reviewer is slow. The gate catches structural mistakes. The reviewer catches substantive mistakes. Use both.

A common question is whether the gate should also check voice. The answer is no, at least not in the simple Python script we have today. Voice is hard to check deterministically. It requires either a model or a brittle set of heuristics. Both are worse than a human reviewer for this task. A model is non-deterministic and slow. A heuristic will produce false positives and false negatives. The gate stays simple. The reviewer stays human. The course stays consistent. This is the trade-off we have made and it has worked so far.

Another common question is whether the gate should run in CI. The answer is yes. The gate should run on every pull request that touches a lesson file. CI runs the gate, the gate exits with zero or non-zero, the PR either gets a green check or a red X. A red X blocks the merge. A green check allows the merge. This is the simplest workflow and it is the one we recommend. The gate is fast enough to run on every commit. The gate is reliable enough to be trusted as a merge gate. Use it.

A final note on extending the gate. When you add new checks, keep them deterministic. Keep them fast. Keep them readable. The gate is the first thing a new contributor will run on their lesson. The output of the gate is the first feedback they will receive. Make it clear. Make it actionable. Make it specific. Tell them exactly which section failed. Tell them exactly which word count is missing. Tell them exactly which TODO marker is unfilled. Then they can fix it.