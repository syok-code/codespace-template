#!/usr/bin/env bash
# Runs once when the Codespace is created: installs Bun and the Syok Code command (syok).
set -e
export PATH="$HOME/.bun/bin:$HOME/.local/bin:$PATH"
if ! command -v bun >/dev/null 2>&1; then curl -fsSL https://bun.sh/install | bash; fi
mkdir -p "$HOME/.syok" "$HOME/.local/bin"
curl -fsSL https://syok-ai.com/syok-code/syok.js -o "$HOME/.syok/syok.js"
printf '#!/usr/bin/env bash\nexec "$HOME/.bun/bin/bun" "$HOME/.syok/syok.js" "$@"\n' > "$HOME/.local/bin/syok"
chmod +x "$HOME/.local/bin/syok"
grep -q '.local/bin' "$HOME/.bashrc" 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"' >> "$HOME/.bashrc"
grep -q "bridge-hook" "$HOME/.bashrc" 2>/dev/null || echo 'pgrep -f "syok.js bridge" >/dev/null 2>&1 || bash "${CODESPACE_VSCODE_FOLDER:-.}/.devcontainer/start.sh" >/dev/null 2>&1 # bridge-hook' >> "$HOME/.bashrc"; echo "Syok Code installed. Run: syok --help"
