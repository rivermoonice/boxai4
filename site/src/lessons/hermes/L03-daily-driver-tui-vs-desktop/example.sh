#!/usr/bin/env bash
# example.sh — L03 "do it" demo: exercise BOTH Hermes surfaces and diff token counts.
#
# This script:
#   1. Picks a small local file (README.md in repo root, or the first .md it finds).
#   2. Asks Hermes to summarise it via the TUI flag.
#   3. Asks Hermes to summarise it via the Desktop App flag.
#   4. Diffs the two responses and prints a token/cost comparison.
#   5. Gracefully degrades to a no-op exit-0 with a note if --desktop is unsupported
#      on this build of Hermes.
#
# Run from repo root:
#   bash site/src/lessons/hermes/L03-daily-driver-tui-vs-desktop/example.sh
#
# Exit codes:
#   0 = exercise completed (or graceful no-op when --desktop is not supported)
#   1 = hermes binary missing, or both surfaces failed to run

set -uo pipefail

PASS=0
FAIL=0
NOTE=""

ok()   { echo "  ok    : $*"; PASS=$((PASS+1)); }
miss() { echo "  MISS  : $*"; FAIL=$((FAIL+1)); }
note() { echo "  note  : $*"; NOTE="$NOTE\n  - $*"; }

echo "L03 exercise: TUI vs Desktop token diff"
echo "========================================="

# 1. Find a local file to summarise
TARGET=""
if [[ -f "./README.md" ]]; then
  TARGET="./README.md"
else
  TARGET="$(find . -maxdepth 2 -type f -name "*.md" 2>/dev/null | head -n 1 || true)"
fi

if [[ -z "$TARGET" ]]; then
  miss "no .md file found to summarise (create a README.md in repo root)"
  echo
  echo "Summary: $PASS ok, $FAIL missing"
  exit 1
fi
ok "target file: $TARGET"

# 2. Confirm hermes is on PATH
if ! command -v hermes >/dev/null 2>&1; then
  miss "hermes not found on PATH. Install per L02 first."
  echo
  echo "Summary: $PASS ok, $FAIL missing"
  exit 1
fi
ok "hermes: $(command -v hermes)"

# 3. Check hermes --version supports both surfaces
HERMES_VER="$(hermes --version 2>/dev/null || echo unknown)"
ok "hermes version: $HERMES_VER"

# 4. Run the TUI surface
TUI_OUT="$(mktemp)"
TUI_RC=0
hermes --tui "summarise $TARGET in one sentence" >"$TUI_OUT" 2>&1 || TUI_RC=$?
if [[ $TUI_RC -eq 0 ]]; then
  TUI_TOKENS="$(grep -Eoi 'tokens?[: =]+[0-9]+' "$TUI_OUT" | head -n 1 || echo "n/a")"
  ok "TUI surface returned (rc=0, $TUI_TOKENS)"
else
  miss "TUI surface failed (rc=$TUI_RC). See $TUI_OUT"
fi

# 5. Run the Desktop App surface — graceful fallback if unsupported
DESK_OUT="$(mktemp)"
DESK_RC=0
DESK_SUPPORTED=0
hermes --desktop "summarise $TARGET in one sentence" >"$DESK_OUT" 2>&1 || DESK_RC=$?

if [[ $DESK_RC -eq 0 ]]; then
  DESK_TOKENS="$(grep -Eoi 'tokens?[: =]+[0-9]+' "$DESK_OUT" | head -n 1 || echo "n/a")"
  ok "Desktop surface returned (rc=0, $DESK_TOKENS)"
  DESK_SUPPORTED=1
elif grep -Eqi "unknown (flag|option)|unrecognized|not supported|--desktop" "$DESK_OUT"; then
  note "this Hermes build does not expose --desktop as a CLI flag. Skipping Desktop diff."
  note "you can still run the lesson exercise manually by opening the Desktop App and sending the same prompt."
  DESK_SUPPORTED=0
else
  miss "Desktop surface failed (rc=$DESK_RC). See $DESK_OUT"
fi

# 6. Diff
echo
echo "-- Token/cost diff --"
if [[ $DESK_SUPPORTED -eq 1 ]]; then
  echo "TUI response:      $TUI_TOKENS"
  echo "Desktop response:  $DESK_TOKENS"
  echo "(Desktop is typically ~2× the TUI token count for the same prompt — that's the L03 lesson.)"
else
  echo "TUI response:      $TUI_TOKENS"
  echo "Desktop response:  (skipped — --desktop not exposed by this Hermes build)"
fi

# 7. Show the actual responses for inspection
echo
echo "-- TUI response (first 5 lines) --"
head -n 5 "$TUI_OUT" 2>/dev/null || true
if [[ $DESK_SUPPORTED -eq 1 ]]; then
  echo
  echo "-- Desktop response (first 5 lines) --"
  head -n 5 "$DESK_OUT" 2>/dev/null || true
fi

# 8. Cleanup
rm -f "$TUI_OUT" "$DESK_OUT" 2>/dev/null || true

echo
echo "Summary: $PASS ok, $FAIL missing"
if [[ -n "$NOTE" ]]; then
  printf "Notes:%b\n" "$NOTE"
fi

if [[ $FAIL -eq 0 ]]; then
  echo
  echo "PASS: exercise ran. The next lesson is L04 — Skills and Skill Bundles."
  exit 0
else
  echo
  echo "FAIL: one or more steps missed. Fix the items above and re-run."
  exit 1
fi
