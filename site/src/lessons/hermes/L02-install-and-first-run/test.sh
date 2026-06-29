#!/usr/bin/env bash
# test.sh — grep the L02 lesson for required terms and exit non-zero on miss.
#
# Run from repo root:
#   bash site/src/lessons/hermes/L02-install-and-first-run/test.sh
#
# Exit codes:
#   0 = all required terms present
#   1 = one or more required terms missing

set -u

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L02-install-and-first-run.mdx"

if [[ ! -f "$LESSON" ]]; then
  echo "FAIL: lesson not found at $LESSON"
  exit 1
fi

fail=0

check() {
  local term="$1"
  if grep -F -q -- "$term" "$LESSON"; then
    echo "  ok    : '$term'"
  else
    echo "  MISS  : '$term'"
    fail=1
  fi
}

echo "Checking L02-install-and-first-run.mdx for required terms..."

# Required commands / terms (per task spec)
check "xcode-select --install"
check "hermes doctor"
check "hermes status"
check "BYOK"
check "SSH"

# Internal cross-links (writer checklist: >=1)
check "/lessons/hermes/l03-daily-driver-tui-vs-desktop/"
check "/lessons/hermes/l07-security-essentials/"
check "/lessons/hermes/l08-automation-cron-kanban-sub-agents/"

# Structural elements (sections must exist)
check "## Before you install"
check "## Two paths: Mac vs VPS"
check "## Pick your model"
check "## Verify it works"

# AI-slop guard: freshness line must include month + year
if grep -Eq "Last tested and updated.*June 2026" "$LESSON"; then
  echo "  ok    : freshness line (June 2026)"
else
  echo "  MISS  : freshness line 'Last tested and updated: June 2026'"
  fail=1
fi

# Quiz component present
if grep -Eq "<Quiz[[:space:]/>]" "$LESSON"; then
  echo "  ok    : <Quiz> component"
else
  echo "  MISS  : <Quiz> component"
  fail=1
fi

# Artifacts present
ART_DIR="/home/ubuntu/boxai4/site/src/lessons/hermes/L02-install-and-first-run"
for f in example.sh quiz.json test.sh; do
  if [[ -f "$ART_DIR/$f" ]]; then
    echo "  ok    : artifact '$f'"
  else
    echo "  MISS  : artifact '$f'"
    fail=1
  fi
done

if [[ $fail -eq 0 ]]; then
  echo
  echo "PASS: all required terms present"
  exit 0
else
  echo
  echo "FAIL: one or more required terms missing"
  exit 1
fi
