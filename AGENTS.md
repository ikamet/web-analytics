# web-analytics — Agent Instructions

Tinybird web analytics data project, flock.js tracker, and dashboard for the Ikamet ecosystem.

> **Read first:** `../ikamet-os-core/DOCTRINE.md` and `../ikamet-os-core/AGENTS.md` (or `CLAUDE.md`) before any change.
>
> This repo is one piece of a multi-repo system. Do not work in isolation.

## This repo

| Path | Purpose |
|------|---------|
| `tinybird/` | Tinybird datasources, pipes, deploy with `tb --cloud deploy` |
| `middleware/` | `@tinybirdco/flock.js` browser tracker source |
| `dashboard/` | Analytics dashboard (Next.js) |

## Sibling repos (same parent `GitHub/` folder)

| Repo | Purpose |
|------|---------|
| `ikamet-os-core` | **Source of truth** — doctrine, architecture, agent rules |
| `site-ikamet` | ikamet.com (Ghost CMS) |
| `site-ikametsigorta` | ikametsigorta.com |
| `app-api` | api.ikamet.com |
| `app-web` | app.ikamet.com |
| `app-admin` | ops.ikamet.com |
| `docs-ikamet` | Documentation |
| `site-ikametstaff` | Staff site |

When fixing analytics: check **this repo** (Tinybird schema/deploy) **and** `site-ikamet` (Ghost `ghost-stats` + flock.js injection).

## Live Tinybird

- Host: `https://api.europe-west2.gcp.tinybird.co`
- Datasource: `analytics_events`
