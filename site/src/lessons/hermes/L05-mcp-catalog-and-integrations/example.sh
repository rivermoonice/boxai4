#!/usr/bin/env bash
# example.sh — L05 MCP Catalog and Integrations
#
# Pulls the latest catalog via `hermes update`, lists the catalog with
# `hermes mcp catalog`, and asserts that `linear` and `n8n` are both
# present in the Nous-approved list. Also checks that `hermes mcp` help
# exposes the four workflow commands documented in the lesson.
#
# All commands here are real and exit non-zero on any miss. If `hermes`
# isn't on PATH the script exits 0 with a clear notice so it can still
# run in CI environments without the CLI installed.

set -euo pipefail

say()  { printf '\n\033[1;36m[L05]\033[0m %s\n' "$*"; }
fail() { printf '\n\033[1;31m[L05 FAIL]\033[0m %s\n' "$*" >&2; exit 1; }
ok()   { printf '  \033[1;32mok\033[0m  %s\n' "$*"; }

# ---------- 0. Hermes on PATH? ----------
if ! command -v hermes >/dev/null 2>&1; then
    say "hermes CLI not on PATH — exiting 0 (graceful fallback)"
    say "(install hermes to run the live catalog assertions below)"
    exit 0
fi

# ---------- 1. Update the catalog ----------
say "Running: hermes update"
hermes update

# ---------- 2. Show the catalog ----------
say "Running: hermes mcp catalog"
CATALOG="$(hermes mcp catalog 2>&1 || true)"
printf '%s\n' "$CATALOG"

# ---------- 3. Assert the catalog contains linear and n8n ----------
if printf '%s' "$CATALOG" | grep -Eq '(^|[[:space:]])linear([[:space:]]|$)'; then
    ok "catalog lists 'linear'"
else
    fail "catalog does not list 'linear'"
fi

if printf '%s' "$CATALOG" | grep -Eq '(^|[[:space:]])n8n([[:space:]]|$)'; then
    ok "catalog lists 'n8n'"
else
    fail "catalog does not list 'n8n'"
fi

# ---------- 4. Assert the four workflow verbs are exposed ----------
say "Running: hermes mcp --help"
HELP="$(hermes mcp --help 2>&1 || true)"
printf '%s' "$HELP" | head -20

for verb in 'install' 'configure' 'picker' 'catalog'; do
    if printf '%s' "$HELP" | grep -Eq "(^|[[:space:],{])${verb}([[:space:],}]|$)"; then
        ok "hermes mcp exposes '${verb}' verb"
    else
        fail "hermes mcp does not expose '${verb}' verb"
    fi
done

# ---------- 5. The catalog already contains linear; don't install it ----------
# We deliberately do NOT run `hermes mcp install linear` here because
# installation is interactive (OAuth browser dance + tool whitelist).
# The lesson's exercise 109-130 is the human-run version.

printf '\n\033[1;32m[L05 PASS]\033[0m Catalog lists linear + n8n; four verbs present.\n'