import { serverSupabaseServiceRole } from '#supabase/server'
import { H3Event } from 'h3'

export default defineEventHandler(async (event: H3Event) => {
  try {
    // Get the user ID from the session cookie
    const config = useRuntimeConfig()
    const cookieName = `sb-${config.public.supabase.cookies.name ?? ''}`
    const cookie = getCookie(event, cookieName)
    
    if (!cookie) {
      throw createError({
        statusCode: 401,
        message: 'Unauthorized'
      })
    }

    const adminClient = await serverSupabaseServiceRole(event)
    
    // Parse the JWT to get the user ID
    const jwt = JSON.parse(Buffer.from(cookie.split('.')[1], 'base64').toString())
    const userId = jwt.sub

    if (!userId) {
      throw createError({
        statusCode: 401,
        message: 'Invalid session'
      })
    }

    // Delete user profile first
    const { error: profileError } = await adminClient
      .from('profiles')
      .delete()
      .eq('id', userId)

    if (profileError) throw profileError

    // Delete the auth user using admin privileges
    const { error: authError } = await adminClient.auth.admin
      .deleteUser(userId)

    if (authError) throw authError

    return { success: true }
  } catch (error: any) {
    throw createError({
      statusCode: error.status || 500,
      message: error.message || 'Internal server error'
    })
  }
})