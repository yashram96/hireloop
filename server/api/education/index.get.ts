import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  try {
    const client = await serverSupabaseClient(event)
    const { data, error } = await client
      .from('education')
      .select('*')
      .order('start_date', { ascending: false })

    if (error) throw error
    return data
  } catch (error: any) {
    throw createError({
      statusCode: error.status || 500,
      message: error.message || 'Failed to fetch education entries'
    })
  }
})