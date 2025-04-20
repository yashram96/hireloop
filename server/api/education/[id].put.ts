import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  try {
    const body = await readBody(event)
    const id = event.context.params?.id
    const client = await serverSupabaseClient(event)

    const { data, error } = await client
      .from('education')
      .update(body)
      .eq('id', id)
      .select()
      .single()

    if (error) throw error

    return data
  } catch (error: any) {
    throw createError({
      statusCode: error.status || 500,
      message: error.message || 'Failed to update education entry'
    })
  }
})