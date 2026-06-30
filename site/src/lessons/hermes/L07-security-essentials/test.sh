#!/usr/bin/env bash
# test.sh — L07 Security Essentials
#
# Greps the MDX for required terms, links, and components.
# Exits non-zero on the first miss.

set -uo pipefail

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L07-security-essentials.mdx"
ART_DIR="/home/ubuntu/boxai4/site/src/lessons/hermes/L07-security-essentials"

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

# Core tool / command mentions
check "mentions 'Tailscale'"                          '\bTailscale\b'
check "mentions 'tmux'"                               '\btmux\b'
check "mentions '100.x' address"                      '100\.x\.x\.x'
check "mentions 'port 919'"                           'port 919|--port 919|:919'
check "mentions 'WireGuard'"                          '\bWireGuard\b'

# Five settings headers
check "Setting 1 — Install Tailscale"                 'Setting 1 .* Install Tailscale'
check "Setting 2 — scoped API key"                    'Setting 2 .* scoped API key'
check "Setting 3 — spend cap"                         'Setting 3 .* spend cap'
check "Setting 4 — Rotate keys"                       'Setting 4 .* Rotate keys'
check "Setting 5 — Audit MCP whitelists"              'Setting 5 .* Audit.*MCP'

# Hygiene keywords
check "mentions '.gitignore'"                         '\.gitignore'
check "mentions 'scoped' key"                         '\bscoped\b'
check "mentions '~/.hermes/.env'"                     '~/\.hermes/\.env|\$HOME/\.hermes/\.env'
check "mentions '90 days'"                            '90 days'
check "mentions 'Cloudflare Tunnel'"                  '\bCloudflare Tunnel\b'

# Cross-links
check "cross-link to L02"                             'l02-install-and-first-run'
check "cross-link to L05"                             'l05-mcp-catalog-and-integrations'
check "cross-link to L06"                             'l06-performance-model-routing-cost'
check "cross-link to L08"                             'l08-automation-cron-kanban-sub-agents'

# Freshness + Quiz pointer
check "freshness line 'June 2026'"                    'June 2026'
check "body points to standalone quiz.json"           'quiz\.json'

# Acronym expansions (slop-flag check)
check "expands 'VPN'"                                 'Virtual Private Network|VPN'
check "expands 'TCP'"                                 'Transmission Control Protocol|TCP'
check "expands 'IP'"                                  'Internet Protocol address|IP . Internet Protocol'

echo
echo "Artifact checks ($ART_DIR):"
check "example.sh exists"         'tailscale|hermes dashboard'  "$ART_DIR/example.sh"
check "quiz.json valid JSON"      '^\s*\['                      "$ART_DIR/quiz.json"
check "test.sh exists"            'check\(\)'                   "$ART_DIR/test.sh"

# MDX must NOT have an orphan 'import Quiz' line or inlined <Quiz> JSX block
if grep -qE '^import Quiz' "$LESSON"; then
    printf '  \033[1;31mMISS\033[0m  MDX has orphan "import Quiz" line (quiz de-inlined)\n' >&2
    fail=$((fail+1))
else
    printf '  \033[1;32mok\033[0m  no orphan "import Quiz" line in MDX\n'
    pass=$((pass+1))
fi
if grep -q '<Quiz' "$LESSON"; then
    printf '  \033[1;31mMISS\033[0m  MDX still contains inlined <Quiz> JSX block\n' >&2
    fail=$((fail+1))
else
    printf '  \033[1;32mok\033[0m  no inlined <Quiz> JSX block in MDX\n'
    pass=$((pass+1))
fi

# Standalone quiz.json checks: existence + valid JSON + ≥1 question + lesson-reference
if [[ -f "$ART_DIR/quiz.json" ]]; then
    quiz_qcount=$(python3 -c "import json,sys; d=json.load(open(sys.argv[1])); print(len(d.get('questions', d) if isinstance(d, dict) else d))" "$ART_DIR/quiz.json")
    if [[ "$quiz_qcount" -ge 1 ]]; then
        printf '  \033[1;32mok\033[0m  quiz.json has %s question(s) (≥1)\n' "$quiz_qcount"
        pass=$((pass+1))
    else
        printf '  \033[1;31mMISS\033[0m  quiz.json has 0 questions\n' >&2
        fail=$((fail+1))
    fi
    if grep -qE 'l07-security-essentials|security essentials|Tailscale' "$ART_DIR/quiz.json"; then
        printf '  \033[1;32mok\033[0m  quiz.json references the lesson\n'
        pass=$((pass+1))
    else
        printf '  \033[1;31mMISS\033[0m  quiz.json does not reference the lesson\n' >&2
        fail=$((fail+1))
    fi
else
    printf '  \033[1;31mMISS\033[0m  quiz.json missing\n' >&2
    fail=$((fail+1))
fi

echo
if [[ $fail -eq 0 ]]; then
    printf '\033[1;32mALL %d CHECKS PASSED\033[0m\n' "$pass"
    exit 0
else
    printf '\033[1;31m%d MISSES (out of %d checks)\033[0m\n' "$fail" "$((pass+fail))" >&2
    exit 1
fi