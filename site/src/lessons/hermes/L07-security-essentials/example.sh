#!/usr/bin/env bash
# example.sh — L07 Security Essentials
#
# Four live security checks for a Hermes install:
#   (a) tailscale status is non-error (graceful exit-0 if not installed)
#   (b) running `hermes dashboard` is NOT bound to 0.0.0.0
#   (c) ~/.hermes/.env exists and is chmod 600 or stricter
#   (d) public-IP:919 returns connection refused
#
# Real commands, real exit codes, graceful fallbacks so this still runs in CI
# without Tailscale, without hermes running, and without a real VPS.

set -uo pipefail

say()  { printf '\n\033[1;36m[L07]\033[0m %s\n' "$*"; }
ok()   { printf '  \033[1;32mok\033[0m  %s\n' "$*"; }
warn() { printf '  \033[1;33mwarn\033[0m %s\n' "$*"; }
fail() { printf '\n\033[1;31m[L07 FAIL]\033[0m %s\n' "$*" >&2; exit 1; }

HERMES_ENV="${HOME}/.hermes/.env"
PUBLIC_IP="${HERMES_PUBLIC_IP:-}"
DASHBOARD_PORT=919

# ---------- (a) tailscale status ----------
say "(a) tailscale status"
if ! command -v tailscale >/dev/null 2>&1; then
    warn "Tailscale not installed — skipping (install via tailscale.com/download)"
    TAILSCALE_OK=0
else
    TS_OUT="$(tailscale status 2>&1 || true)"
    printf '%s\n' "$TS_OUT" | head -5
    if printf '%s' "$TS_OUT" | grep -Eqi 'error|not logged in|Logged out'; then
        warn "tailscale status reports an error — re-auth with: tailscale up"
        TAILSCALE_OK=0
    else
        ok "tailscale status returned cleanly"
        TAILSCALE_OK=1
    fi
fi

# ---------- (b) hermes dashboard bind address ----------
say "(b) checking that the running hermes dashboard is NOT bound to 0.0.0.0"
if ! command -v hermes >/dev/null 2>&1; then
    warn "hermes CLI not on PATH — skipping bind check"
    BIND_OK=0
else
    DASH_OUT="$(hermes dashboard --help 2>&1 || true)"
    # We can't reliably query a running dashboard from the CLI; instead, grep
    # the live ps tree for an active `hermes dashboard` invocation and inspect
    # its --bind flag value.
    PS_BIND="$(ps -eo args= 2>/dev/null | grep -E '[h]ermes[[:space:]]+dashboard' | grep -oE -- '--bind[[:space:]]+[^[:space:]]+' | head -1 | awk '{print $2}' || true)"
    if [[ -z "$PS_BIND" ]]; then
        warn "no running 'hermes dashboard' process found — start it under tmux before re-running this check"
        BIND_OK=0
    elif [[ "$PS_BIND" == "0.0.0.0" ]]; then
        fail "hermes dashboard is bound to 0.0.0.0 — switch to the Tailscale 100.x IP"
    else
        ok "hermes dashboard bound to ${PS_BIND} (not 0.0.0.0)"
        BIND_OK=1
    fi
fi

# ---------- (c) ~/.hermes/.env permissions ----------
say "(c) ~/.hermes/.env permissions"
if [[ ! -e "$HERMES_ENV" ]]; then
    warn "${HERMES_ENV} does not exist — create it before first use"
    PERM_OK=0
else
    PERMS="$(stat -c '%a' "$HERMES_ENV" 2>/dev/null || stat -f '%Lp' "$HERMES_ENV" 2>/dev/null || echo unknown)"
    printf '  %s permissions: %s\n' "$HERMES_ENV" "$PERMS"
    if [[ "$PERMS" == "600" || "$PERMS" == "400" ]]; then
        ok "${HERMES_ENV} is chmod 600 or stricter"
        PERM_OK=1
    else
        fail "${HERMES_ENV} is ${PERMS} — tighten with: chmod 600 ${HERMES_ENV}"
    fi
fi

# ---------- (d) public-IP:919 connection refused ----------
say "(d) curling http://${PUBLIC_IP:-<unset>}:${DASHBOARD_PORT}"
if [[ -z "$PUBLIC_IP" ]]; then
    warn "HERMES_PUBLIC_IP env var is unset — skipping live curl check"
    warn "set HERMES_PUBLIC_IP=<your-vps-public-ip> and re-run for an end-to-end test"
    CURL_OK=0
else
    HTTP_CODE="$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 "http://${PUBLIC_IP}:${DASHBOARD_PORT}" 2>/dev/null || echo '000')"
    CURL_EXIT=$?
    printf '  curl exit=%s http_code=%s\n' "$CURL_EXIT" "$HTTP_CODE"
    if [[ "$CURL_EXIT" -eq 7 ]]; then
        ok "connection refused — port 919 is closed publicly"
        CURL_OK=1
    elif [[ "$HTTP_CODE" == "000" ]]; then
        ok "no HTTP response — port 919 is not reachable from the public internet"
        CURL_OK=1
    else
        fail "got HTTP ${HTTP_CODE} from ${PUBLIC_IP}:${DASHBOARD_PORT} — port is OPEN; close it now"
    fi
fi

# ---------- Summary ----------
printf '\n'
if [[ $TAILSCALE_OK -eq 1 && $BIND_OK -eq 1 && $PERM_OK -eq 1 && $CURL_OK -eq 1 ]]; then
    printf '\033[1;32m[L07 PASS]\033[0m all four live checks green.\n'
else
    printf '\033[1;33m[L07 OK]\033[0m some checks were skipped (graceful fallback). Re-run after install.\n'
fi