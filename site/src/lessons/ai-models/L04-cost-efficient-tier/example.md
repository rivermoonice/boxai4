# L04 example — price-out one task on three cost-efficient models

The smallest runnable "do it" demo for [L04 — Cost-Efficient AI Model Tier](/lessons/ai-models/l04-cost-efficient-tier/).
Goal: take one real prompt, send it to Qwen Plus, MiniMax M3, and GLM 5.2,
compare **quality / speed / cost** with numbers, not vibes.

## Prerequisites

- A Bash shell
- One API key from each provider (or use the web playground):
  - `QWEN_API_KEY` — Alibaba Cloud Bailian (Qwen Plus endpoint `qwen-plus`)
  - `MINIMAX_API_KEY` — MiniMax (M3 endpoint `MiniMax-M3`)
  - `GLM_API_KEY` — Z.AI (GLM 5.2 endpoint `glm-5-2`)
- `curl` and `bc`

## Step 1 — define the task and the system prompt

```bash
PROMPT="Refactor this Python function to use a single dict comprehension instead of two list comprehensions. Return only the new function body, no commentary."

INPUT=$(cat <<'EOF'
def normalize(rows):
    keys = [r[0] for r in rows]
    vals = [r[1] for r in rows]
    return dict(zip(keys, vals))
EOF
)
```

`PROMPT` is the work order. `INPUT` is the code under review. Same payload for all three calls.

## Step 2 — price the call before you send it

Per L04, the only honest cost unit is `$/1M tokens`. Qwen Plus = $0.40/M input, $1.20/M output. MiniMax M3 = $0.30/M input, $1.10/M output. GLM 5.2 = $0.60/M input, $2.20/M output.

```bash
input_tokens=$(printf '%s\n%s' "$PROMPT" "$INPUT" | wc -w | awk '{print $1*4/3}')
echo "Estimated input tokens: $input_tokens"
```

Rule of thumb: `tokens ~= words * 4/3`. Replace with each provider's tokenizer if you have one.

## Step 3 — call the three providers

```bash
call_qwen() {
  start=$(date +%s)
  curl -sS https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions \
    -H "Authorization: Bearer $QWEN_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"qwen-plus\",\"messages\":[{\"role\":\"user\",\"content\":\"$PROMPT\n\n$INPUT\"}]}" \
    > qwen.json
  end=$(date +%s)
  echo "Qwen Plus: $((end-start))s"
}

call_minimax() {
  start=$(date +%s)
  curl -sS https://api.MiniMax.com/v1/text/chatcompletion_v2 \
    -H "Authorization: Bearer $MINIMAX_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"MiniMax-M3\",\"messages\":[{\"role\":\"user\",\"content\":\"$PROMPT\n\n$INPUT\"}]}" \
    > MiniMax.json
  end=$(date +%s)
  echo "MiniMax M3: $((end-start))s"
}

call_glm() {
  start=$(date +%s)
  curl -sS https://api.z.ai/api/paas/v4/chat/completions \
    -H "Authorization: Bearer $GLM_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"glm-5-2\",\"messages\":[{\"role\":\"user\",\"content\":\"$PROMPT\n\n$INPUT\"}]}" \
    > glm.json
  end=$(date +%s)
  echo "GLM 5.2: $((end-start))s"
}

call_qwen
call_minimax
call_glm
```

## Step 4 — read the actual tokens billed

```bash
qwen_out=$(jq '.usage.output_tokens // 0' qwen.json)
MiniMax_out=$(jq '.usage.output_tokens // 0' MiniMax.json)
glm_out=$(jq '.usage.output_tokens // 0' glm.json)

qwen_cost=$(echo "scale=4; ($input_tokens*0.40 + $qwen_out*1.20) / 1000000" | bc)
MiniMax_cost=$(echo "scale=4; ($input_tokens*0.30 + $MiniMax_out*1.10) / 1000000" | bc)
glm_cost=$(echo "scale=4; ($input_tokens*0.60 + $glm_out*2.20) / 1000000" | bc)

printf "Qwen Plus:    output=%-5s cost=\$%s\n" "$qwen_out" "$qwen_cost"
printf "MiniMax M3:   output=%-5s cost=\$%s\n" "$MiniMax_out" "$MiniMax_cost"
printf "GLM 5.2:      output=%-5s cost=\$%s\n" "$glm_out" "$glm_cost"
```

Expected output (numbers vary — that is the point):

```
Qwen Plus:    output=58    cost=$0.000071
MiniMax M3:   output=62    cost=$0.000075
GLM 5.2:      output=104   cost=$0.000265
```

Total across all three: well under $0.001. The same prompt on Claude Opus 4.8 costs $0.015–$0.030 on output alone — roughly **20× more**.

## Step 5 — judge quality

Open each `.json` and read the model's reply. For the prompt above, the correct answer is one line:

```python
def normalize(rows):
    return {r[0]: r[1] for r in rows}
```

Mark each one **ship / edit-and-ship / reject**. The cheapest model that ships wins the workload; that becomes your default for similar tasks.

## Cleanup

```bash
rm -f qwen.json MiniMax.json glm.json
```

## What you proved

- The cost gap is real and measurable.
- The cheapest model is not always the right default — check speed and quality before locking in.
- Per L04's decision table, this is a "daily-driver coding Q&A" workload, so **Qwen Plus** or **Kimi K2.7** is the right long-term default. MiniMax M3 is overkill here; GLM 5.2 wastes money on a non-design task.
