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
# GitHub makes port 8787 private again on every wake-up. The background service has no Codespace login, so make it public here (retry while the port appears).
for i in $(seq 1 30); do gh codespace ports visibility 8787:public -c "$CODESPACE_NAME" >/dev/null 2>&1 && break; sleep 3; done
# Save the Codespace login for the background service (it keeps port 8787 public and the bridge running, even when no editor is open). Only you can read this file.
( umask 077; printf 'export GITHUB_TOKEN=%s\nexport CODESPACE_NAME=%s\n' "$GITHUB_TOKEN" "$CODESPACE_NAME" > "$HOME/.syok/gh.env" )
