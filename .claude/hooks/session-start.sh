#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# markitdown-mcp (declared in .mcp.json) needs these installed — each remote
# session starts from a fresh container, so nothing from a prior pip install
# persists. cffi is a runtime dependency pulled in transitively by pdfminer
# but not always resolved correctly, so install it explicitly.
pip3 install --user --break-system-packages markitdown-mcp cffi

# claude-mem plugin (declared in .claude/settings.json) is cached under
# ~/.claude/plugins, outside the repo, so a fresh container has no cache
# either. Both commands are idempotent no-ops if already present.
claude plugin marketplace add thedotmack/claude-mem --scope project
claude plugin install claude-mem@thedotmack -s project

# impeccable's design-detector hook writes its Claude Code manifest to
# .claude/settings.local.json, which is globally gitignored in this
# environment (machine-local by design) and so never survives a fresh
# container. Re-run the offline, idempotent hook-admin script to
# reinstall it each session; .impeccable/config.json (the shared toggle)
# is committed separately and this is a no-op once it's already "on".
node "${CLAUDE_PROJECT_DIR:-$(pwd)}/.agents/skills/impeccable/scripts/hook-admin.mjs" on
