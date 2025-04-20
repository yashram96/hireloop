<template>
  <div class="min-h-screen bg-gray-50 dark:bg-gray-900">
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-4">Dashboard</h1>
      <button 
        @click="handleLogout" 
        class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg"
        :disabled="loading"
      >
        {{ loading ? 'Signing out...' : 'Sign out' }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { useSupabaseClient } from '#imports'

definePageMeta({
  middleware: 'auth'
})

const loading = ref(false)
const supabase = useSupabaseClient()

const handleLogout = async () => {
  loading.value = true
  try {
    await supabase.auth.signOut()
    navigateTo('/auth/login')
  } finally {
    loading.value = false
  }
}
</script>