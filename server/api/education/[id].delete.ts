import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  try {
    const id = event.context.params?.id
    const client = await serverSupabaseClient(event)

    const { error } = await client
      .from('education')
      .delete()
      .eq('id', id)

    if (error) throw error
    return { success: true }
  } catch (error: any) {
    throw createError({
      statusCode: error.status || 500,
      message: error.message || 'Failed to delete education entry'
    })
  }
})