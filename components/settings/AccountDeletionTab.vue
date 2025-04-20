<template>
  <div>
    <p class="text-gray-600 dark:text-gray-400 mb-4">
      Once you delete your account, there is no going back. Please be certain.
    </p>
    <button 
      @click="confirmDelete"
      :disabled="loading"
      class="px-4 py-2 bg-red-600 text-white rounded-lg text-sm font-medium hover:bg-red-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
    >
      {{ loading ? 'Deleting...' : 'Delete Account' }}
    </button>
  </div>
</template>

<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()
const router = useRouter()
const loading = ref(false)
const error = ref(null)

const confirmDelete = async () => {
  if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
    try {
      loading.value = true
      error.value = null

      // Call the server-side delete endpoint
      const response = await fetch('/api/delete-user', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      })

      if (!response.ok) {
        const data = await response.json()
        throw new Error(data.message || 'Failed to delete account')
      }
      
      // Sign out after successful deletion
      await supabase.auth.signOut() 
      router.push('/auth/login')
    } catch (err) {
      error.value = err.message
      console.error('Error deleting account:', err) 
    } finally {
      loading.value = false
    }
  }
}
</script>