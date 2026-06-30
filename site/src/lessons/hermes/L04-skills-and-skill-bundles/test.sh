#!/usr/bin/env bash
# test.sh — L04 Skills and Skill Bundles
#
# Greps the MDX for required terms, links, and components.
# Exits non-zero on the first miss.

set -euo pipefail

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L04-skills-and-skill-bundles.mdx"
ART_DIR="/home/ubuntu/boxai4/site/src/lessons/hermes/L04-skills-and-skill-bundles"

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

echo "Lesson body checks ($LESSON):"
check "mentions ~/.hermes/skills path"        '~/\.hermes/skills'
check "mentions ~/.hermes/skill-bundles path" '~/\.hermes/skill-bundles'
check "uses 'instruction' YAML field"         '\binstruction\b'
check "documents /standup slash command"       '/standup'
check "documents /research slash command"     '/research'
check "documents /pr-review slash command"    '/pr-review'
check "documents /wrap-up slash command"      '/wrap-up'
check "cross-link to L05"                     'l05-mcp-catalog-and-integrations'
check "cross-link to L08"                     'l08-automation-cron-kanban-sub-agents'
check "cross-link to L01"                     'l01-what-is-hermes-agent'
check "cross-link to L02"                     'l02-install-and-first-run'
check "cross-link to L03"                     'l03-daily-driver-tui-vs-desktop'
check "freshness date June 2026"              'June 2026'
check "quiz.json pointer in body"             'quiz\.json'

echo
echo "Artifact checks ($ART_DIR):"
check "example.sh exists"      'bash'            "$ART_DIR/example.sh"
check "quiz.json valid JSON"   '^\s*\['          "$ART_DIR/quiz.json"
check "test.sh exists"         'check\(\)'       "$ART_DIR/test.sh"

echo
echo "Standalone quiz.json checks ($ART_DIR/quiz.json):"
QUIZ="$ART_DIR/quiz.json"
if [[ -f "$QUIZ" ]]; then
    QCOUNT=$(python3 -c "import json,sys; d=json.load(open(sys.argv[1])); print(len(d.get('questions', d) if isinstance(d, dict) else d))" "$QUIZ")
    if [[ "$QCOUNT" -ge 1 ]]; then
        printf '  \033[1;32mok\033[0m  quiz.json has >=1 question (%s)\n' "$QCOUNT"
        pass=$((pass+1))
    else
        printf '  \033[1;31mMISS\033[0m  quiz.json has 0 questions\n' >&2
        fail=$((fail+1))
    fi
    if grep -q 'l04-skills-and-skill-bundles' "$QUIZ" || grep -qi 'skill bundle' "$QUIZ"; then
        printf '  \033[1;32mok\033[0m  quiz.json references this lesson\n'
        pass=$((pass+1))
    else
        printf '  \033[1;31mMISS\033[0m  quiz.json missing lesson reference\n' >&2
        fail=$((fail+1))
    fi
else
    printf '  \033[1;31mMISS\033[0m  quiz.json missing\n' >&2
    fail=$((fail+1))
fi

echo
echo "MDX must NOT have orphan 'import Quiz' line:"
if grep -qE "^import Quiz from" "$LESSON"; then
    printf '  \033[1;31mMISS\033[0m  orphan "import Quiz" line still present\n' >&2
    fail=$((fail+1))
else
    printf '  \033[1;32mok\033[0m  no orphan "import Quiz" line\n'
    pass=$((pass+1))
fi

echo
if [[ $fail -eq 0 ]]; then
    printf '\033[1;32mALL %d CHECKS PASSED\033[0m\n' "$pass"
    exit 0
else
    printf '\033[1;31m%d MISSES (out of %d checks)\033[0m\n' "$fail" "$((pass+fail))" >&2
    exit 1
fi
