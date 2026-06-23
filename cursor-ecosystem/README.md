# Ikamet Cursor ecosystem (one-time Mac setup)

This folder makes **one Cursor workspace** for all Ikamet repos on your Mac — same idea as Claude/Codex seeing the whole monorepo.

## One command (run once on your Mac)

```bash
bash ~/GitHub/web-analytics/cursor-ecosystem/install.sh
```

If your folder is not `~/GitHub`:

```bash
bash ~/GitHub/web-analytics/cursor-ecosystem/install.sh /path/to/your/GitHub
```

## What it does

1. Creates **`~/GitHub/ikamet.code-workspace`** — open this in Cursor (all repos at once)
2. Creates **`~/GitHub/IKAMET-START-HERE.md`** — short instructions
3. Creates **`~/GitHub/Open Ikamet in Cursor.command`** — double-click to open
4. Installs **`.cursor/rules`** in every repo so agents read **`ikamet-os-core`** first
5. Ensures every repo has **`AGENTS.md`** pointing at core (won't overwrite your existing doctrine)

## After install — every day

Double-click **`Open Ikamet in Cursor.command`**  
or in Cursor: **File → Open Workspace from File → `ikamet.code-workspace`**

**One chat.** Say the task. Agent checks core + siblings.

## Re-run when you add a new repo

```bash
bash ~/GitHub/web-analytics/cursor-ecosystem/install.sh
```

## Cloud Agents vs local Cursor

| | Local Cursor + workspace | Cloud Agent |
|--|--------------------------|-------------|
| All repos visible | Yes | No (one repo per run) |
| Cross-repo fixes | Yes | Limited |

Use **local Cursor + workspace** for ecosystem work. Use Cloud Agents for single-repo tasks.
