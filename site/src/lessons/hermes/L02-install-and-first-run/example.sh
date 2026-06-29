#!/usr/bin/env bash
# example.sh — L02 "do it" demo: verify Hermes install PREREQUISITES only.
#
# This script does NOT install Hermes. It checks the prereqs on the current
# host so you know it is safe to run the real installer.
#
# Run from repo root:
#   bash site/src/lessons/hermes/L02-install-and-first-run/example.sh
#
# Exit codes:
#   0 = all prereqs look good on this host
#   1 = one or more prereqs missing (with a printed fix hint)

set -uo pipefail

PASS=0
FAIL=0

ok()   { echo "  ok    : $*"; PASS=$((PASS+1)); }
miss() { echo "  MISS  : $*"; FAIL=$((FAIL+1)); }

echo "Hermes install prereq check"
echo "============================"

# Detect host
HOST="$(uname -s 2>/dev/null || echo unknown)"
echo "Host: $HOST"
echo

# Common: curl and git are required on every path
echo "-- Common prereqs (Mac + VPS) --"
if command -v curl >/dev/null 2>&1; then
  ok "curl: $(command -v curl)"
else
  miss "curl not found. Install with: brew install curl  (Mac)  /  sudo apt install -y curl  (VPS)"
fi

if command -v git >/dev/null 2>&1; then
  ok "git: $(command -v git)"
else
  miss "git not found. Install with: brew install git  (Mac)  /  sudo apt install -y git  (VPS)"
fi

# Mac-only: Xcode Command Line Tools (xcode-select)
if [[ "$HOST" == "Darwin" ]]; then
  echo
  echo "-- Mac prereqs --"
  if command -v xcode-select >/dev/null 2>&1; then
    CLT_PATH="$(xcode-select -p 2>/dev/null || true)"
    if [[ -n "$CLT_PATH" && "$CLT_PATH" != *"error"* ]]; then
      ok "xcode-select reports CLT at: $CLT_PATH"
    else
      miss "xcode-select found but no CLT installed. Run: xcode-select --install"
    fi
  else
    miss "xcode-select not found. Run: xcode-select --install"
  fi

  # macOS version check (Hermes needs macOS 13+)
  MACOS_VER="$(sw_vers -productVersion 2>/dev/null || echo unknown)"
  if [[ "$MACOS_VER" == "unknown" ]]; then
    miss "could not read macOS version (sw_vers missing)"
  else
    MAJOR="$(echo "$MACOS_VER" | cut -d. -f1)"
    if [[ "$MAJOR" =~ ^[0-9]+$ ]] && [[ "$MAJOR" -ge 13 ]]; then
      ok "macOS $MACOS_VER (>= 13 required)"
    else
      miss "macOS $MACOS_VER is too old. Hermes needs macOS 13 or newer."
    fi
  fi
fi

# VPS-only: ssh client present, plus the apt/apt-get installer
if [[ "$HOST" == "Linux" ]]; then
  echo
  echo "-- VPS prereqs (this host is Linux) --"
  if command -v ssh >/dev/null 2>&1; then
    ok "ssh: $(command -v ssh)"
  else
    miss "ssh client not found. Install with: sudo apt install -y openssh-client"
  fi

  if command -v apt-get >/dev/null 2>&1; then
    ok "apt-get: $(command -v apt-get)"
  elif command -v dnf >/dev/null 2>&1; then
    ok "dnf: $(command -v dnf)"
  elif command -v yum >/dev/null 2>&1; then
    ok "yum: $(command -v yum)"
  else
    miss "no apt-get / dnf / yum found. Hermes installer needs a package manager."
  fi
fi

# Optional: bash version (the install script pipes through bash)
echo
echo "-- Installer needs --"
BASH_MAJOR="${BASH_VERSINFO[0]:-0}"
if [[ "$BASH_MAJOR" -ge 4 ]]; then
  ok "bash $BASH_VERSION"
else
  miss "bash $BASH_VERSION is older than 4. Hermes installer wants bash 4+."
fi

echo
echo "Summary: $PASS ok, $FAIL missing"

if [[ "$FAIL" -eq 0 ]]; then
  echo
  echo "All prereqs look good. Next step:"
  echo "  Mac : curl -fsSL https://hermes-agent.newsresearch.com/install.sh | bash"
  echo "  VPS : ssh ubuntu@<your-server-ip>, then run the same curl line on the VPS."
  exit 0
else
  echo
  echo "Fix the MISS items above, then re-run this script."
  exit 1
fi
