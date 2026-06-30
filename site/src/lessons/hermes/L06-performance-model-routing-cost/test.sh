#!/usr/bin/env bash
# test.sh — L06 Performance, Model Routing, Cost
#
# Greps the MDX for required terms, links, and components.
# Exits non-zero on the first miss.

set -euo pipefail

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L06-performance-model-routing-cost.mdx"
ART_DIR="/home/ubuntu/boxai4/site/src/lessons/hermes/L06-performance-model-routing-cost"

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

# 6 named models
check "mentions 'DeepSeek V4 Flash'"                'DeepSeek V4 Flash'
check "mentions 'Kimi K2.6'"                        'Kimi K2\.6'
check "mentions 'MiniMax M3'"                       'MiniMax M3'
check "mentions 'Sonnet 4.5'"                       'Sonnet 4\.5'
check "mentions 'Opus 4.8'"                         'Opus 4\.8'
check "mentions 'Fable 5'"                          'Fable 5'

# 4 tier names
check "mentions 'Orchestrator' tier"                '\bOrchestrator\b'
check "mentions 'Reviewer' tier"                    '\bReviewer\b'
check "mentions 'Executor' tier"                    '\bExecutor\b'
check "mentions 'Routed outputs' tier"              'Routed outputs'

# Budget cap and alerts
check "mentions '\$20' cap"                         '\$20'
check "mentions 50% alert"                          '50%'
check "mentions 80% alert"                          '80%'
check "mentions 100% alert"                         '100%'

# 4 pricing-table column names
check "mentions 'Input \$/1M' column"               'Input \$/1M'
check "mentions 'Output \$/1M' column"              'Output \$/1M'
check "mentions 'Cached input \$/1M' column"        'Cached input \$/1M'
check "mentions 'Tier' column"                      '\bTier\b'

# Cross-links to L01/L04/L07/L09
check "cross-link to L01"                           'l01-what-is-hermes-agent'
check "cross-link to L04"                           'l04-skills-and-skill-bundles'
check "cross-link to L07"                           'l07-security-essentials'
check "cross-link to L09"                           'l09-hermes-vs-alternatives'

# Freshness + quiz pointer (de-inlined from MDX into standalone quiz.json)
check "freshness date June 2026"                    'June 2026'
check "quiz.json pointer in body"                   'quiz\.json'

# Routing concepts
check "mentions 'tiered routing'"                   'tiered routing'
check "mentions 'hermes model' command"             'hermes model'
check "mentions 'Billing' dashboard section"        'Billing'

echo
echo "Artifact checks ($ART_DIR):"
check "example.sh exists"      'bash'            "$ART_DIR/example.sh"
check "test.sh exists"         'check\(\)'       "$ART_DIR/test.sh"

echo
echo "Standalone quiz.json checks ($ART_DIR/quiz.json):"
check "quiz.json exists"                       '.'                  "$ART_DIR/quiz.json"

# Valid JSON + at least one question
if python3 -c "import json,sys; d=json.load(open('$ART_DIR/quiz.json')); n=len(d.get('questions', d)) if isinstance(d, dict) else len(d); assert n>=1, 'no questions'; print('quiz.json valid JSON, %d question(s)' % n)" >/dev/null 2>&1; then
    printf '  \033[1;32mok\033[0m  quiz.json valid JSON with >=1 question\n'
    pass=$((pass+1))
else
    printf '  \033[1;31mMISS\033[0m  quiz.json valid JSON with >=1 question\n' >&2
    fail=$((fail+1))
fi

# Lesson-reference inside quiz.json (slug or topic)
check "quiz.json references the lesson"           'l06-performance-model-routing-cost|tiered routing|Tiered routing|model routing|Model routing'  "$ART_DIR/quiz.json"

echo
echo "MDX must NOT have orphan 'import Quiz' line:"
if grep -qE '^import Quiz from ' "$LESSON"; then
    printf '  \033[1;31mMISS\033[0m  no orphan import Quiz line (got one)\n' >&2
    fail=$((fail+1))
else
    printf '  \033[1;32mok\033[0m  no orphan import Quiz line\n'
    pass=$((pass+1))
fi

# Body should NOT contain an inlined <Quiz> JSX block anymore
if grep -qE '<Quiz' "$LESSON"; then
    printf '  \033[1;31mMISS\033[0m  no inlined <Quiz> JSX block (got one)\n' >&2
    fail=$((fail+1))
else
    printf '  \033[1;32mok\033[0m  no inlined <Quiz> JSX block\n'
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
