#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
INPUT_TOKENS=$(echo "$input" | jq -r '.context_window.total_input_tokens')
OUTPUT_TOKENS=$(echo "$input" | jq -r '.context_window.total_output_tokens')
USED_PERCENT=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')

if [ -n "$USED_PERCENT" ]; then
    PERCENT_INT=$(printf "%.0f" "$USED_PERCENT")
    TOTAL_TOKENS=$((INPUT_TOKENS + OUTPUT_TOKENS))
    echo "[$MODEL] ${PERCENT_INT}% | ${INPUT_TOKENS} / ${OUTPUT_TOKENS}"
else
    echo "[$MODEL] 0%"
fi
