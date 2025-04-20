<template>
  <div class="max-w-3xl mx-auto">
    <div class="mb-8">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">
        Create New Campaign
      </h1>
      <p class="text-gray-600 dark:text-gray-400">
        Set up your automated job search campaign
      </p>
    </div>

    <form @submit.prevent="createCampaign" class="space-y-8">
      <!-- Basic Info -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700 p-6">
        <h2 class="text-lg font-medium text-gray-900 dark:text-white mb-4">Basic Information</h2>
        
        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Job Title/Role
            </label>
            <input
              v-model="form.title"
              type="text"
              required
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
              placeholder="e.g., Senior Software Engineer"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Location
            </label>
            <input
              v-model="form.location"
              type="text"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
              placeholder="e.g., Remote, New York, London"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Industry
            </label>
            <input
              v-model="form.industry"
              type="text"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
              placeholder="e.g., Technology, Finance, Healthcare"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Keywords (comma-separated)
            </label>
            <input
              v-model="keywordsInput"
              type="text"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
              placeholder="e.g., React, Node.js, TypeScript"
            />
          </div>
        </div>
      </div>

      <!-- AI Instructions -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700 p-6">
        <h2 class="text-lg font-medium text-gray-900 dark:text-white mb-4">AI Instructions</h2>
        
        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Custom Instructions for AI
            </label>
            <textarea
              v-model="form.ai_instructions"
              rows="4"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
              placeholder="e.g., Focus on Python-heavy roles, avoid startups, prefer remote positions..."
            ></textarea>
          </div>
        </div>
      </div>

      <div v-if="error" class="bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 p-4 rounded-lg text-sm">
        {{ error }}
      </div>

      <div class="flex justify-end space-x-4">
        <NuxtLink
          to="/dashboard/campaigns"
          class="px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700"
        >
          Cancel
        </NuxtLink>
        <button
          type="submit"
          :disabled="loading"
          class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50"
        >
          {{ loading ? 'Creating...' : 'Create Campaign' }}
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()
const router = useRouter()

const form = ref({
  title: '',
  location: '',
  industry: '',
  keywords: [],
  ai_instructions: '',
})

const keywordsInput = ref('')
const loading = ref(false)
const error = ref(null)

// Watch keywords input and update form.keywords array
watch(keywordsInput, (newValue) => {
  form.value.keywords = newValue.split(',')
    .map(keyword => keyword.trim())
    .filter(keyword => keyword.length > 0)
})

const createCampaign = async () => {
  try {
    loading.value = true
    error.value = null

    const { error: err } = await supabase
      .from('campaigns')
      .insert([{
        ...form.value,
        user_id: user.value.id
      }])

    if (err) throw err

    // Redirect to campaigns list
    router.push('/dashboard/campaigns')
  } catch (err) {
    error.value = err.message
    console.error('Error creating campaign:', err)
  } finally {
    loading.value = false
  }
}

definePageMeta({
  middleware: 'auth',
  layout: 'dashboard'
})</script>