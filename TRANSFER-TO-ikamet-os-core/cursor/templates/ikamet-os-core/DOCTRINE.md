# Ikamet OS — Doctrine

> If this file already exists in your private `ikamet-os-core`, keep your version — the installer does not overwrite existing `DOCTRINE.md`.

## Principle

Ikamet is **one product** implemented as **many repos** under `~/GitHub/`. Agents and humans use **`ikamet.code-workspace`** so nothing is worked on in isolation.

## Domains

| Domain | Repo | Stack |
|--------|------|-------|
| ikamet.com | site-ikamet | Ghost |
| ikametsigorta.com | site-ikametsigorta | Astro |
| app.ikamet.com | app-web | Next.js |
| ops.ikamet.com | app-admin | Next.js |
| api.ikamet.com | app-api | API |
| Analytics | web-analytics | Tinybird |

## Boundaries

- **Public sites** = content, SEO, conversion. No fulfilment orchestration.
- **app-api** = business logic, integrations, payments.
- **app-admin** = internal ops only.
- **web-analytics** = event pipeline and dashboards; sites only embed trackers.

## Analytics (Tinybird)

- Browser: `@tinybirdco/flock.js` + Ghost `ghost-stats` → `analytics_events`
- Data project: `web-analytics/tinybird/` — deploy with `tb --cloud deploy`
- Host: `api.europe-west2.gcp.tinybird.co`

## Change discipline

Any change that touches contracts (API, events, env vars) must note sibling repos in the PR description.
