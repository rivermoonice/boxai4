#!/usr/bin/env bash
# test.sh — grep the L04 lesson for required terms and exit non-zero on miss.
#
# Run from repo root:
#   bash site/src/lessons/ai-models/L04-cost-efficient-tier/test.sh
#
# Exit codes:
#   0 = all required terms present
#   1 = one or more required terms missing

set -u

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/ai-models/L04-cost-efficient-tier.mdx"

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

echo "Checking L04-cost-efficient-tier.mdx for required terms..."

# Core lesson identity
check "Qwen"
check "MiniMax"
check "GLM"
check "Opus"

# Pricing numbers (the only honest cost unit per the lesson)
check "Qwen Plus"
check "GLM 5.2"

# Workload hooks
check "long-horizon"
check "multimodal"
check "front-end"

# Cross-link to sibling lessons (writer checklist: >=1 internal link)
check "/lessons/ai-models/l03-chinese-open-weight/"
check "/lessons/ai-models/l05-frontier-vs-open-weight-decisions/"

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
