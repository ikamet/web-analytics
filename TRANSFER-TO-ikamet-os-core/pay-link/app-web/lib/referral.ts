/** Cookie / query helpers for pay & invite links (app.ikamet.com/pay/[slug]) */

export const REFERRAL_COOKIE = 'ikamet_ref'
export const REFERRAL_COOKIE_MAX_AGE = 60 * 60 * 24 * 90 // 90 days

const SLUG_PATTERN = /^[a-z0-9][a-z0-9_-]{1,62}[a-z0-9]$/i

export function normalizeReferralSlug(raw: string): string | null {
  const slug = raw.trim().toLowerCase()
  if (!slug || slug.length < 3 || slug.length > 64) return null
  if (!SLUG_PATTERN.test(slug)) return null
  return slug
}

export function referralCookieOptions(maxAge = REFERRAL_COOKIE_MAX_AGE) {
  return {
    name: REFERRAL_COOKIE,
    maxAge,
    path: '/',
    sameSite: 'lax' as const,
    secure: process.env.NODE_ENV === 'production',
    httpOnly: false,
  }
}

/** Where to send users after /pay or /invite (override in .env) */
export function getCheckoutPath(slug: string): string {
  const base = process.env.NEXT_PUBLIC_CHECKOUT_PATH?.trim() || '/checkout'
  const sep = base.includes('?') ? '&' : '?'
  return `${base}${sep}ref=${encodeURIComponent(slug)}`
}
