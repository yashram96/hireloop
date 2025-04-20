<template>
  <form @submit.prevent="updateProfile" class="space-y-6">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
          First Name
        </label>
        <input
          v-model="form.first_name"
          type="text"
          class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
        />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
          Last Name
        </label>
        <input
          v-model="form.last_name"
          type="text"
          class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
        />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
          Email
        </label>
        <input
          :value="user?.email"
          disabled
          class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm bg-gray-50 dark:bg-gray-600 cursor-not-allowed"
        />
      </div>
    </div>

    <div v-if="error" class="text-sm text-red-600 dark:text-red-400">
      {{ error }}
    </div>

    <div class="flex justify-end">
      <button
        type="submit"
        :disabled="loading"
        class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50"
      >
        <template v-if="loading">
          Saving...
        </template>
        <template v-else>
          Save Changes
        </template>
      </button>
    </div>
  </form>
</template>

<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()

const form = ref({
  first_name: '',
  last_name: ''
})
const loading = ref(false)
const error = ref(null)

// Fetch current profile
const fetchProfile = async () => {
  const { data } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.value.id)
    .single()
  
  if (data) {
    form.value = {
      first_name: data.first_name || '',
      last_name: data.last_name || ''
    }
  }
}

// Update profile
const updateProfile = async () => {
  try {
    loading.value = true
    error.value = null

    const { error: err } = await supabase
      .from('profiles')
      .update(form.value)
      .eq('id', user.value.id)

    if (err) throw err
  } catch (err) {
    error.value = err.message
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchProfile()
})
</script>