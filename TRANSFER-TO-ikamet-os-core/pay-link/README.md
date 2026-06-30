# Branded redirect → Wise invite link

**Not a payment system.** One URL under your brand that sends people to your Wise referral link.

| Your link | Goes to |
|-----------|---------|
| `https://app.ikamet.com/pay/christophera7` | `https://wise.com/invite/dic/christophera7` |

## Fastest: add to `app-web/next.config.js`

Open `app-web/next.config.js` and add inside `module.exports` (merge with existing `redirects` if you already have one):

```js
async redirects() {
  return [
    {
      source: '/pay/christophera7',
      destination: 'https://wise.com/invite/dic/christophera7',
      permanent: false,
    },
  ]
},
```

Deploy `app-web`. Done.

## Alternative: `vercel.json` in app-web root

```json
{
  "redirects": [
    {
      "source": "/pay/christophera7",
      "destination": "https://wise.com/invite/dic/christophera7",
      "permanent": false
    }
  ]
}
```

## Paste into local Cursor (app-web)

> Add a single redirect: `/pay/christophera7` → `https://wise.com/invite/dic/christophera7` in next.config.js (or vercel.json). Nothing else — no cookies, no checkout, no API changes. Deploy app-web.

## More slugs later

Duplicate the redirect block with a new `source` and `destination` for each person. No code beyond that unless you want many links.
