#!/usr/bin/env bash
# Runs every time the Codespace starts (also after it was stopped): keeps Syok Code current and starts the bridge.
export PATH="$HOME/.bun/bin:$HOME/.local/bin:$PATH"
mkdir -p "$HOME/.syok"
# Update to the newest Syok Code; if the download fails, keep the one we have.
if curl -fsSL https://syok-ai.com/syok-code/syok.js -o "$HOME/.syok/syok.js.new"; then mv "$HOME/.syok/syok.js.new" "$HOME/.syok/syok.js"; fi
# Work in your project folder.
cd "${CODESPACE_VSCODE_FOLDER:-$PWD}"
# Start the bridge once (it makes port 8787 reachable for Syok and waits for commands).
if ! pgrep -f "syok.js bridge" >/dev/null 2>&1; then
  echo "$(date -u +%FT%TZ) start.sh launching bridge" >> "$HOME/.syok/start.log"
  setsid nohup syok bridge >> "$HOME/.syok/bridge.log" 2>&1 < /dev/null &
  disown
fi
