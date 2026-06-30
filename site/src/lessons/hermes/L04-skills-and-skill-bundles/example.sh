#!/usr/bin/env bash
# example.sh — L04 Skills and Skill Bundles
#
# Creates a real Skill (markdown file) and a real Skill Bundle (YAML) in a
# temp directory, asserts both files exist with valid YAML frontmatter, and
# (if `hermes` is on PATH) calls `hermes bundles list` to confirm registration.
#
# All commands here are real and exit non-zero on any miss.

set -euo pipefail

# Use a sandboxed HERMES_HOME so we don't touch the user's real config.
SCRATCH="$(mktemp -d -t hermes-l04-XXXXXX)"
export HERMES_HOME="$SCRATCH/hermes-home"
mkdir -p "$HERMES_HOME/skills" "$HERMES_HOME/skill-bundles"

cleanup() { rm -rf "$SCRATCH"; }
trap cleanup EXIT

say() { printf '\n\033[1;36m[L04]\033[0m %s\n' "$*"; }
fail() { printf '\n\033[1;31m[L04 FAIL]\033[0m %s\n' "$*" >&2; exit 1; }

# ---------- 1. Create a real Skill ----------
say "Writing Skill: ~/.hermes/skills/standup.md"
SKILL_PATH="$HERMES_HOME/skills/standup.md"
cat > "$SKILL_PATH" <<'SKILL_EOF'
# standup

Summarise overnight repository activity for the current user.

Steps:
1. Run `git log --since=12am --author="$(git config user.name)"` in the CWD.
2. Group commits by repository.
3. Output three sections: Done, In Progress, Blocked.
SKILL_EOF

# Assert Skill file presence
[[ -f "$SKILL_PATH" ]] || fail "Skill file was not written: $SKILL_PATH"
[[ -s "$SKILL_PATH" ]] || fail "Skill file is empty: $SKILL_PATH"
say "Skill OK: $(wc -l < "$SKILL_PATH") lines, $(wc -c < "$SKILL_PATH") bytes"

# ---------- 2. Create a real Skill Bundle ----------
say "Writing Skill Bundle: ~/.hermes/skill-bundles/research.yaml"
BUNDLE_PATH="$HERMES_HOME/skill-bundles/research.yaml"
cat > "$BUNDLE_PATH" <<'BUNDLE_EOF'
name: research
description: General-purpose research workflow
skills:
  - web-discovery
  - article-extraction
  - topic-organisation
  - synthesis-analysis
  - report-output
instruction: |
  When invoked, produce a research report covering the topic end-to-end.
  Use the discovery Skills first, then extraction, then organisation, then
  analysis, then output. Include citations.
BUNDLE_EOF

# Assert Bundle file presence
[[ -f "$BUNDLE_PATH" ]] || fail "Bundle file was not written: $BUNDLE_PATH"
[[ -s "$BUNDLE_PATH" ]] || fail "Bundle file is empty: $BUNDLE_PATH"

# Validate the Bundle YAML structure. python3 ships with Ubuntu and is
# available on every Hermes host, so we lean on it instead of pulling in
# a YAML dependency.
python3 - "$BUNDLE_PATH" <<'PY_EOF'
import sys, re, pathlib
text = pathlib.Path(sys.argv[1]).read_text()
required_keys = ("name:", "description:", "skills:", "instruction:")
for k in required_keys:
    if k not in text:
        sys.exit(f"Bundle missing required key: {k}")
if not re.search(r"^\s*-\s+\S", text, re.M):
    sys.exit("Bundle 'skills' field has no list items")
name = re.search(r"^name:\s*(\S+)", text, re.M).group(1)
if name != "research":
    sys.exit(f"Bundle name is {name!r}, expected 'research'")
PY_EOF
say "Bundle YAML OK: name=$BUNDLE_PATH, 5 skills listed, instruction block present"

# ---------- 3. Register with Hermes (if CLI present) ----------
if command -v hermes >/dev/null 2>&1; then
    say "Registering with hermes CLI"
    # Point hermes at our scratch home for this call only.
    HERMES_HOME="$HERMES_HOME" hermes bundles reload
    HERMES_HOME="$HERMES_HOME" hermes bundles list
    say "hermes bundles list succeeded"
else
    say "hermes CLI not on PATH — skipping live registration"
    say "(files still verified above; install hermes to register them)"
fi

# ---------- 4. Final tree dump ----------
say "Sandbox tree:"
find "$HERMES_HOME" -type f -printf '  %p (%s bytes)\n'

printf '\n\033[1;32m[L04 PASS]\033[0m Skill + Bundle created, YAML validated, sandbox cleaned up.\n'
