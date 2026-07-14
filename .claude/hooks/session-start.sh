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
