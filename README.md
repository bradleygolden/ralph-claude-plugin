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

### With inline prompt

```bash
/ralph:ralph "Review the codebase and suggest improvements"
```

### With prompt file (using @ syntax)

```bash
/ralph:ralph @PROMPT.md
```

The `@` syntax expands the file contents inline before passing to the command.

## How to stop

Press `Ctrl+C` to stop the loop.

## Requirements

- [repomirror](https://www.npmjs.com/package/repomirror) - for visualization (`npx repomirror visualize`)
- Claude CLI

## License

MIT
