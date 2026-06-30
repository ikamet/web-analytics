import { cookies } from 'next/headers'
import { notFound, redirect } from 'next/navigation'
import {
  getCheckoutPath,
  normalizeReferralSlug,
  referralCookieOptions,
  REFERRAL_COOKIE,
} from '@/lib/referral'

type Props = { params: Promise<{ slug: string }> }

/** Wise-style invite link — same attribution as /pay/[slug] */
export default async function InviteLinkPage({ params }: Props) {
  const { slug: raw } = await params
  const slug = normalizeReferralSlug(raw)
  if (!slug) notFound()

  const jar = await cookies()
  jar.set(REFERRAL_COOKIE, slug, referralCookieOptions())

  redirect(getCheckoutPath(slug))
}
