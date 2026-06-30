# L05 example — month-1 welcome sequence for an indie game-dev tools newsletter

The smallest "do it" demo for [L05 — The Online Business Stack for 2026](/lessons/ai-projects/l05-the-online-business-stack/).

Goal: one founder's month-1 stack applied to a real niche.
Picked from the **DO FIRST** quadrant: a welcome email sequence.
Niche: **indie game-dev tools** — a weekly digest for solo game developers.
End state: three emails, three Buttondown triggers, one Hermes Skill.

## The niche

**Indie game-dev tools for solo developers shipping without a studio.**
Audience: solo devs building 2D / 3D games with Godot, Unity, Unreal, or custom engines.
Why this niche: founder has shipped two commercial games using Aseprite, Tiled, Godot, and FMOD; reads the Game Maker's Toolkit Discord daily; has tried 14 tools personally.

## Stack at end of month 1

| Layer | Tool | Cost | Time to set up |
|---|---|---|---|
| Landing | Carrd single-page | Free | 1 hour |
| Product | This newsletter | Free | 2 hours |
| Email | Buttondown (free tier) | $0/mo | 30 min |
| Monetization | Stripe Payment Links (later) | 2.9% + 30¢ | 30 min (week 4) |
| Analytics | Plausible | $0–$9/mo | 30 min |
| Orchestration | Hermes cron | $3–$5/mo | 2 hours |

Total month-1 cash: **$0–$5/mo**. Models are the real cost — Kimi K2.7 at ~$0.012 per drafted email = ~$1 total for the welcome sequence.

## Step 1 — 60 minutes: write the three emails

Open Buttondown. Draft three emails. No HTML yet — plain text reads as more personal.

**Email 1 — Intro.** Sent immediately on sign-up.

```
Subject: welcome to the solo game-dev digest

hey —

thanks for signing up. i ship small games on weekends and write about
the tools that don't get in the way.

every monday morning you'll get a short note: one tool i tried, one
thing i shipped, one thing i quit. no pitches, no roundups.

reply with the engine you use — i read every reply.

— r
```

**Email 2 — Best work.** Sent 48 hours after sign-up.

```
Subject: the four tools that actually shipped my last game

hey —

you've been on the list for two days. here's the short version of the
tool stack that shipped "lattice" (1,400 wishlists, 22 reviews, 4 months
from start to ship):

1. Aseprite — every sprite, every animation. $20 once.
2. Tiled — every level, every tileset. Free.
3. Godot 4 — the engine. Free.
4. FMOD — the audio. Free for under $100K revenue.

that's the whole stack. nothing on this list costs more than $20.

the long version (with screenshots, gotchas, and the three things i'd
skip) goes out next monday. reply if you want the early cut.

— r
```

**Email 3 — A question.** Sent 7 days after sign-up.

```
Subject: which engine do you actually use?

hey —

quick one. which engine are you shipping on, and what's the one tool
you'd save if your house was on fire?

reply with the answer — i read every reply and use them to pick the
next monday's deep-dive topic.

— r
```

Total word count: 84 + 110 + 56 = **250 words across three emails**. Under 30 minutes to draft.

## Step 2 — 30 minutes: wire the triggers in Buttondown

In Buttondown, three automations:

| Email | Trigger | Send time |
|---|---|---|
| Email 1 (Intro) | New subscriber | Immediately |
| Email 2 (Best work) | New subscriber | 48 hours after sign-up |
| Email 3 (A question) | New subscriber | 7 days after sign-up |

Test path: sign up with your own email as a test subscriber. Confirm Email 1 lands within 60 seconds. Confirm Email 2 lands within 48 hours + 1 minute. Confirm Email 3 lands within 7 days + 1 minute.

If any of the three fails the smoke test, fix the trigger before you promote the landing page.

## Step 3 — 2 hours: write the Hermes Skill that tags by source

Save this Skill to `~/.hermes/skills/tag-by-source.md`:

```yaml
---
name: tag-by-source
description: Tag every new Buttondown subscriber by UTM source.
trigger: webhook
inputs:
  - email
  - utm_source
---

# Steps

1. Read the inbound webhook body for the new-subscriber event.
2. Pull `email` and `utm_source` from the payload.
3. If `utm_source` is empty, default it to "direct".
4. Call the Buttondown API to add a tag matching `utm_source`.
5. Log the result to `~/.hermes/logs/tag-by-source.jsonl`.
6. Return 204 to the webhook.
```

Then point the Buttondown signup webhook at the Hermes webhook endpoint. Confirm the Skill logs an entry on each test sign-up.

## Step 4 — verification

End of week 1, you should have:

- A landing page with a working signup form (verified with a real email).
- A welcome sequence that fires three emails on the schedule above.
- A Hermes Skill that tags every new subscriber by source.
- A log file with one entry per signup, ready for the week-2 weekly digest.

That's the foundation. Every other automation in L05 follows the same shape: a trigger, a sequence of steps, and a log.

## What to add in week 2

- Monday-morning Hermes cron that summarises the week's tag distribution and posts to Discord.
- Daily analytics scan that pings only when subscriber growth drops 30% week-over-week.
- Stripe Payment Link attached to Email 2 (best-work) — paid subscribers get a fourth deep-dive email.

See [Hermes L08](/lessons/hermes/l08-automation-cron-kanban-sub-agents/) for the cron pattern, and [L04](/lessons/ai-projects/l04-niche-directory-sites/) for the directory case study once you outgrow a newsletter.