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
