// Optional: pass referral_slug when creating a payment session (app-api)
// Merge into your existing payment handler — do not replace wholesale.

export function referralSlugFromRequest(req: {
  cookies?: { get?: (name: string) => { value: string } | undefined }
  body?: { referral_slug?: string; ref?: string }
}): string | null {
  const fromBody = req.body?.referral_slug || req.body?.ref
  if (fromBody && typeof fromBody === 'string') return fromBody.trim().toLowerCase()
  const fromCookie = req.cookies?.get?.('ikamet_ref')?.value
  return fromCookie?.trim().toLowerCase() || null
}

// Example when calling Stripe/etc.:
// const referral_slug = referralSlugFromRequest(req)
// metadata: { referral_slug: referral_slug ?? '' }
