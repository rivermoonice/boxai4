#!/usr/bin/env bash
# example.sh — L01 "do it" demo: print the brain/harness mental model,
# then peek at the Hermes repo README so you can see the real project.
#
# Run from repo root:
#   bash site/src/lessons/hermes/L01-what-is-hermes-agent/example.sh
#
# Requires: curl (already on macOS/Linux). No Hermes install needed for L01.

set -euo pipefail

echo "==> Mental model recap"
echo "   MODEL  = the brain (Claude, GPT, DeepSeek, Kimi, Qwen)"
echo "   HARNESS = the body (Hermes wraps the model; gives it files, shell, memory, scheduling)"
echo

echo "==> Reading the first 20 lines of the Hermes repo README via the GitHub API"
echo "    Source: https://github.com/hermes-agent/hermes-agent"
echo

if ! command -v curl >/dev/null 2>&1; then
  echo "FAIL: curl not found. Install curl and re-run." >&2
  exit 1
fi

README=$(curl -fsSL https://api.github.com/repos/hermes-agent/hermes-agent/readme 2>/dev/null || true)

if [[ -z "$README" ]]; then
  echo "Note: GitHub API rate-limit hit or offline. That's fine — L01 is concept-only."
  echo "Try again later, or visit: https://github.com/hermes-agent/hermes-agent"
  exit 0
fi

# GitHub returns base64-encoded content. Decode and print the first 20 lines.
echo "$README" | python3 -c '
import sys, json, base64
data = json.load(sys.stdin)
content = base64.b64decode(data.get("content", "")).decode("utf-8", errors="replace")
for i, line in enumerate(content.splitlines()[:20], 1):
    print(f"{i:>2}: {line}")
' 2>/dev/null || echo "(could not decode README body — skipping)"

echo
echo "==> Done. Takeaway: the harness is the body, the model is the brain."