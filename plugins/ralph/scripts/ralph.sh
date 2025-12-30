#!/bin/bash

# Ralph Wiggum Loop
# Runs Claude continuously with a prompt, piping output to repomirror for visualization

set -e

# Get the prompt from all arguments (allows for multi-word prompts)
PROMPT="$*"

if [ -z "$PROMPT" ]; then
    echo "Usage: ralph.sh <prompt>"
    echo "  prompt: Text prompt (use @file.md to expand file contents)"
    exit 1
fi

echo "Starting Ralph Wiggum loop..."
echo "Prompt: ${PROMPT:0:100}..."
echo "Press Ctrl+C to stop"
echo ""

while true; do
    echo "$PROMPT" | claude -p \
        --dangerously-skip-permissions \
        --output-format=stream-json \
        --verbose \
        | npx repomirror visualize

    echo -e "\n\n========================LOOP=========================\n\n"
    sleep 10
done
