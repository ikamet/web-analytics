# Pay / referral links for app.ikamet.com

Copy into **`app-web`** (and wire **`app-api`** if checkout needs the slug server-side).

## Recommended design (Wise-style)

| URL | Purpose |
|-----|---------|
| `https://app.ikamet.com/pay/christophera7` | Customer pays; `christophera7` = partner/referrer slug |
| `https://app.ikamet.com/invite/christophera7` | Same attribution, signup-first wording (optional alias) |

Both set a **90-day cookie** `ikamet_ref` and send the user to checkout (or home if checkout path unknown).

## Install in app-web

From your Mac, in the **ikamet workspace** Cursor window, paste this to the agent:

> Copy `web-analytics/TRANSFER-TO-ikamet-os-core/pay-link/app-web/*` into `app-web` following the folder structure. Merge with existing checkout: read checkout route first, pass `ref` query or cookie into payment API. Do not break existing Stripe/payment flow.

Or manually:

```bash
cd ~/Documents/GitHub
# adjust paths if your checkout lives elsewhere
cp -r web-analytics/TRANSFER-TO-ikamet-os-core/pay-link/app-web/app/pay app-web/app/
cp -r web-analytics/TRANSFER-TO-ikamet-os-core/pay-link/app-web/app/invite app-web/app/
cp web-analytics/TRANSFER-TO-ikamet-os-core/pay-link/app-web/lib/referral.ts app-web/lib/
```

Then in `app-web`:

1. Set `NEXT_PUBLIC_CHECKOUT_PATH` in `.env` (e.g. `/checkout` or your real path).
2. In checkout/payment code, read `ikamet_ref` cookie (or `?ref=` query) and send to `app-api`.
3. Deploy `app-web`.

## app-api (follow-up)

When creating a payment session, include `referral_slug` from cookie so ops can attribute revenue.

Example body field: `{ "referral_slug": "christophera7" }`

## Examples

- `https://app.ikamet.com/pay/christophera7`
- `https://app.ikamet.com/pay/innogo`
- `https://app.ikamet.com/invite/christophera7`
