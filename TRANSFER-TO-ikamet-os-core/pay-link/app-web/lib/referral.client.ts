/** Use in checkout UI to read referral slug in the browser */

import { REFERRAL_COOKIE } from './referral'

export function getReferralSlugFromCookie(): string | null {
  if (typeof document === 'undefined') return null
  const match = document.cookie.match(
    new RegExp(`(?:^|; )${REFERRAL_COOKIE}=([^;]*)`)
  )
  return match ? decodeURIComponent(match[1]) : null
}
