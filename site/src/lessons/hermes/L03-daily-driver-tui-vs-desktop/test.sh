#!/usr/bin/env bash
# test.sh — grep the L03 lesson for required terms and exit non-zero on miss.
#
# Run from repo root:
#   bash site/src/lessons/hermes/L03-daily-driver-tui-vs-desktop/test.sh
#
# Exit codes:
#   0 = all required terms present
#   1 = one or more required terms missing

set -u

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L03-daily-driver-tui-vs-desktop.mdx"
ART_DIR="/home/ubuntu/boxai4/site/src/lessons/hermes/L03-daily-driver-tui-vs-desktop"

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

echo "Checking L03-daily-driver-tui-vs-desktop.mdx for required terms..."

# Required commands / terms (per task spec)
check "TUI"
check "Desktop App"
check "Electron"
check "BYOK"
check "v0.16"

# Internal cross-links (writer checklist: >=1)
check "/lessons/hermes/l04-skills-and-skill-bundles/"
check "/lessons/hermes/l09-hermes-vs-alternatives/"

# Structural elements (sections must exist)
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

# Quiz component: standalone quiz.json (not inlined MDX <Quiz>)
if grep -Eq "quiz\.json" "$LESSON"; then
  echo "  ok    : standalone quiz.json pointer in lesson body"
else
  echo "  MISS  : standalone quiz.json pointer in lesson body"
  fail=1
fi

if grep -Eq "import[[:space:]]+Quiz[[:space:]]+from" "$LESSON"; then
  echo "  MISS  : orphan 'import Quiz from' line still present in lesson"
  fail=1
else
  echo "  ok    : no orphan 'import Quiz from' line in lesson"
fi

if [[ ! -f "$ART_DIR/quiz.json" ]]; then
  echo "  MISS  : artifact 'quiz.json'"
  fail=1
else
  echo "  ok    : artifact 'quiz.json'"
  if python3 -c "import json,sys; d=json.load(open('$ART_DIR/quiz.json')); n=len(d.get('questions',[])); assert n>=1, 'no questions'; assert d.get('lesson','').startswith('L03-'), 'lesson reference missing'; sys.exit(0)" 2>/dev/null; then
    echo "  ok    : quiz.json valid JSON, >=1 question, references L03"
  else
    echo "  MISS  : quiz.json not valid JSON, has no questions, or missing L03 reference"
    fail=1
  fi
fi

# Artifacts present
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
