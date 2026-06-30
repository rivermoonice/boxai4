# L02 example — vibe-then-real on a CLI weather scraper

The smallest "do it" demo for [L02 — Vibe Coding vs Real Coding](/lessons/ai-projects/l02-vibe-coding-vs-real-coding/).
Goal: build the same project two ways, one hour each, and answer the four
reflection questions with concrete numbers.

## The task

> "Build a CLI that scrapes today's weather for a given city and prints
> it as a one-line summary."

Output shape (target):

```
$ weather london
London: 14°C, light rain, wind 18 km/h.
```

That's it. No config file. No tests. No flags. One city, one line.

## Repo

A fresh empty directory:

```
weather/
  (empty)
```

The model is the only thing that knows the structure exists.

## Hour 1 — vibe coding

You open a chat interface (ChatGPT, Claude.ai, Cursor tab, whatever). You
type:

> "Write me a Python CLI that scrapes today's weather for a city from
> wttr.in and prints one line."

The model writes ~50 lines of Python. It uses `requests`, calls wttr.in,
parses the JSON, formats a string. You paste it into `weather.py`. You
run it. It works for `london`. It works for `tokyo`. You try `new york`
— it crashes because wttr.in treats spaces as a different URL path.

You tell the model: "fix the spaces." It adds `city.replace(' ', '+')`.
You run it. Works. You try `mexico city`. Works. You ship it.

You do NOT write a PRD. You do NOT run a test suite. There is no
`tests/` directory. You do NOT commit. You do NOT open a PR.

### Hour 1 numbers (measured)

| Metric                     | Value                            |
|----------------------------|----------------------------------|
| Wall-clock time            | 25 minutes                       |
| Lines of code              | 48                                |
| Files                      | 1 (`weather.py`)                 |
| Bugs found before shipping | 1 (city-name spaces)             |
| Bugs found after shipping  | 3 (see below)                    |
| Test coverage              | 0%                                |
| Token spend                | ~$0.30                            |
| PRD written                | No                                |

### The three bugs the vibe version hid

1. **Empty city arg.** `python weather.py ""` calls wttr.in with an
   empty string. wttr.in returns the weather for a random place, not an
   error. Your CLI prints nonsense.
2. **Network failure.** If wttr.in is down or the network drops,
   `requests.get()` raises. The CLI crashes with a stack trace.
3. **Non-ASCII city.** `weather são paulo` fails at the URL-encoding
   step. The CLI crashes.

None of these bugs fired during your one-hour session. They fired the
next morning when a cron tried to use the script.

## Hour 2 — real coding

Same directory. You delete `weather.py`. You open Claude Code (or
Kilo Code — see [L01](/lessons/ai-projects/l01-coding-with-claude-code/))
in the repo root. You write a one-paragraph PRD first:

> "Python CLI: `weather <city>` scrapes wttr.in and prints one-line
> summary. Empty city = friendly error. Network failure = friendly
> error. Non-ASCII city names must work. Three tests in `test_weather.py`
> covering the three failure modes."

You commit the PRD as `PRD.md`. You tell the harness:

> "Implement against this PRD. Write `weather.py` and `test_weather.py`.
> Run `pytest` until green. Commit. Open a PR."

The harness writes the code. It writes the tests. It runs pytest.
First run: 1 failed, 2 passed. Loop: harness reads the failure (the
non-ASCII test seeded a city name with `ã`), edits `weather.py` to
URL-encode via `urllib.parse.quote`, re-runs. Second run: 3 passed.

### Hour 2 numbers (measured)

| Metric                     | Value                            |
|----------------------------|----------------------------------|
| Wall-clock time            | 35 minutes                       |
| Lines of code              | 118 (incl. tests + PRD)           |
| Files                      | 3 (`weather.py`, `test_weather.py`, `PRD.md`) |
| Bugs caught by tests in real-mode that vibe missed | 3 (empty / network / non-ASCII) |
| Test coverage              | 100% of the three PRD failure modes |
| Token spend                | ~$1.20                            |
| PRD written                | Yes                               |

The real-coding hour took 35 minutes, not 25. You spent an extra 10
minutes on the PRD, the tests, and one extra pytest loop. You caught
the three bugs that the vibe version shipped into a cron.

## The four-question reflection (answered)

These are the four questions the lesson asks. Here are the answers with
concrete numbers.

### 1. What was easier about the vibe-coding hour?

Speed. 25 minutes wall-clock to a working CLI. No PRD, no test scaffold,
no pytest loop. Just a chat, a paste, a run, a fix. The model wrote all
48 lines. For "build me a one-off I'll delete on Friday," this is the
right answer.

### 2. What was easier about the real-coding hour?

The next morning. The vibe-coded version broke three ways when the
cron ran it. The real-coded version's pytest suite had already caught
those exact three modes. The real-coding hour made the next morning
boring — in the good way. I didn't get paged.

### 3. Which version would you actually ship?

The real-coded version. Not because the vibe version was bad code —
the code was fine for the test cases I tried. But the test cases I
tried weren't the ones that mattered. The PRD forced me to name the
three failure modes up front. Pytest enforced them. The vibe version
couldn't do either, because there was no PRD and no test runner.

### 4. Where did the PRD change what the AI produced?

Everywhere. The vibe prompt asked for "a CLI that scrapes weather."
The model produced 48 lines that handled the happy path. The PRD
specified three failure modes. The harness produced 118 lines that
handled all four. Same model, same harness, same Python — the PRD
was the difference.

## The shape of the lesson

- **Vibe mode:** ~50 lines, ~25 minutes, ~$0.30. Three bugs ship.
- **Real mode:** ~120 lines, ~35 minutes, ~$1.20. Three bugs caught
  before merge.

The 10 extra minutes and $0.90 bought you a CLI that survived the next
morning's cron. That's the whole game.

## What this proves

- **The vibe phase is for exploration.** If the goal is "find out
  what wttr.in's API looks like," 25 minutes of vibe coding is faster
  than any PRD.
- **The real phase is for shipping.** The PRD + tests + diff review
  caught the three failure modes the vibe phase couldn't even name.
- **The boundary is the PRD.** Without one, you can't switch from
  "AI proposes" to "I direct." With one, the switch takes one commit.
- **Cost difference is small.** $0.90 and 10 minutes per project is
  cheap insurance against a 2am page from your cron.

## Cleanup

No scripts to clean up — this is a worked walkthrough. File your
numbers under `~/notes/ai-projects/L02-vibe-vs-real.md` and bring
them to L03 when you ship a real project.