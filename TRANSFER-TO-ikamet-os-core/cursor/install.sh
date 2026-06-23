#!/usr/bin/env bash
# Ikamet Cursor ecosystem — one-time installer
# Home: ikamet-os-core/cursor/install.sh
# Run:  bash ~/GitHub/ikamet-os-core/cursor/install.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# ikamet-os-core/cursor → parent → ~/GitHub
GITHUB_DIR="${1:-$(cd "$SCRIPT_DIR/../.." && pwd)}"

if [[ "${1:-}" == "" && -d "$HOME/GitHub" ]]; then
  GITHUB_DIR="$HOME/GitHub"
fi

if [[ ! -d "$GITHUB_DIR" ]]; then
  echo "ERROR: GitHub folder not found."
  echo "Usage: bash install.sh /path/to/GitHub"
  exit 1
fi

echo "==> Ikamet Cursor ecosystem installer"
echo "    GitHub folder: $GITHUB_DIR"
echo ""

# --- Known repos (installer adds any other sibling git repos too) ---
KNOWN_REPOS=(
  ikamet-os-core
  app-api
  app-web
  app-admin
  app
  admin
  site-ikamet
  site-ikametsigorta
  site-ikametstaff
  docs-ikamet
  web-analytics
)

# Discover all git repos in GitHub folder
mapfile -t ALL_REPOS < <(find "$GITHUB_DIR" -maxdepth 1 -mindepth 1 -type d -exec test -d '{}/.git' \; -print | xargs -I{} basename {} | sort -u)

# Merge known + discovered
REPOS=()
for r in "${KNOWN_REPOS[@]}" "${ALL_REPOS[@]}"; do
  [[ -d "$GITHUB_DIR/$r/.git" ]] || continue
  [[ " ${REPOS[*]} " == *" $r "* ]] && continue
  REPOS+=("$r")
done

if [[ ${#REPOS[@]} -eq 0 ]]; then
  echo "ERROR: No git repos found in $GITHUB_DIR"
  exit 1
fi

echo "Found ${#REPOS[@]} repos: ${REPOS[*]}"
echo ""

# --- 1. Workspace file (open THIS in Cursor — one window, all repos) ---
WORKSPACE="$GITHUB_DIR/ikamet.code-workspace"
CORE_RULE='🧠 ikamet-os-core — READ FIRST'

python3 - "$WORKSPACE" "$GITHUB_DIR" "$CORE_RULE" "${REPOS[@]}" <<'PY'
import json, sys, os
workspace, github_dir, core_label = sys.argv[1], sys.argv[2], sys.argv[3]
repos = sys.argv[4:]

def folder(name, label=None):
    return {"path": name, "name": label or name}

folders = []
if "ikamet-os-core" in repos:
    folders.append(folder("ikamet-os-core", core_label))
    repos = [r for r in repos if r != "ikamet-os-core"]

priority = ["app-api", "app-web", "app-admin", "site-ikamet", "site-ikametsigorta", "web-analytics", "docs-ikamet", "site-ikametstaff"]
ordered = [r for r in priority if r in repos] + sorted(r for r in repos if r not in priority)

for r in ordered:
    folders.append(folder(r))

data = {
    "folders": folders,
    "settings": {
        "files.exclude": {
            "**/node_modules": True,
            "**/.git": False
        },
        "search.exclude": {
            "**/node_modules": True,
            "**/dist": True,
            "**/.next": True
        }
    },
    "extensions": {
        "recommendations": []
    }
}

with open(workspace, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
print(f"Wrote {workspace}")
PY

# --- 2. Start-here doc at GitHub root ---
cat > "$GITHUB_DIR/IKAMET-START-HERE.md" <<'EOF'
# Ikamet — start here (Cursor)

## One window, all repos, one chat

1. Open **Cursor**
2. **File → Open Workspace from File…**
3. Choose **`ikamet.code-workspace`** in this folder (`GitHub/ikamet.code-workspace`)

That is it. Do **not** open individual repos (`app-api`, `web-analytics`, etc.) on their own.

## One chat

Start one Agent chat and say what you need. The agent should read **`ikamet-os-core`** first (`DOCTRINE.md`, `AGENTS.md`).

If an agent says it cannot see other repos, remind it: *"We use ikamet.code-workspace — check sibling folders."*

## Re-run installer after adding a new repo

```bash
bash ~/GitHub/ikamet-os-core/cursor/install.sh
```

## Cloud Agents (cursor.com background agents)

Cloud agents still mount **one GitHub repo per task**. For cross-repo work, use **local Cursor + ikamet.code-workspace**.

EOF

# --- 3. Install .cursor/rules + AGENTS.md into every repo ---
install_rules() {
  local repo_path="$1"
  local repo_name="$2"
  mkdir -p "$repo_path/.cursor/rules"
  cp "$SCRIPT_DIR/templates/.cursor/rules/00-ikamet-ecosystem.mdc" "$repo_path/.cursor/rules/00-ikamet-ecosystem.mdc"

  if [[ "$repo_name" == "ikamet-os-core" ]]; then
    if [[ ! -f "$repo_path/AGENTS.md" ]]; then
      cp "$SCRIPT_DIR/templates/ikamet-os-core/AGENTS.md" "$repo_path/AGENTS.md"
    fi
    if [[ ! -f "$repo_path/DOCTRINE.md" ]]; then
      cp "$SCRIPT_DIR/templates/ikamet-os-core/DOCTRINE.md" "$repo_path/DOCTRINE.md"
    fi
    mkdir -p "$repo_path/.cursor/rules"
    cp "$SCRIPT_DIR/templates/ikamet-os-core/.cursor/rules/01-master.mdc" "$repo_path/.cursor/rules/01-master.mdc" 2>/dev/null || true
  else
    # Child repo: ensure AGENTS.md points at core (prepend banner if missing)
    if ! grep -q "ikamet-os-core" "$repo_path/AGENTS.md" 2>/dev/null; then
      if [[ -f "$repo_path/AGENTS.md" ]]; then
        tmp="$(mktemp)"
        cat "$SCRIPT_DIR/templates/AGENTS.md.child" > "$tmp"
        echo "" >> "$tmp"
        cat "$repo_path/AGENTS.md" >> "$tmp"
        mv "$tmp" "$repo_path/AGENTS.md"
      else
        cp "$SCRIPT_DIR/templates/AGENTS.md.child" "$repo_path/AGENTS.md"
        # Append repo-specific stub
        echo "" >> "$repo_path/AGENTS.md"
        echo "## This repo: \`$repo_name\`" >> "$repo_path/AGENTS.md"
      fi
    fi
    if [[ ! -f "$repo_path/CLAUDE.md" ]] && [[ -f "$repo_path/AGENTS.md" ]]; then
      ln -sf AGENTS.md "$repo_path/CLAUDE.md" 2>/dev/null || cp "$repo_path/AGENTS.md" "$repo_path/CLAUDE.md"
    fi
  fi
}

for r in "${REPOS[@]}"; do
  echo "Configuring $r ..."
  install_rules "$GITHUB_DIR/$r" "$r"
done

# --- 4. macOS: optional double-click helper ---
cat > "$GITHUB_DIR/Open Ikamet in Cursor.command" <<EOF
#!/bin/bash
cd "$GITHUB_DIR"
open -a "Cursor" "$GITHUB_DIR/ikamet.code-workspace"
EOF
chmod +x "$GITHUB_DIR/Open Ikamet in Cursor.command"

echo ""
echo "=============================================="
echo " DONE"
echo "=============================================="
echo ""
echo "Next time: double-click"
echo "  $GITHUB_DIR/Open Ikamet in Cursor.command"
echo "or open in Cursor:"
echo "  $GITHUB_DIR/ikamet.code-workspace"
echo ""
echo "Read: $GITHUB_DIR/IKAMET-START-HERE.md"
echo ""
