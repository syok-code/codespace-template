#!/bin/sh
set -e
cat > /usr/local/share/syok-bridge-run.sh <<'EOF'
#!/bin/bash
export PATH="$HOME/.bun/bin:$HOME/.local/bin:$PATH"
mkdir -p "$HOME/.syok"
until [ -f "$HOME/.syok/syok.js" ] && [ -x "$HOME/.bun/bin/bun" ]; do sleep 5; done
D=""
until [ -n "$D" ]; do D=$(ls -d /workspaces/*/ 2>/dev/null | grep -v '/\.codespaces' | head -n 1); sleep 2; done
cd "$D"
while true; do
pgrep -f "syok.js bridge" >/dev/null 2>&1 || { echo "$(date -u +%FT%TZ) entry launching bridge" >> "$HOME/.syok/start.log"; "$HOME/.bun/bin/bun" "$HOME/.syok/syok.js" bridge >> "$HOME/.syok/bridge.log" 2>&1 < /dev/null; }
sleep 5
done
EOF
cat > /usr/local/share/syok-bridge-entry.sh <<'EOF'
#!/bin/sh
nohup su vscode -c /usr/local/share/syok-bridge-run.sh >/dev/null 2>&1 < /dev/null &
exec "$@"
EOF
chmod +x /usr/local/share/syok-bridge-run.sh /usr/local/share/syok-bridge-entry.sh
