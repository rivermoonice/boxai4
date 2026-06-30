# L01 example — the dev loop on a real task

The smallest "do it" demo for [L01 — What Is Claude Code?](/lessons/ai-projects/l01-coding-with-claude-code/).
Goal: trace one real task through the dev loop, step by step. Name where the
harness drives and where the engineer is still in the loop.

## The task

> "Add a `?since=` filter to the user list endpoint, and update the tests."

Repo: a FastAPI service with SQLAlchemy + pytest. Files that matter:

- `app/routes/users.py` — defines `GET /users`
- `app/models/user.py` — `User` SQLAlchemy model with `created_at`
- `app/serializers/user.py` — `UserListSerializer`
- `tests/test_users.py` — endpoint tests
- `pyproject.toml` — `pytest`, `uvicorn`, `httpx`

The current endpoint returns every user. The new endpoint should accept
`?since=YYYY-MM-DD` and filter `created_at >= since`.

## Step 1 — editor (you drive)

You open Claude Code in the repo root:

```
claude
```

You describe the task in plain English:

> "Add a `?since=` query param to `GET /users` that filters users by
> `created_at >= since`. Update the existing tests and add one new test for
> the filter. Run `pytest` until it's green, then commit and open a PR."

Two things you do NOT delegate: the wording of the requirement and the
acceptance criteria. Both are engineering judgment, not model output.

## Step 2 — harness reads files (Claude Code drives)

Claude Code scans the repo. It surfaces a short plan:

```
I'll modify:
  - app/routes/users.py  (add since param, filter the query)
  - tests/test_users.py  (add a new test, update existing ones)

I'll run: pytest -q
I'll commit on green.
```

The plan is for your review. You can accept, edit, or reject. This is the
diff-review gate — you stay in the loop.

## Step 3 — harness proposes a diff (Claude Code drives)

Claude Code proposes a diff. Example shape:

```diff
- @router.get("/users", response_model=list[UserOut])
- def list_users(db: Session = Depends(get_db)):
-     return db.query(User).all()
+ @router.get("/users", response_model=list[UserOut])
+ def list_users(
+     since: date | None = None,
+     db: Session = Depends(get_db),
+ ):
+     q = db.query(User)
+     if since is not None:
+         q = q.filter(User.created_at >= since)
+     return q.all()
```

You skim the diff. You notice: the import for `date` is missing. You tell
Claude Code to add it. The harness is fast but blind to missing imports
across files; you stay in the loop.

## Step 4 — harness runs the test runner (the validation harness)

Claude Code runs `pytest -q`. Two outcomes:

- **Green.** The suite passes. Move to step 7.
- **Red.** The runner prints an error. The harness reads the error, fixes
  the code, and re-runs. Loop until green.

Real output from this task on the first run:

```
$ pytest -q
2 failed, 4 passed
FAILED tests/test_users.py::test_list_users_since_filter
FAILED tests/test_users.py::test_list_users_default_returns_all
```

The two failures: the new test expects only users after the filter date,
but the fixture seeds `created_at` with `datetime.utcnow()` (timezone-naive),
and the comparison uses `date.today()` (timezone-naive). Off-by-one in the
seed timestamps.

## Step 5 — harness loops on red (Claude Code drives)

Claude Code reads the failure, edits `conftest.py` to seed `created_at` as
`datetime.combine(date.today(), time.min)`, and re-runs `pytest`. Output:

```
$ pytest -q
6 passed
```

Loop count on this task: 2 red → 1 green. Typical range: 1–5 loops.

The harness's only feedback is the test runner. If your tests are weak,
green doesn't mean correct — that's the lesson of L02.

## Step 6 — harness proposes a commit (Claude Code drives, you accept)

On green, Claude Code proposes a commit message and the files to stage:

```
feat(users): add ?since= filter to GET /users

Filter users by created_at >= since. Default (no param) keeps the
existing all-users behaviour. Updates 2 existing tests, adds 1 new
test for the date filter.

Files: app/routes/users.py, tests/test_users.py, tests/conftest.py
```

You can edit the message. Then the harness runs `git commit` and
`git push`.

## Step 7 — harness opens the PR (Claude Code drives)

Claude Code uses the `gh` CLI to open a PR:

```
gh pr create --title "feat(users): add ?since= filter" \
  --body "Implements the date filter. Closes #142."
```

The PR is ready for human review. The harness stops here — review is the
engineer's job, not the model's.

## What you actually delegated

- Reading 5 files to understand the existing test layout.
- Writing the route change + the new test.
- Running `pytest`, reading the failure, editing the seed timestamps.
- Commit message, `git push`, `gh pr create`.

Time on this task by hand: ~25 minutes. Time with the harness: ~6 minutes
(wall-clock, including two human review pauses).

## Where you stayed in the loop

Three judgment calls the harness can't make:

1. **The wording of the requirement.** "Filter by created_at" is a human
   decision — does `since` mean inclusive or exclusive? Default behaviour
   when the param is missing? You pick.
2. **Diff review.** The harness proposed code without the `date` import.
   You caught it.
3. **Final review.** The harness wrote the PR description from the diff.
   You edit it before merging.

These three loops are the whole point of a coding harness: it accelerates
the mechanical parts and stops at every judgment call.

## What this proves

- **Claude Code owns the dev loop end-to-end.** Editor → diff → tests → red
  → green → commit → PR. The model drives every mechanical step.
- **The engineer owns the judgment.** Requirement wording, diff review,
  final review. Three places where "looks right" still has to mean "is
  right."
- **Tests are the validation harness.** Without `pytest` in this repo,
  there is no loop. The harness would have nothing to check against. That
  is why L02 covers test-first prompting in depth.

## Cleanup

No scripts to clean up — this is a worked walkthrough. File your loop
notes under `~/notes/ai-projects/L01-dev-loop.md` and bring them to L02.