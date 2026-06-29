#!/usr/bin/env bash
# capture-hermes.sh — capture authentic Hermes CLI output as raw terminal bytes.
#
# This script does NOT render screenshots. It writes the raw captured output
# (with ANSI color escapes) to a staging directory so the Node render script
# can turn each capture into a styled PNG.
#
# Usage:
#   bash site/scripts/capture-hermes.sh /tmp/hermes-captures
#
# Output:
#   $1/<command>.raw     — the raw bytes, including ANSI escape codes
#
# Notes:
#   - We use `script` for each capture. `script` records everything to/from
#     a TTY. We don't need a real TTY because we're capturing output, not
#     interactive input.
#   - We force a wide terminal (COLUMNS=160) so tables from `hermes status`,
#     `hermes doctor`, and `hermes skills list` render without wrapping.
#   - We capture `--help` and `version` from every command; for full sub-
#     command output we capture specific commands that work without API keys.
#   - We always trim the `script` header/timestamp lines from the output.

set -euo pipefail

OUT="${1:-/tmp/hermes-captures}"
mkdir -p "$OUT"

# Discover Hermes. Allow override via $HERMES_BIN.
HERMES_BIN="${HERMES_BIN:-/home/ubuntu/.local/bin/hermes}"

if [[ ! -x "$HERMES_BIN" ]]; then
  echo "ERROR: hermes not executable at $HERMES_BIN" >&2
  exit 1
fi

# Force a wide terminal for table-style commands.
export COLUMNS=160
export LINES=50
export TERM="${TERM:-xterm-256color}"

capture() {
  local cmd_label="$1"
  shift
  local out_file="$OUT/${cmd_label}.raw"
  echo "  capturing $cmd_label ..."
  # Use script(1) with a quiet flag and a custom command. The `-c` runs the
  # command in a sub-shell, and the file gets the entire session including
  # terminal control sequences. We strip the first line (the "Script started"
  # banner) and the last line ("Script done") afterwards.
  script -q -e -c "$*" "$out_file" >/dev/null 2>&1 || true
  # Strip the script header/footer.
  if [[ -f "$out_file" ]]; then
    # Use awk to drop lines containing "Script started" or "Script done".
    awk '!/Script started/ && !/Script done/' "$out_file" > "${out_file}.tmp"
    mv "${out_file}.tmp" "$out_file"
  fi
}

echo "Capturing Hermes CLI output to $OUT ..."

# Top-level help and version.
capture "hermes-help"       "$HERMES_BIN --help"
capture "hermes-version"    "$HERMES_BIN --version"

# Sub-commands that work without API keys (verified against v0.17.0):
capture "hermes-status"     "$HERMES_BIN status"
capture "hermes-doctor"     "$HERMES_BIN doctor"
capture "hermes-skills"     "$HERMES_BIN skills list"

echo "Done. Captured files:"
ls -la "$OUT"