#!/usr/bin/env bash
# test.sh — L05 MCP Catalog and Integrations
#
# Greps the MDX for required terms, links, and components.
# Verifies the standalone quiz.json (existence, valid JSON, ≥1 question,
# lesson-reference). Confirms the MDX has no orphan `import Quiz` line.
# Exits non-zero on the first miss.

set -euo pipefail

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L05-mcp-catalog-and-integrations.mdx"
ART_DIR="/home/ubuntu/boxai4/site/src/lessons/hermes/L05-mcp-catalog-and-integrations"
QUIZ="$ART_DIR/quiz.json"

pass=0
fail=0

check() {
    local desc="$1"
    local pattern="$2"
    local file="${3:-$LESSON}"
    if grep -qE -- "$pattern" "$file"; then
        printf '  \033[1;32mok\033[0m  %s\n' "$desc"
        pass=$((pass+1))
    else
        printf '  \033[1;31mMISS\033[0m  %s  (pattern: %s)\n' "$desc" "$pattern" >&2
        fail=$((fail+1))
    fi
}

check_not() {
    local desc="$1"
    local pattern="$2"
    local file="${3:-$LESSON}"
    if ! grep -qE -- "$pattern" "$file"; then
        printf '  \033[1;32mok\033[0m  %s\n' "$desc"
        pass=$((pass+1))
    else
        printf '  \033[1;31mMISS\033[0m  %s  (forbidden pattern: %s)\n' "$desc" "$pattern" >&2
        fail=$((fail+1))
    fi
}

echo "Lesson body checks ($LESSON):"
check "mentions 'hermes mcp' command"           'hermes mcp'
check "mentions 'hermes update' command"        'hermes update'
check "mentions 'hermes mcp install' command"   'hermes mcp install'
check "mentions 'hermes mcp configure' command" 'hermes mcp configure'
check "expands OAuth on first use"              'OAuth.{0,4}\(Open Authorization'
check "expands API on first use"                'API.*Application Programming Interface'
check "expands MCP on first use"                'Model Context Protocol'
check "mentions OAuth"                          '\bOAuth\b'
check "mentions ~/.hermes/mcp-tokens path"      '~/\.hermes/mcp-tokens'
check "mentions ~/.hermes/.env path"            '~/\.hermes/\.env'
check "mentions 'catalog' term"                 '\bcatalog\b'
check "mentions 'custom' term"                  '\bcustom\b'
check "cross-link to L06"                       'l06-performance-model-routing-cost'
check "cross-link to L07"                       'l07-security-essentials'
check "cross-link to L08"                       'l08-automation-cron-kanban-sub-agents'
check "cross-link to L01"                       'l01-what-is-hermes-agent'
check "cross-link to L02"                       'l02-install-and-first-run'
check "freshness date June 2026"                'June 2026'
check "body points to standalone quiz.json"     'quiz\.json'

echo
echo "MDX must NOT have orphan 'import Quiz' line:"
check_not "no 'import Quiz' line in MDX"        'import\s+Quiz\s+from'

echo
echo "Standalone quiz.json checks ($QUIZ):"
check "quiz.json exists"                        '\['  "$QUIZ"

if QUIZ_PATH="$QUIZ" python3 -c 'import json,os; json.load(open(os.environ["QUIZ_PATH"]))' 2>/dev/null; then
    printf '  \033[1;32mok\033[0m  %s\n' "quiz.json is valid JSON"
    pass=$((pass+1))
else
    printf '  \033[1;31mMISS\033[0m  %s\n' "quiz.json is not valid JSON" >&2
    fail=$((fail+1))
fi

QCOUNT="$(QUIZ_PATH="$QUIZ" python3 -c 'import json,os; d=json.load(open(os.environ["QUIZ_PATH"])); q=d["questions"] if isinstance(d, dict) and "questions" in d else d; print(len(q) if hasattr(q,"__len__") else 0)' 2>/dev/null || echo 0)"
if [[ "$QCOUNT" -ge 1 ]]; then
    printf '  \033[1;32mok\033[0m  quiz.json has %s question(s) (≥1)\n' "$QCOUNT"
    pass=$((pass+1))
else
    printf '  \033[1;31mMISS\033[0m  quiz.json has 0 questions (need ≥1)\n' >&2
    fail=$((fail+1))
fi

if grep -qE 'l05-mcp-catalog-and-integrations|mcp.catalog|MCP' "$QUIZ"; then
    printf '  \033[1;32mok\033[0m  quiz.json references the lesson (l05 or MCP/catalog)\n'
    pass=$((pass+1))
else
    printf '  \033[1;31mMISS\033[0m  quiz.json does not reference the lesson\n' >&2
    fail=$((fail+1))
fi

echo
echo "Artifact checks ($ART_DIR):"
check "example.sh exists"      'bash'            "$ART_DIR/example.sh"
check "test.sh exists"         'check\(\)'       "$ART_DIR/test.sh"

echo
if [[ $fail -eq 0 ]]; then
    printf '\033[1;32mALL %d CHECKS PASSED\033[0m\n' "$pass"
    exit 0
else
    printf '\033[1;31m%d MISSES (out of %d checks)\033[0m\n' "$fail" "$((pass+fail))" >&2
    exit 1
fi
