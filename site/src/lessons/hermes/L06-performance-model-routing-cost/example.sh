#!/usr/bin/env bash
# example.sh — L06 Performance, Model Routing, Cost
#
# Verifies the live Hermes CLI exposes the model-picker surface and reads
# the currently configured model from `hermes status`. Then greps the
# lesson body to assert that the six named models from the pricing table
# are actually documented (DeepSeek V4 Flash, Kimi K2.6, MiniMax M3,
# Claude Sonnet 4.5, Claude Opus 4.8, Claude Fable 5). Tries
# `hermes billing --current-month` and prints a USD figure if available;
# graceful exit-0 with "no billing hook in this build — cap set in
# dashboard manually" otherwise.
#
# All commands here are real. If hermes is not on PATH the script exits 0
# with a clear notice so it still runs in CI without the CLI.

set -euo pipefail

LESSON="/home/ubuntu/boxai4/site/src/content/lessons/hermes/L06-performance-model-routing-cost.mdx"

say()  { printf '\n\033[1;36m[L06]\033[0m %s\n' "$*"; }
fail() { printf '\n\033[1;31m[L06 FAIL]\033[0m %s\n' "$*" >&2; exit 1; }
ok()   { printf '  \033[1;32mok\033[0m  %s\n' "$*"; }

# ---------- 0. Hermes on PATH? ----------
if ! command -v hermes >/dev/null 2>&1; then
    say "hermes CLI not on PATH — exiting 0 (graceful fallback)"
    say "no billing hook in this build — cap set in dashboard manually"
    say "(install hermes to run the live model + status assertions below)"
    exit 0
fi

# ---------- 1. Confirm `hermes model` is a real subcommand ----------
say "Running: hermes --help (looking for 'model' subcommand)"
if hermes --help 2>&1 | grep -Eq '[,{[:space:]]model[,}[:space:]]'; then
    ok "'hermes model' is a recognised subcommand"
else
    fail "'hermes model' is not in hermes --help"
fi

# ---------- 2. Read the current model from `hermes status` ----------
say "Running: hermes status"
STATUS="$(hermes status 2>&1 || true)"
printf '%s\n' "$STATUS"

if printf '%s' "$STATUS" | grep -Eq '^[[:space:]]*Model:[[:space:]]+.+'; then
    ok "hermes status reports a current model"
else
    fail "hermes status does not report a Model: line"
fi

# ---------- 3. Assert the lesson documents all 6 named models ----------
say "Grepping lesson for the 6 named models from the pricing table"
for model in 'DeepSeek V4 Flash' 'Kimi K2.6' 'MiniMax M3' 'Sonnet 4.5' 'Opus 4.8' 'Fable 5'; do
    if grep -Fq -- "$model" "$LESSON"; then
        ok "lesson documents '${model}'"
    else
        fail "lesson does not document '${model}'"
    fi
done

# ---------- 4. Try the billing hook (may not exist in this build) ----------
say "Running: hermes billing --current-month (optional)"
BILL="$(hermes billing --current-month 2>&1 || true)"
printf '%s\n' "$BILL"

# Extract a USD figure if present (e.g. "$12.34" or "12.34 USD")
USD="$(printf '%s' "$BILL" | grep -Eo '\$[0-9]+(\.[0-9]{1,2})?|[0-9]+(\.[0-9]{1,2})?[[:space:]]*USD' | head -1 || true)"

if [[ -n "$USD" ]]; then
    ok "billing returned a USD figure: ${USD}"
else
    say "no billing hook in this build — cap set in dashboard manually"
fi

printf '\n\033[1;32m[L06 PASS]\033[0m model subcommand present, status reports a model, six models documented, billing handled.\n'
