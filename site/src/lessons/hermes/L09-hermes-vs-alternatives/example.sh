#!/usr/bin/env bash
# L09 — interactive decision matrix: prompt for workload / volume /
# open-source tolerance and print the harness that fits. Defaults to Hermes
# for beginners if no input is supplied. Falls back to a printout of the
# decision matrix and exits 0 if stdin is non-interactive.

set -u

DEFAULT_REASON="Hermes is the safe beginner choice: open-source, BYOK, multi-channel, runs anywhere."

print_matrix() {
  cat <<'EOF'
L09 decision matrix (no interactive input — fallback):

| Workload                                  | Harness      |
|-------------------------------------------|--------------|
| Coding / shipping software all day        | Claude Code  |
| Long-running automation (cron, bots)      | Hermes       |
| Multi-channel ops (Discord, Telegram)     | Hermes       |
| Brand new to AI agents                    | Mavis        |
| Inside Google Cloud already               | Gemini       |
| Want full control + BYOK pricing          | Hermes       |
| Want vendor polish + bundled model        | Claude Code  |
| Want cheapest on-ramp                     | Mavis        |

Default for a beginner with no input: Hermes.
EOF
}

# Non-interactive fallback: if stdin is not a TTY, just print the matrix.
if [ ! -t 0 ]; then
  echo "example.sh: no interactive input — printing decision matrix."
  print_matrix
  exit 0
fi

ask() {
  local label="$1"
  local prompt="$2"
  local default="$3"
  local ans
  read -r -p "$prompt [$default]: " ans
  ans="${ans:-$default}"
  echo "$ans"
}

WORKLOAD=$(ask "workload" "Workload (coding | automation | multi-channel | beginner | google-cloud | other)" "beginner")
VOLUME=$(ask "volume" "Volume (low <50 msg/day | medium 50-500 | high 500+)" "low")
OSS=$(ask "oss" "Open-source tolerance (must | nice | dont-care)" "nice")

pick() {
  local w="$1" v="$2" o="$3"
  case "$w" in
    coding|code)
      echo "Claude Code"
      echo "Claude Code is the polished coding harness with IDE integration and test-running."
      ;;
    automation|cron|bots)
      echo "Hermes"
      echo "Hermes wins long-running automation: cron, Kanban, sub-agents, multi-channel."
      ;;
    multi-channel|discord|telegram)
      echo "Hermes"
      echo "Hermes is the only harness with first-class Discord and Telegram routing."
      ;;
    beginner|new)
      echo "Mavis"
      echo "Mavis is the cheapest on-ramp; graduate to Hermes after a few months."
      ;;
    google-cloud|gcp)
      echo "Gemini"
      echo "Gemini bundles model + harness + sandbox (Antigravity) inside Google Cloud."
      ;;
    other|*)
      # Fall through to volume + OSS logic
      if [ "$v" = "high" ] && [ "$o" = "dont-care" ]; then
        echo "Claude Code"
        echo "High volume with no OSS need = Claude Code's subscription flattens cost."
      elif [ "$o" = "must" ]; then
        echo "Hermes"
        echo "Only Hermes is open-source and BYOK; you can read and fork the code."
      else
        echo "Hermes"
        echo "$DEFAULT_REASON"
      fi
      ;;
  esac
}

HARNESS=$(pick "$WORKLOAD" "$VOLUME" "$OSS" | head -n 1)
REASON=$(pick "$WORKLOAD" "$VOLUME" "$OSS" | tail -n 1)

echo ""
echo "Picked: $HARNESS"
echo "Reason: $REASON"
echo ""
echo "(Volume=$VOLUME, OSS=$OSS)"
exit 0