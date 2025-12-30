#!/bin/bash

# Ralph Wiggum Loop
# Runs Claude continuously with a prompt, piping output to repomirror for visualization

set -e

# Parse --unsafe flag (to use --dangerously-skip-permissions instead of sandbox)
UNSAFE_MODE=false
if [ "$1" = "--unsafe" ]; then
    UNSAFE_MODE=true
    shift
fi

# Get the prompt from all remaining arguments
PROMPT="$*"

if [ -z "$PROMPT" ]; then
    echo "Usage: ralph.sh [--unsafe] <prompt>"
    echo "  prompt: Text prompt (use @file.md to expand file contents)"
    echo "  --unsafe: Use --dangerously-skip-permissions instead of sandbox mode"
    exit 1
fi

echo "Starting Ralph Wiggum loop..."
if [ "$UNSAFE_MODE" = true ]; then
    echo "Mode: UNSAFE (--dangerously-skip-permissions)"
else
    echo "Mode: Sandbox (auto-allow)"
fi
echo "Prompt: ${PROMPT:0:100}..."
echo "Press Ctrl+C to stop"
echo ""

# Sandbox settings JSON
SANDBOX_SETTINGS='{"sandbox":{"enabled":true,"autoAllowBashIfSandboxed":true}}'

while true; do
    if [ "$UNSAFE_MODE" = true ]; then
        echo "$PROMPT" | claude -p \
            --dangerously-skip-permissions \
            --output-format=stream-json \
            --verbose \
            | npx repomirror visualize
    else
        echo "$PROMPT" | claude -p \
            --settings "$SANDBOX_SETTINGS" \
            --output-format=stream-json \
            --verbose \
            | npx repomirror visualize
    fi

    echo -e "\n\n========================LOOP=========================\n\n"
    sleep 10
done
