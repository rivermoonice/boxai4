# L03 example — shipping a Slack standup bot in one weekend

The smallest "do it" demo for [L03 — Build a Side Project with Hermes + Claude Code in One Weekend](/lessons/ai-projects/l03-building-with-hermes/).

Goal: pick one real product, trace the four-step flow end-to-end. Show the
files, the commands, and the time spent on each step. End with the
ship-or-fix decision a real weekend produces.

## The product angle

**Slack-standup-bot** — a small bot that posts a daily 9:00am standup prompt
in a chosen Slack channel, collects each user's "yesterday / today /
blockers" replies, and reposts the roll-up at 9:30am. One team uses it.
No login, no admin dashboard, no auth.

Why this fits the weekend:
- 2 features (collect, post roll-up). 1 data model (standup row).
- 1 user flow (channel members reply → roll-up appears).
- 0 auth (Slack workspace token is read from env, no per-user flow).
- 1 deploy target (Fly.io, single VM, $5/mo).

## Step 1 — Friday 7pm, 30 minutes: sketch with Hermes

Open Hermes. Run the brainstorm slash command with the niche
("internal tools for small dev teams") as input:

```
/brainstorm-angles niche="internal tools for small dev teams" weight=weekend-fit
```

Hermes returns three angles ranked by weekend-fit:

1. **Slack standup bot** — 2 features, 1 cron, 1 deploy. Weekend-fit: 9/10.
2. **GitHub-issue-to-Notion sync** — 3 features, OAuth round-trip. Weekend-fit: 6/10.
3. **Meeting-notes-to-README generator** — needs transcription, hosting. Weekend-fit: 4/10.

Pick angle 1. Total time: 12 minutes.

## Step 2 — Friday 7:15pm, 1 hour: write the spec with Hermes

Run the spec-writing slash command with the chosen angle:

```
/write-spec angle="slack-standup-bot" features=2 deploy=fly
```

Hermes returns a 90-line `SPEC.md`. You edit for taste (rename `standup_row`
→ `standup_entry`, drop the "future features" section that wasn't asked
for). Save it to `~/code/slack-standup/SPEC.md`.

### `SPEC.md` (final, 78 lines)

```markdown
# Slack Standup Bot — SPEC

## 1. Features

- **F1 — Daily prompt.** At 09:00 in `TZ=Europe/London`, post a message to
  the configured Slack channel asking: "What did you ship yesterday? What
  are you shipping today? Any blockers?"
- **F2 — Daily roll-up.** At 09:30, collect every reply in that channel
  thread and post a roll-up message: one line per user, formatted
  `name — yesterday / today / blockers`.

## 2. Data model

```
standup_entry:
  slack_user_id: string  # U-prefixed Slack ID
  display_name:   string  # captured at first reply
  yesterday:      string  # free text, max 800 chars
  today:          string  # free text, max 800 chars
  blockers:       string  # free text, max 400 chars
  posted_at:      iso8601  # when the reply was collected
  channel_id:     string  # the channel the prompt was posted in
```

Storage: SQLite at `/var/lib/slack-standup/state.db`. No migrations; one
table, created on first run.

## 3. Edge cases

- **No replies by 09:30.** Post a roll-up that says "No replies today."
- **User posts a top-level message, not a thread reply.** Ignore it; the
  thread is the only thing we collect.
- **User replies twice.** First reply wins, second reply is dropped.
- **Slack API rate-limit error.** Retry with exponential backoff, 3 tries,
  then log and move on (the next day still runs).

## 4. Test plan

- `test_prompt_formats_correctly()` — assert the 09:00 message contains
  the three required questions and a "Reply in thread" prompt.
- `test_rollup_aggregates_thread_replies()` — given a fixture thread of
  3 replies, assert the roll-up has 3 lines in the order replied.
- `test_rollup_handles_no_replies()` — given an empty thread, assert
  the roll-up is exactly "No replies today."
- `test_duplicate_reply_is_dropped()` — given a user posting twice,
  assert only the first reply is in the roll-up.
- `test_db_created_on_first_run()` — given an empty `/var/lib/slack-standup`,
  assert the table is created and the file is writable.

## 5. Done = deployed

"Done" means:
- `pytest` is green.
- A `fly deploy` produces a URL.
- The deployed bot's first 09:00 prompt lands in the test channel
  within 60 seconds of the cron firing.

Nothing else counts as done. No admin UI. No analytics. No settings page.
```

Total time including editing: 55 minutes.

## Step 3 — Saturday 9am–4pm, 6 hours: build with Claude Code

Open Claude Code in the fresh repo:

```
cd ~/code/slack-standup
claude
```

You paste one prompt (this is the only prompt you write all day):

> "Read SPEC.md. Implement feature by feature. Run `pytest` after each
> feature. Commit when green. Stop and ask me if the spec is unclear —
> don't invent features."

Claude Code's first move is a plan summary:

```
I'll create:
  - app/main.py            (cron entry, F1 + F2)
  - app/slack.py           (Slack Web API client, retry helper)
  - app/db.py              (SQLite wrapper, table-create on first run)
  - app/rollup.py          (thread collection + roll-up formatter)
  - tests/test_*.py        (one file per test in SPEC.md §4)
  - fly.toml               (Fly.io deploy config)
  - requirements.txt       (slack_sdk, pytest)

I'll commit per feature. I'll run `pytest -q` after each commit.
```

You watch the loop run. The five commits land in this order:

```
9:14  feat: scaffold + db.py + tests/test_db.py       (pytest: 1/1)
9:48  feat: slack.py + tests/test_slack.py            (pytest: 2/2)
10:31 feat: rollup.py + tests/test_rollup.py          (pytest: 3/3)
11:17 feat: F1 daily prompt + tests/test_prompt.py    (pytest: 4/4)
13:42 feat: F2 daily roll-up + tests/test_thread.py   (pytest: 5/5)
```

One red at 12:04. Claude Code caught it on the second pass and explained
the fix: "The thread-reply collector was using `ts` of the parent
message; it needs `thread_ts` for the API call. Fixed."

By 4pm, `pytest -q` is green, 5/5. Total time on the loop: 6 hours, 22
minutes (lunch break included). The diff is 612 lines across 11 files.

## Step 4 — Sunday 10am–1pm, 3 hours: review with Hermes, close out with Claude Code

Open Hermes. Point it at the spec and the codebase:

```
/verify-spec spec=~/code/slack-standup/SPEC.md code=~/code/slack-standup
```

Hermes returns a gap list (paraphrased, 14 items):

```
PASS:
  - F1 daily prompt
  - F2 roll-up aggregation
  - All 5 tests from SPEC.md §4

PARTIAL:
  - Edge case "duplicate reply" — covered by test, but the implementation
    uses `INSERT OR IGNORE` on `slack_user_id + posted_at`, which only
    catches truly identical posts. A user editing their reply (different
    timestamp) is not deduped. Ship as-is, file as known-issue.

MISSING:
  - Retry on Slack 429 — implemented but no test. Add a unit test that
    asserts 3 retries then log-and-move-on.
  - README.md — required for "done" per SPEC.md §5. Not yet written.
  - fly.toml — exists, but `fly launch` was never run, so the app is
    not deployed. Required for "done" per SPEC.md §5.
```

You take the MISSING list back to Claude Code:

```
> Read Hermes' gap list above. Add the missing test, write README.md,
> run `fly launch --no-deploy`, commit, and stop. I'll handle deploy.
```

By 1pm, `pytest -q` is 6/6 green. README.md is 24 lines. `fly launch`
produced a `fly.toml` with the right region. You commit and stop.

## The deploy — Sunday 1:30pm, 30 minutes

You do this by hand (Claude Code could, but you want the first deploy
to be on you — the failure modes are infra-shaped, not code-shaped):

```
cd ~/code/slack-standup
fly deploy
fly secrets set SLACK_BOT_TOKEN=xoxb-... SLACK_CHANNEL_ID=C0...
fly cron add "0 9 * * 1-5" --command "python -m app.main prompt"
fly cron add "30 9 * * 1-5" --command "python -m app.main rollup"
```

First deploy fails: missing `SLACK_SIGNING_SECRET` env var. Add it,
re-deploy, second deploy succeeds. URL is
`https://slack-standup.fly.dev`. Health check returns 200.

You don't wait until 9am Monday. You post a manual prompt to the test
channel right now and watch the thread + roll-up fire. Both work. Total
deploy time: 28 minutes.

## The ship-or-fix decision

By Sunday 1:30pm you have:

- A green test suite (6/6).
- A deployed URL that responds.
- A verified manual run of both F1 and F2 in the test channel.
- One known-issue filed (the duplicate-reply dedupe is best-effort).
- The spec matches the shipped behaviour (Hermes verified on Sunday).
- A README.md that explains the deploy + cron commands.

**Ship.** Push the final commit. Send the team a link to the deployed
bot. Set the cron schedule. The first real 9:00am standup lands Monday.

Total weekend time, Friday 7pm to Sunday 1:30pm: **18.5 hours** of work,
spread over three evenings. The bot is in production.

## Time budget vs plan

| Step | Plan | Actual | Notes |
|---|---|---|---|
| 1 — Sketch (Hermes) | 30 min | 12 min | 3 angles, picked the smallest |
| 2 — Spec (Hermes) | 1 hr | 55 min | 1 round of edits, no rewrites |
| 3 — Build (Claude Code) | 6–8 hr | 6 hr 22 min | 1 red caught on second pass |
| 4 — Review + close-out | 3–4 hr | 3 hr | 14-item gap list, 3 misses, fixed |
| Deploy (you) | — | 28 min | One env var missing, easy fix |
| **Total** | 10.5–13.5 hr | **10 hr 57 min** | Plus Friday's spec (55 min) |

The pattern held: thinking tools did the thinking, building tool did the
building, you carried the deploy and the taste.

## What you actually delegated

To Hermes:
- Choosing between three product angles.
- Drafting the 78-line `SPEC.md`.
- Diffing the shipped behaviour against the spec on Sunday.

To Claude Code:
- 612 lines of code across 11 files.
- 5 commits over 6 hours, with 1 red-then-green.
- Final test for the missing-429-retry case.
- README.md draft.

To yourself (only):
- Picking the product angle (judgment, not generation).
- Editing the spec for taste.
- Watching the loop on Saturday and answering one clarifying question.
- The first deploy (infra failure mode, not code).

## What you'd do differently next weekend

- **Add a smoke-test cron.** Schedule a "dry-run" at 08:55 every day that
  verifies the bot token is still valid. Catches token rotation before
  the real prompt fires.
- **Save the Hermes prompts as a skill.** `/brainstorm-angles`,
  `/write-spec`, `/verify-spec` are now in your skill bundle. Re-use
  them next weekend without re-asking.
- **Skip the close-out README in Claude Code, write it in Hermes.**
  README is markdown output — Hermes is the right tool. Reserve Claude
  Code for code-adjacent close-out (deploy config, screenshots, final
  diff clean-up).
