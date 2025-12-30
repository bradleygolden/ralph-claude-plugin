---
description: Run the Ralph Wiggum loop - continuous Claude execution with repomirror visualization
argument-hint: <prompt or @file.md>
---

# Ralph Wiggum Loop

Run the Ralph Wiggum loop with the provided prompt.

Use `@file.md` syntax to reference a prompt file - Claude Code will expand the file contents.

The loop will:
1. Execute Claude with the prompt in piped mode
2. Pipe output to repomirror for visualization
3. Wait 10 seconds
4. Repeat indefinitely until stopped with Ctrl+C

Execute the ralph script with the provided arguments:

```bash
${CLAUDE_PLUGIN_ROOT}/scripts/ralph.sh $ARGUMENTS
```
