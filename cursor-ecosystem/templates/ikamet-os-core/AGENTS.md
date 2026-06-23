# ikamet-os-core — master agent instructions

**This repo is the source of truth for the Ikamet ecosystem.**

Every other repo under `~/GitHub/` points here. Agents must read this before cross-repo work.

## Open Cursor correctly

Open **`~/GitHub/ikamet.code-workspace`** — not a single child repo.

## Architecture

```text
ikamet.com              site-ikamet (Ghost CMS)
ikametsigorta.com       site-ikametsigorta (Astro)
app.ikamet.com          app-web
ops.ikamet.com          app-admin
api.ikamet.com          app-api
analytics               web-analytics (Tinybird)
```

## Repo responsibilities

| Repo | Owns | Must NOT own |
|------|------|----------------|
| `ikamet-os-core` | Doctrine, docs, agent rules | Application code |
| `app-api` | API, payments, orchestration | Public marketing pages |
| `app-web` | Customer authenticated flows | Ops admin |
| `app-admin` | Ops, fulfilment, internal tools | Public site |
| `site-ikamet` | ikamet.com content, Ghost | Backend orchestration |
| `site-ikametsigorta` | Insurance marketing, funnels | Provider ops |
| `web-analytics` | Tinybird schema, flock.js, dashboard | Ghost theme (except tracking tags) |

## Agent rules

1. Read `DOCTRINE.md` before architectural decisions.
2. Cross-repo changes: list affected repos in the plan before editing.
3. Never tell the user to open another folder — use the workspace.
4. Delegate subtasks by naming target repo paths, not separate chats.

## Installer

Re-sync all repos after adding a new one:

```bash
bash ~/GitHub/web-analytics/cursor-ecosystem/install.sh
```
