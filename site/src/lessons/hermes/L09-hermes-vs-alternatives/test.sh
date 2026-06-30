#!/usr/bin/env bash
# L09 test.sh — grep the lesson MDX for required terms, exit non-zero on miss.

set -u

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L09-hermes-vs-alternatives.mdx"
EXAMPLE="/home/ubuntu/boxai4/site/src/lessons/hermes/L09-hermes-vs-alternatives/example.sh"
QUIZ="/home/ubuntu/boxai4/site/src/lessons/hermes/L09-hermes-vs-alternatives/quiz.json"

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

# --- four harness names ---
check "harness: Hermes"                      "Hermes"                 "$LESSON"
check "harness: Claude Code"                 "Claude Code"            "$LESSON"
check "harness: Mavis"                       "Mavis"                  "$LESSON"
check "harness: Google Gemini"               "Google Gemini"          "$LESSON"

# --- BYOK vs subscription split ---
check "pricing: BYOK"                        "BYOK"                   "$LESSON"
check "pricing: subscription"                "Subscription"           "$LESSON"
check "pricing: BYOK expanded"               "Bring Your Own Key"     "$LESSON"
check "pricing: per-token explained"         "per token"              "$LESSON"

# --- open-source vs managed split ---
check "split: open-source"                   "open-source"            "$LESSON"
check "split: managed products"              "managed products"       "$LESSON"

# --- comparison table headers ---
check "table: Pricing model"                 "Pricing model"          "$LESSON"
check "table: Beginner setup"                "Beginner setup"         "$LESSON"
check "table: Coding workload"               "Coding workload"        "$LESSON"
check "table: Long-running automation"       "Long-running automation" "$LESSON"
check "table: Multi-channel ops"             "Multi-channel ops"      "$LESSON"

# --- cross-links ---
check "cross-link L01"                       "/lessons/hermes/l01-what-is-hermes-agent/" "$LESSON"
check "cross-link L02"                       "/lessons/hermes/l02-install-and-first-run/" "$LESSON"
check "cross-link L06"                       "/lessons/hermes/l06-performance-model-routing-cost/" "$LESSON"
check "cross-link L08"                       "/lessons/hermes/l08-automation-cron-kanban-sub-agents/" "$LESSON"

# --- freshness and interactivity ---
check "freshness June 2026"                  "June 2026"              "$LESSON"
check "quiz.json pointer in body"            "quiz.json"              "$LESSON"

# --- MDX must NOT have orphan 'import Quiz' line or inlined <Quiz> JSX block ---
TOTAL=$((TOTAL + 1))
if ! grep -Eq "^\s*import\s+Quiz\b" "$LESSON"; then
  echo "ok   no orphan 'import Quiz' line"
  PASS=$((PASS + 1))
else
  echo "FAIL MDX still has orphan 'import Quiz' line"
  FAIL=$((FAIL + 1))
fi

TOTAL=$((TOTAL + 1))
if ! grep -Eq "<Quiz" "$LESSON"; then
  echo "ok   no inlined <Quiz> JSX block"
  PASS=$((PASS + 1))
else
  echo "FAIL MDX still has inlined <Quiz> JSX block"
  FAIL=$((FAIL + 1))
fi

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

# --- Standalone quiz.json checks ---
TOTAL=$((TOTAL + 1))
if python3 -c "import json,sys; json.load(open('$QUIZ'))" 2>/dev/null; then
  echo "ok   quiz.json is valid JSON"
  PASS=$((PASS + 1))
else
  echo "FAIL quiz.json is NOT valid JSON"
  FAIL=$((FAIL + 1))
fi

TOTAL_QS=$(python3 -c "import json,sys; d=json.load(open('$QUIZ')); print(len(d.get('questions', d) if isinstance(d, dict) else d))" 2>/dev/null || echo 0)
TOTAL=$((TOTAL + 1))
if [ "$TOTAL_QS" -ge 1 ]; then
  echo "ok   quiz.json has $TOTAL_QS questions"
  PASS=$((PASS + 1))
else
  echo "FAIL quiz.json has $TOTAL_QS questions (need >=1)"
  FAIL=$((FAIL + 1))
fi

# --- quiz.json references the lesson (content-based: must mention a harness) ---
HAS_HERMES=$(grep -c "Hermes" "$QUIZ" 2>/dev/null || echo 0)
HAS_CLAUDE=$(grep -c "Claude Code" "$QUIZ" 2>/dev/null || echo 0)
HAS_MAVIS=$(grep -c "Mavis" "$QUIZ" 2>/dev/null || echo 0)
HAS_GEMINI=$(grep -c "Gemini" "$QUIZ" 2>/dev/null || echo 0)
TOTAL=$((TOTAL + 1))
if [ "$HAS_HERMES" -ge 1 ] && [ "$HAS_CLAUDE" -ge 1 ] && [ "$HAS_MAVIS" -ge 1 ] && [ "$HAS_GEMINI" -ge 1 ]; then
  echo "ok   quiz.json references all 4 harnesses (Hermes/Claude Code/Mavis/Gemini)"
  PASS=$((PASS + 1))
else
  echo "FAIL quiz.json missing harness references (Hermes=$HAS_HERMES, Claude Code=$HAS_CLAUDE, Mavis=$HAS_MAVIS, Gemini=$HAS_GEMINI)"
  FAIL=$((FAIL + 1))
fi

# --- example.sh content ---
check "example.sh: workload prompt"          "Workload"               "$EXAMPLE"
check "example.sh: volume prompt"            "Volume"                 "$EXAMPLE"
check "example.sh: open-source prompt"       "Open-source"            "$EXAMPLE"
check "example.sh: default Hermes fallback"  "Hermes is the safe beginner choice" "$EXAMPLE"
check "example.sh: non-interactive fallback"  "no interactive input"   "$EXAMPLE"
check "example.sh: decision matrix"          "decision matrix"        "$EXAMPLE"
check "example.sh: prints decision"          "Picked:"                "$EXAMPLE"

echo ""
echo "test.sh: $PASS/$TOTAL passed, $FAIL failed"
exit "$FAIL"