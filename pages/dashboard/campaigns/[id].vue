<template>
  <div class="max-w-6xl mx-auto">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">
          {{ campaign?.title }}
        </h1>
        <div class="flex items-center text-sm text-gray-600 dark:text-gray-400">
          <MapPinIcon class="w-4 h-4 mr-1" />
          {{ campaign?.location || 'No location specified' }}
          <span class="mx-2">•</span>
          <BuildingOfficeIcon class="w-4 h-4 mr-1" />
          {{ campaign?.industry || 'No industry specified' }}
        </div>
      </div>
      
      <div class="flex items-center gap-4">
        <button
          @click="toggleCampaign"
          :class="[
            'px-4 py-2 rounded-lg text-sm font-medium',
            campaign?.is_active
              ? 'bg-red-50 text-red-700 hover:bg-red-100 dark:bg-red-900/20 dark:text-red-400'
              : 'bg-green-50 text-green-700 hover:bg-green-100 dark:bg-green-900/20 dark:text-green-400'
          ]"
        >
          {{ campaign?.is_active ? 'Pause Campaign' : 'Resume Campaign' }}
        </button>
        <button
          @click="deleteCampaign"
          class="p-2 text-gray-400 hover:text-red-500 dark:text-gray-500 dark:hover:text-red-400"
        >
          <TrashIcon class="w-5 h-5" />
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
      <div class="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
        <div class="flex items-center justify-between">
          <h3 class="text-sm font-medium text-gray-500 dark:text-gray-400">Total Applications</h3>
          <DocumentDuplicateIcon class="w-5 h-5 text-primary-500" />
        </div>
        <p class="mt-2 text-3xl font-semibold text-gray-900 dark:text-white">
          {{ campaign?.total_applications || 0 }}
        </p>
      </div>
      
      <div class="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
        <div class="flex items-center justify-between">
          <h3 class="text-sm font-medium text-gray-500 dark:text-gray-400">Replies Received</h3>
          <ChatBubbleLeftIcon class="w-5 h-5 text-secondary-500" />
        </div>
        <p class="mt-2 text-3xl font-semibold text-gray-900 dark:text-white">
          {{ campaign?.reply_count || 0 }}
        </p>
      </div>
      
      <div class="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
        <div class="flex items-center justify-between">
          <h3 class="text-sm font-medium text-gray-500 dark:text-gray-400">Success Rate</h3>
          <ChartBarIcon class="w-5 h-5 text-green-500" />
        </div>
        <p class="mt-2 text-3xl font-semibold text-gray-900 dark:text-white">
          {{ campaign?.success_rate || 0 }}%
        </p>
      </div>
    </div>

    <!-- Tabs -->
    <div class="mb-6 border-b border-gray-200 dark:border-gray-700">
      <nav class="-mb-px flex space-x-8">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="[
            activeTab === tab.id
              ? 'border-primary-500 text-primary-600'
              : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
            'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm'
          ]"
        >
          {{ tab.name }}
        </button>
      </nav>
    </div>

    <!-- Tab Panels -->
    <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
      <!-- Preferences Tab -->
      <div v-if="activeTab === 'preferences'" class="p-6">
        <form @submit.prevent="updatePreferences" class="space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                Job Title/Role
              </label>
              <input
                v-model="form.title"
                type="text"
                required
                class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
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
              />
            </div>
          </div>

          <div class="flex justify-end">
            <button
              type="submit"
              :disabled="loading"
              class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50"
            >
              Save Changes
            </button>
          </div>
        </form>
      </div>

      <!-- Applications Tab -->
      <div v-if="activeTab === 'applications'" class="p-6">
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
            <thead>
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                  Company
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                  Position
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                  Applied
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                  Status
                </th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
              <tr v-if="applications.length === 0">
                <td colspan="4" class="px-6 py-4 text-center text-gray-500 dark:text-gray-400">
                  No applications yet
                </td>
              </tr>
              <tr v-for="app in applications" :key="app.id" class="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                  {{ app.company }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                  {{ app.position }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">
                  {{ new Date(app.applied_at).toLocaleDateString() }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <span :class="[
                    'px-2 py-1 text-xs font-medium rounded-full',
                    app.status === 'replied' ? 'bg-green-100 text-green-800 dark:bg-green-900/20 dark:text-green-400' :
                    app.status === 'pending' ? 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/20 dark:text-yellow-400' :
                    'bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300'
                  ]">
                    {{ app.status }}
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- AI Instructions Tab -->
      <div v-if="activeTab === 'ai'" class="p-6">
        <form @submit.prevent="updateAIInstructions" class="space-y-6">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Custom Instructions for AI
            </label>
            <textarea
              v-model="form.ai_instructions"
              rows="6"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
              placeholder="e.g., Focus on Python-heavy roles, avoid startups, prefer remote positions..."
            ></textarea>
          </div>

          <div class="flex justify-end">
            <button
              type="submit"
              :disabled="loading"
              class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50"
            >
              Save Changes
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { 
  MapPinIcon, 
  BuildingOfficeIcon,
  TrashIcon,
  DocumentDuplicateIcon,
  ChatBubbleLeftIcon,
  ChartBarIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  middleware: 'auth',
  layout: 'dashboard'
})

const route = useRoute()
const router = useRouter()
const supabase = useSupabaseClient()
const user = useSupabaseUser()

const campaign = ref(null)
const loading = ref(false)
const error = ref(null)
const activeTab = ref('preferences')

const tabs = [
  { id: 'preferences', name: 'Preferences' },
  { id: 'applications', name: 'Applications' },
  { id: 'ai', name: 'AI Instructions' }
]

// Form state
const form = ref({
  title: '',
  location: '',
  industry: '',
  keywords: [],
  ai_instructions: ''
})

const keywordsInput = ref('')
const applications = ref([]) // This would be populated from your applications table

// Watch keywords input and update form.keywords array
watch(keywordsInput, (newValue) => {
  form.value.keywords = newValue.split(',')
    .map(keyword => keyword.trim())
    .filter(keyword => keyword.length > 0)
})

// Fetch campaign data
const fetchCampaign = async () => {
  try {
    const { data, error: err } = await supabase
      .from('campaigns')
      .select('*')
      .eq('id', route.params.id)
      .single()

    if (err) throw err
    
    campaign.value = data
    form.value = {
      title: data.title,
      location: data.location,
      industry: data.industry,
      keywords: data.keywords || [],
      ai_instructions: data.ai_instructions
    }
    keywordsInput.value = data.keywords?.join(', ') || ''
  } catch (err) {
    error.value = err.message
    console.error('Error fetching campaign:', err)
  }
}

// Update campaign preferences
const updatePreferences = async () => {
  try {
    loading.value = true
    error.value = null

    const { error: err } = await supabase
      .from('campaigns')
      .update({
        title: form.value.title,
        location: form.value.location,
        industry: form.value.industry,
        keywords: form.value.keywords
      })
      .eq('id', route.params.id)

    if (err) throw err
    
    await fetchCampaign()
  } catch (err) {
    error.value = err.message
  } finally {
    loading.value = false
  }
}

// Update AI instructions
const updateAIInstructions = async () => {
  try {
    loading.value = true
    error.value = null

    const { error: err } = await supabase
      .from('campaigns')
      .update({
        ai_instructions: form.value.ai_instructions
      })
      .eq('id', route.params.id)

    if (err) throw err
  } catch (err) {
    error.value = err.message
  } finally {
    loading.value = false
  }
}

// Toggle campaign active status
const toggleCampaign = async () => {
  try {
    loading.value = true
    error.value = null

    const { error: err } = await supabase
      .from('campaigns')
      .update({
        is_active: !campaign.value.is_active
      })
      .eq('id', route.params.id)

    if (err) throw err
    
    await fetchCampaign()
  } catch (err) {
    error.value = err.message
  } finally {
    loading.value = false
  }
}

// Delete campaign
const deleteCampaign = async () => {
  if (!confirm('Are you sure you want to delete this campaign? This action cannot be undone.')) {
    return
  }

  try {
    loading.value = true
    error.value = null

    const { error: err } = await supabase
      .from('campaigns')
      .delete()
      .eq('id', route.params.id)

    if (err) throw err
    
    router.push('/dashboard/campaigns')
  } catch (err) {
    error.value = err.message
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchCampaign()
})
</script>