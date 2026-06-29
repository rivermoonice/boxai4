# Article Improvement TODO — driven by critique loop

> Goal: every lesson is **clear, punchy, high information-density**, and **interactive**. No
> "AI slop" — no padding, no throat-clearing, no vague "this is important" sentences.

Two agents run on a staggered cadence:
- **critic** — every **30 min** — scans one lesson, lists specific problems with line refs.
- **writer** — every **15 min** (offset 15 min from critic) — picks up critic notes for one lesson
  and revises. Works on a *different* lesson than the one the critic just scored.

Each pass leaves a dated note in this file so we can see what changed.

---

## Critic rubric — scored 1–10 on four axes

The critic scores **every lesson** on these four axes, then gives a single
verdict. No hedging, no "overall good." Each score is one integer with one
sentence of justification.

| Axis | 10 | 1 |
|---|---|---|
| **Information density** | Every sentence carries a number, file path, command, named tool, or concrete claim | Paragraphs of "important to note" and "this is a powerful tool" with zero facts |
| **Directness** | Takeaway in sentence 1 of every section; answers the question before explaining why | ChatGPT-anecdote openers, throat-clearing, "let's dive in," buried lede |
| **Readability** | ≤20-word sentences; every term defined on first use; grade 8 reading | 50+ word sentences, un-explained acronyms ("MCP", "TUI", "RAG" with no expansion) |
| **Interactivity** | Runnable `example.sh`, separate `quiz.json`, `test.sh`, every section makes learner do something | Read-only essay; quiz inlined as MDX JSX with no extractable JSON; nothing to run |

**Verdict is mechanical:** if any axis is ≤4, the lesson **FAILS** and ships
nothing — the writer must revise before the next critic tick. 5–7 = PASS
WITH REVISIONS (writer should address all flags). 8+ on every axis = SHIP.

## AI-slop checklist (still apply, this is the WHY behind the score)

Every flag gets a line citation. Be savage — a real teacher would not let
these sentences stand.

1. **Padding sentences** — "It's important to note that…", "Let's dive in",
   "This is a powerful tool that…", "Hopefully this gives you a better
   understanding of…". Cut.
2. **Hedge stacking** — "may", "might", "could potentially", "generally
   speaking", "in many cases", "almost always". Pick a stance or cite a source.
3. **Sycophantic intros** — "Great question!", "Absolutely!", "Let's break
   this down". Cut.
4. **Repetition** — same fact restated in two consecutive paragraphs. Keep one,
   cut the other, name the line numbers.
5. **Vague nouns** — "tools", "things", "aspects", "elements", "components",
   "toolkit" with no named example. Replace with a concrete name.
6. **Trailing meta** — "In the next section we'll…" (just write the next
   section).
7. **List bloat** — bullet lists where 4 of 6 items say the same thing in
   different words.
8. **Filler paragraphs** — zero new facts vs. the prior paragraph. Cut or merge.
9. **Long sentences (>35 words)** — split. Quote the line, count the words.
10. **No-example claims** — "X is faster" / "Y is more secure" without a
    number, source, or scenario.

## Required critic output (every tick)

Every critic report MUST contain, in order:

1. **Lesson path** and line count.
2. **Four scores** (density / directness / readability / interactivity) —
   each a single integer 1–10 with one justifying sentence.
3. **Overall verdict** — `FAIL` / `PASS WITH REVISIONS` / `SHIP`.
4. **Kill list** — at least **5 specific sentences to delete**, each with
   the line number quoted verbatim. No "consider tightening" — name the
   sentence.
5. **Slop flags by line** — every numbered checklist item above that hits,
   with the line quoted.
6. **Missing artifacts** — for Hermes specifically, list which of
   `example.sh` / `quiz.json` / `test.sh` are missing from
   `site/src/lessons/<module>/<lesson-id>/`. If the directory doesn't exist,
   say so.
7. **Top 3 fixes for the writer**, ordered by impact on the lowest-scored axis.

The critic does NOT edit the lesson. The note goes into article-todo.md log.

## Writer's contract (matches the rubric)

- Lead with the **takeaway** in sentence 1 of every section.
- **Every paragraph = one fact.** Two-facts-per-paragraph = split or cut one.
- Replace adjectives with numbers, filenames, commands, or named tools.
- Every CodeBlock: real command that runs. No `<placeholder>`.
- Every claim about behavior cites a YouTube segment `{ts, summary_segment}`
  (already in the lesson); drop the claim if unsourced.
- **Interactive layer:** every lesson gets `site/src/lessons/<module>/<lesson-id>/`:
  - `example.sh` or `example.md` — the smallest "do it" demo
  - `quiz.json` — separate JSON, not inlined MDX — consumable by `Quiz.tsx`
  - in Hermes specifically, also `test.sh` that greps for required terms and
    exits non-zero on miss
- Internal links: every lesson links to ≥1 other lesson via
  `[Lxx-slug](/lessons/<module>/Lxx-slug/)`. Wiring check:
  `python3 scripts/check-lesson.py`.

## Cadence

- **t = 0**        : critic picks lesson #1 (round-robin)
- **t = 15 min**   : writer picks lesson #2, reads latest critic note, revises
- **t = 30 min**   : critic picks lesson #3 (next in round-robin), notes appended below
- **t = 45 min**   : writer picks lesson #4, revises
- ... continue until every lesson has been critiqued twice and revised at least once.

**Stagger rule (critical):** writer works on the SAME lesson the critic just scored. Critic
scores lesson X; writer picks up X and applies the fixes immediately. Then both advance to
the next lesson. This way every critique produces an immediate revision, and the writer
never touches a lesson the critic hasn't yet flagged.

## Round-robin order (lesson IDs)

Hermes (9):       L01, L02, L03, L04, L05, L06, L07, L08, L09
AI models (5):    L01, L02, L03, L04, L05
AI projects (5):  L01, L02, L03, L04, L05

Both queues (identical, offset is just by phase — critic scores, writer fixes):
L01-hermes → L02-hermes → ... → L09-hermes →
L01-models → L02-models → ... → L05-models →
L01-projects → L02-projects → ... → L05-projects → (loop)

State machine: writer's next pick = whatever lesson the critic most recently finished.
Writer and critic run on different ticks (15 min vs 30 min) so they never collide on
the same lesson at the same time.

## Note log (appended each tick)

> Format: `YYYY-MM-DD HH:MM | agent | lesson | one-paragraph note`

<!-- entries appended below by agents -->

2026-06-29 23:45 | writer | hermes/L02-install-and-first-run | Applied all critic fixes from the 4-axis rubric: rewrote over-packed 4-fact opener (line 26) to one 16-word sentence with takeaway in position 1; deleted the 29-word throat-clearing tail on line 30; deleted redundant rule-of-thumb (former line 60) that duplicated the Mac/VPS table; collapsed the 6-row decision table to 4 rows by merging "brand new to terminals" + "cheapest test drive" into one Mac row; rewrote buried VPS lede (former line 84) to lead with "VPS path = SSH + the same installer"; expanded SSH and BYOK on first body-text use; replaced un-sourced "Hard reasoning" / "Strong tool-call reasoning" claims with concrete "Long-context or high-stakes deliverables" / "Cost-efficient, broad capability"; paired the chat smoke-test block (155-159) with a verifiable non-interactive one-liner `hermes doctor && echo verified || echo FAILED`; deleted the "If everything is green" meta conclusion; cut the trailing "Which interface do you actually use day to day?" question fragment; trimmed the closing Callout from 4 sentences to one new fact ("week 1 = Mac; week 2 = try VPS on a $3 box"); split the 27-word error-cause sentence to 2 sentences. Created site/src/lessons/hermes/L02-install-and-first-run/ with example.sh (detects Darwin vs Linux, asserts curl/git/xcode-select/ssh/apt-get/bash-4+, no actual install — exits non-zero on miss with a fix hint; ran on this Linux host: 5/5 ok), quiz.json (6 standalone questions, valid JSON), and test.sh (greps for xcode-select --install, hermes doctor, hermes status, BYOK, SSH, three cross-links to L03/L07/L08, four section headers, freshness line, <Quiz>, and three artifacts — 17/17 ok). check-lesson.py: PASS, 0 failures, 0 warnings. test.sh: PASS, 17/17 checks.

2026-06-29 22:55 | critic | hermes/L01-what-is-hermes-agent | Re-critique against 4-axis rubric. Density 7 (long metaphors repeat, padding sentences at 25/31/33/122), Directness 6 (line 25 leads with a 52-word anecdote before the takeaway, line 49's "almost always" is un-sourced, section 1 hook at 29-33 buries the lesson), Readability 4 (lines 25, 33, 57, 74, 100 all exceed 35 words; line 25 = 52 words, line 100 = 51 words), Interactivity 1 (no site/src/lessons/hermes/L01-what-is-hermes-agent/ directory — no example.sh, no separate quiz.json, no test.sh; quiz inlined as MDX JSX at 150-192). Verdict: FAIL. Top fixes: (1) cap all sentences at 20 words, (2) lead each section with the takeaway in sentence 1, (3) create the artifacts directory with example.sh/quiz.json/test.sh.

2026-06-29 22:37 | critic | hermes/L01-what-is-hermes-agent | Scored the lesson against the 10-item AI-slop checklist. Overall it is dense and well-structured, but it carries several checklist-1/3/5/6/9 violations: (1) Padding/leading questions and throat-clearing in the intro hook ("If you've ever asked ChatGPT a question, watched it give you a confident answer, and then realised the answer was completely wrong — you already know the gap between..." — line 25), the redundant "Pick a task you do every week." framing (line 31), and the empty tail sentence "That's what you're working with." (line 122). (2) One hedge stack on line 49 ("the problem is almost always the harness") — "almost always" is un-sourced. (3) Sycophantic fragment "No install yet — this is pure concept." on line 27 borders on throat-clearing. (4) Repetition of the model-is-brain / harness-is-body metaphor across lines 37, 41, 43, 49 is fine, but the table on lines 65-72 restates the same picking rule twice (once per row, once in the "Rule of thumb" line 74) — collapse the table or the rule. (5) Vague nouns: "things" (line 33 "thing that *works for you in the background*", line 104 "It's a *toolkit*"), "components" (line 113 "every component"), "apps" (line 99). (6) Trailing-meta "What's next" section at lines 194-197 is OK because it has real links, but the inside-lesson Callout at lines 199-201 duplicates the table's advice verbatim — cut one. (7) The "When to pick which" table at 65-72 has 6 rows that split "use Claude Code for code work" into three rows (build/refactor/one-off) — that's list bloat; collapse to one row. (8) No filler paragraphs spotted. (9) Several long sentences: line 25 (52 words), line 33 (47 words), line 57 (53 words), line 74 (49 words), line 100 (51 words), line 140 (35 words borderline). (10) "one of the most popular open-source harnesses in 2026" (line 25) and "one of the most-starred open-source AI projects on GitHub in 2026, with over 200,000 stars" (line 84) — the stars number has no source URL; either link the GH repo or drop the number. Missing interactive artifact: the directory site/src/lessons/hermes/L01-what-is-hermes-agent/ does not exist — no example.sh, no quiz.json (the quiz is inlined as MDX `<Quiz>` JSX at lines 150-192 but the writer's checklist explicitly asks for a separate quiz.json consumable by Quiz.tsx), no test.sh. Recommendation to writer: split the long intro paragraph, replace "things/apps/components" with file or command names, cite the 200k stars or cut it, and create site/src/lessons/hermes/L01-what-is-hermes-agent/{example.sh,quiz.json}.

2026-06-29 23:25 | critic | hermes/L02-install-and-first-run | 4-axis re-score. Density 7 (most body sentences carry a command/flag/file path, but line 26 packs 4 facts into one opener and line 60 repeats the rule of thumb already in the table at 62-69), Directness 7 (every section opens with the takeaway — line 26, 30, 48, 99, 122 — though line 84's "The VPS path takes longer only because of SSH" buries the lede), Readability 7 (longest body sentence ~24 words; line 26 reads as four short sentences chained with periods — clean; no >35-word sentences found), Interactivity 3 (quiz inlined as MDX JSX at 186-223, no standalone quiz.json; the artifact dir site/src/lessons/hermes/L02-install-and-first-run/ does not exist — no example.sh, no test.sh; the only "exercise" at 169-175 is pen-and-paper). Verdict: FAIL (Interactivity ≤4). Top fixes: (1) create site/src/lessons/hermes/L02-install-and-first-run/ with example.sh, standalone quiz.json, and test.sh, (2) cut line 60 (rule of thumb duplicates table 62-69) and the line 26 over-packed opener, (3) wire the "exercise" at 169-175 to actually run a verifiable assertion.
