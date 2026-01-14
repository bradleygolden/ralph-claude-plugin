# Ralph Claude Plugin

A Claude Code plugin that runs the "Ralph Wiggum loop" - continuous Claude execution with repomirror visualization.

## What it does

The Ralph loop continuously:
1. Executes Claude with your prompt in piped mode
2. Pipes output to `repomirror visualize` for visualization
3. Waits 10 seconds
4. Repeats until you stop it with `Ctrl+C`

## Installation

### From GitHub

```bash
# Step 1: Add the marketplace
/plugin marketplace add bradleygolden/ralph-claude-plugin

# Step 2: Install the plugin
/plugin install ralph@ralph-claude-plugin --scope user
```

### Local Development

```bash
claude --plugin-dir ./plugins/ralph
```

## Usage

### Default (sandbox mode)

Runs with sandbox enabled and auto-allow for bash commands:
```bash
/ralph:ralph "Review the codebase and suggest improvements"
/ralph:ralph @PROMPT.md
```

### Unsafe mode (skip permissions)

Use `--unsafe` to bypass sandbox and use `--dangerously-skip-permissions`:
```bash
/ralph:ralph --unsafe "your prompt"
/ralph:ralph --unsafe @PROMPT.md
```

### Specify a model

Use `--model` to specify which Claude model to use:
```bash
/ralph:ralph --model opus "your prompt"
/ralph:ralph --model haiku "quick task"
/ralph:ralph --model sonnet @PROMPT.md
```

Valid model values: `sonnet`, `opus`, `haiku`, or full model IDs.

### Combine flags

Flags can be combined in any order:
```bash
/ralph:ralph --unsafe --model opus "your prompt"
/ralph:ralph --model haiku --unsafe @PROMPT.md
```

## How to stop

Press `Ctrl+C` to stop the loop.

## Requirements

- [repomirror](https://www.npmjs.com/package/repomirror) - for visualization (`npx repomirror visualize`)
- Claude CLI

## License

MIT
