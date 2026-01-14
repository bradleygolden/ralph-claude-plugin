#!/bin/bash

# Ralph Wiggum Loop
# Runs Claude continuously with a prompt, piping output to repomirror for visualization

set -e

# Parse flags
UNSAFE_MODE=false
MODEL=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --unsafe)
            UNSAFE_MODE=true
            shift
            ;;
        --model)
            MODEL="$2"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

# Get the prompt from all remaining arguments
PROMPT="$*"

if [ -z "$PROMPT" ]; then
    echo "Usage: ralph.sh [--unsafe] [--model <model>] <prompt>"
    echo "  prompt: Text prompt (use @file.md to expand file contents)"
    echo "  --unsafe: Use --dangerously-skip-permissions instead of sandbox mode"
    echo "  --model: Model to use (e.g., sonnet, opus, haiku)"
    exit 1
fi

echo "Starting Ralph Wiggum loop..."
if [ "$UNSAFE_MODE" = true ]; then
    echo "Mode: UNSAFE (--dangerously-skip-permissions)"
else
    echo "Mode: Sandbox (auto-allow)"
fi
[ -n "$MODEL" ] && echo "Model: $MODEL"
echo "Prompt: ${PROMPT:0:100}..."
echo "Press Ctrl+C to stop"
echo ""

# Build model flag if specified
MODEL_FLAG=""
[ -n "$MODEL" ] && MODEL_FLAG="--model $MODEL"

# Sandbox settings JSON
SANDBOX_SETTINGS='{"sandbox":{"enabled":true,"autoAllowBashIfSandboxed":true}}'

while true; do
    if [ "$UNSAFE_MODE" = true ]; then
        echo "$PROMPT" | claude -p \
            --dangerously-skip-permissions \
            $MODEL_FLAG \
            --output-format=stream-json \
            --verbose \
            | npx repomirror visualize
    else
        echo "$PROMPT" | claude -p \
            --settings "$SANDBOX_SETTINGS" \
            $MODEL_FLAG \
            --output-format=stream-json \
            --verbose \
            | npx repomirror visualize
    fi

    echo -e "\n\n========================LOOP=========================\n\n"
    sleep 10
done
