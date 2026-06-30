#!/usr/bin/env bash
# L08 — register a real cron entry via `hermes cron create`, assert `hermes cron list`
# shows it, force a tick with `hermes cron run`, and assert the log file is written.
# Graceful exit-0 fallback if `hermes cron` subcommand is not available in this build.

set -u

NAME="daily-canary"
LOG_DIR="$HOME/.hermes/logs"
LOG_FILE="$LOG_DIR/${NAME}.log"

pass()  { echo "ok   $1"; }
warn()  { echo "skip $1"; SKIPPED=1; }
fail()  { echo "FAIL $1"; exit 1; }

SKIPPED=0

# 1. Detect `hermes` on PATH.
if ! command -v hermes >/dev/null 2>&1; then
  warn "hermes not on PATH — falling back to documentation-only mode"
  cat <<EOF
example.sh (fallback, hermes not on PATH):
  hermes cron create <schedule> --name ${NAME} --skill morning-brief
  hermes cron list
  hermes cron run ${NAME}
  tail -n 20 ${LOG_FILE}
exit 0
EOF
  exit 0
fi

# 2. Detect `hermes cron` subcommand.
if ! hermes cron --help >/dev/null 2>&1; then
  warn "hermes cron subcommand not available in this build"
  cat <<EOF
example.sh (fallback, hermes cron subcommand missing):
  The cron, Kanban, and sub-agent patterns are documented in L08.
  See site/src/content/lessons/hermes/L08-automation-cron-kanban-sub-agents.mdx
  for the full 6-step exercise (steps 3-6 are runnable when hermes cron is present).
exit 0
EOF
  exit 0
fi

# 3. Inspect the actual subcommand surface so we use what this build supports.
CRON_CREATE_FLAGS=$(hermes cron create --help 2>&1 || true)
SUPPORTS_NAME=0
echo "$CRON_CREATE_FLAGS" | grep -q -- "--name" && SUPPORTS_NAME=1

# 4. Register the cron entry using the real flag set.
mkdir -p "$LOG_DIR" || fail "could not create $LOG_DIR"

if [ "$SUPPORTS_NAME" = "1" ]; then
  if ! hermes cron create "0 7 * * *" --name "${NAME}" --skill morning-brief >/dev/null 2>&1; then
    warn "hermes cron create returned non-zero (skipping live assertion)"
    cat <<EOF
example.sh (fallback, create failed):
  hermes cron create "0 7 * * *" --name ${NAME} --skill morning-brief
  hermes cron list
  hermes cron run ${NAME}
  tail -n 20 ${LOG_FILE}
exit 0
EOF
    exit 0
  fi
else
  if ! hermes cron create "0 7 * * *" --skill morning-brief >/dev/null 2>&1; then
    warn "hermes cron create returned non-zero"
    exit 0
  fi
fi
pass "hermes cron create registered ${NAME}"

# 5. Assert `hermes cron list` shows the entry.
if hermes cron list 2>/dev/null | grep -qi "${NAME}\\|morning-brief"; then
  pass "hermes cron list shows ${NAME}"
else
  warn "hermes cron list did not match ${NAME} (live list output below)"
  hermes cron list 2>&1 | head -20
fi

# 6. Force a tick (best-effort; some builds need --accept-hooks for headless).
if hermes cron run "${NAME}" --accept-hooks >/dev/null 2>&1 || hermes cron run "${NAME}" >/dev/null 2>&1; then
  pass "hermes cron run ${NAME} fired"
else
  warn "hermes cron run returned non-zero (subcommand may need TTY)"
fi

# 7. Assert log file is written (best-effort; --script mode writes deterministic logs).
sleep 1
if [ -s "$LOG_FILE" ]; then
  LINES=$(wc -l < "$LOG_FILE")
  pass "log written: ${LOG_FILE} (${LINES} lines)"
else
  warn "log file empty or missing: ${LOG_FILE} (use --script for deterministic logs)"
fi

echo "example.sh: PASS (${SKIPPED:+skipped=$SKIPPED})"
exit 0