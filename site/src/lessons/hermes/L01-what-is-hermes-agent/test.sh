#!/usr/bin/env bash
# test.sh — grep the L01 lesson for required terms and exit non-zero on miss.
#
# Run from repo root:
#   bash site/src/lessons/hermes/L01-what-is-hermes-agent/test.sh
#
# Exit codes:
#   0 = all required terms present
#   1 = one or more required terms missing

set -u

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L01-what-is-hermes-agent.mdx"

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

echo "Checking L01-what-is-hermes-agent.mdx for required terms..."

# Core concept words
check "harness"
check "agent"
check "MCP"
check "BYOK"

# Expanded acronyms (writer checklist: first-use expansions)
check "Model Context Protocol"
check "Bring Your Own Key"

# Cross-link to sibling lessons (writer checklist: >=1 internal link)
check "/lessons/hermes/l02-install-and-first-run/"
check "/lessons/hermes/l09-hermes-vs-alternatives/"

# Required structural elements
check "## The hook"
check "## The mental model"
check "## Pick your tool"
check "## Try it"

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

if [[ $fail -eq 0 ]]; then
  echo
  echo "PASS: all required terms present"
  exit 0
else
  echo
  echo "FAIL: one or more required terms missing"
  exit 1
fi