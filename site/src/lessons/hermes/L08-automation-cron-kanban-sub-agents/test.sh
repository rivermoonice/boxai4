#!/usr/bin/env bash
# L08 test.sh — grep the lesson MDX for required terms, exit non-zero on miss.

set -u

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L08-automation-cron-kanban-sub-agents.mdx"
EXAMPLE="/home/ubuntu/boxai4/site/src/lessons/hermes/L08-automation-cron-kanban-sub-agents/example.sh"
QUIZ="/home/ubuntu/boxai4/site/src/lessons/hermes/L08-automation-cron-kanban-sub-agents/quiz.json"

PASS=0
FAIL=0
TOTAL=0

check() {
  local label="$1"
  local pattern="$2"
  local file="$3"
  TOTAL=$((TOTAL + 1))
  if grep -Eq "$pattern" "$file"; then
    echo "ok   $label"
    PASS=$((PASS + 1))
  else
    echo "FAIL $label (pattern: $pattern)"
    FAIL=$((FAIL + 1))
  fi
}

# --- core commands and syntax ---
check "hermes cron mentioned"               "hermes cron"            "$LESSON"
check "cron syntax 0 7 \\* \\* \\*"          "0 7 \* \* \*"           "$LESSON"

# --- three pattern names ---
check "pattern: cron"                        "Cron jobs"              "$LESSON"
check "pattern: Kanban"                      "Kanban boards"          "$LESSON"
check "pattern: sub-agent"                   "Sub-agents"             "$LESSON"

# --- three gotcha headers ---
check "gotcha: Cron's three silent killers"  "Cron's three silent killers" "$LESSON"
check "gotcha: kanban gotcha"                "kanban gotcha"          "$LESSON"
check "gotcha: sub-agent gotcha"             "sub-agent gotcha"       "$LESSON"

# --- cross-links ---
check "cross-link L04"                       "/lessons/hermes/l04-skills-and-skill-bundles/" "$LESSON"
check "cross-link L05"                       "/lessons/hermes/l05-mcp-catalog-and-integrations/" "$LESSON"
check "cross-link L07"                       "/lessons/hermes/l07-security-essentials/" "$LESSON"
check "cross-link L09"                       "/lessons/hermes/l09-hermes-vs-alternatives/" "$LESSON"

# --- freshness and interactivity ---
check "freshness June 2026"                  "June 2026"              "$LESSON"
check "body points to standalone quiz.json"  "/lessons/hermes/l08-automation-cron-kanban-sub-agents/quiz.json" "$LESSON"

# --- MDX must NOT have orphan 'import Quiz' line ---
TOTAL=$((TOTAL + 1))
if grep -Eq "import Quiz from '" "$LESSON"; then
  echo "FAIL orphan 'import Quiz' line in MDX (should be removed since quiz is standalone)"
  FAIL=$((FAIL + 1))
else
  echo "ok   no orphan 'import Quiz' line in MDX"
  PASS=$((PASS + 1))
fi

# --- MDX must NOT have inlined <Quiz> JSX block ---
TOTAL=$((TOTAL + 1))
if grep -Eq "<Quiz" "$LESSON"; then
  echo "FAIL inlined <Quiz> JSX block in MDX (should be standalone quiz.json)"
  FAIL=$((FAIL + 1))
else
  echo "ok   no inlined <Quiz> JSX block in MDX"
  PASS=$((PASS + 1))
fi

# --- MCP expansion on first use ---
check "MCP expanded (Model Context Protocol)" "Model Context Protocol" "$LESSON"

# --- debug-flag command ---
check "debug flag concrete command"          "hermes cron run --debug" "$LESSON"

# --- artifacts present ---
TOTAL=$((TOTAL + 1))
if [ -f "$EXAMPLE" ]; then
  echo "ok   example.sh exists"
  PASS=$((PASS + 1))
else
  echo "FAIL example.sh missing"
  FAIL=$((FAIL + 1))
fi

TOTAL=$((TOTAL + 1))
if [ -f "$QUIZ" ]; then
  echo "ok   quiz.json exists"
  PASS=$((PASS + 1))
else
  echo "FAIL quiz.json missing"
  FAIL=$((FAIL + 1))
fi

# --- standalone quiz.json checks ---
TOTAL=$((TOTAL + 1))
if python3 -c "import json, sys; json.load(open('$QUIZ'))" 2>/dev/null; then
  echo "ok   quiz.json valid JSON"
  PASS=$((PASS + 1))
else
  echo "FAIL quiz.json not valid JSON"
  FAIL=$((FAIL + 1))
fi

TOTAL=$((TOTAL + 1))
TOTAL_QS=$(python3 -c "import json, sys; d=json.load(open('$QUIZ')); print(len(d.get('questions', d) if isinstance(d, dict) else d))" 2>/dev/null || echo 0)
if [ "$TOTAL_QS" -ge 1 ]; then
  echo "ok   quiz.json has $TOTAL_QS question(s) (>=1)"
  PASS=$((PASS + 1))
else
  echo "FAIL quiz.json has $TOTAL_QS questions (need >=1)"
  FAIL=$((FAIL + 1))
fi

TOTAL=$((TOTAL + 1))
HAS_CRON=$(grep -c -E "Cron|cron" "$QUIZ" || echo 0)
HAS_KANBAN=$(grep -c -E "Kanban|kanban" "$QUIZ" || echo 0)
HAS_SUB=$(grep -c -E "sub-agent" "$QUIZ" || echo 0)
if [ "$HAS_CRON" -ge 1 ] && [ "$HAS_KANBAN" -ge 1 ] && [ "$HAS_SUB" -ge 1 ]; then
  echo "ok   quiz.json references all three pattern names (cron, Kanban, sub-agent)"
  PASS=$((PASS + 1))
else
  echo "FAIL quiz.json missing pattern-name references (cron=$HAS_CRON, Kanban=$HAS_KANBAN, sub-agent=$HAS_SUB)"
  FAIL=$((FAIL + 1))
fi

# --- example.sh has the three required verbs ---
check "example.sh: cron create"              "hermes cron create"     "$EXAMPLE"
check "example.sh: cron list"                "hermes cron list"       "$EXAMPLE"
check "example.sh: cron run"                 "hermes cron run"        "$EXAMPLE"
check "example.sh: log file"                  "morning-brief"          "$EXAMPLE"

echo ""
echo "test.sh: $PASS/$TOTAL passed, $FAIL failed"
exit "$FAIL"