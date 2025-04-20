<template>
  <div class="max-w-6xl mx-auto">
    <div class="flex justify-between items-center mb-8">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">
          Campaigns
        </h1>
        <p class="text-gray-600 dark:text-gray-400">
          Create and manage your automated job search campaigns
        </p>
      </div>
      <NuxtLink
        to="/dashboard/campaigns/new"
        class="inline-flex items-center px-4 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
      >
        <PlusIcon class="h-5 w-5 mr-2" />
        New Campaign
      </NuxtLink>
    </div>

    <!-- Campaign List -->
    <div v-if="campaigns.length > 0" class="space-y-4">
      <CampaignCard 
        v-for="campaign in campaigns" 
        :key="campaign.id" 
        :campaign="campaign" 
      />
    </div>

    <!-- Empty State -->
    <div v-else class="text-center py-12">
      <RectangleStackIcon class="mx-auto h-12 w-12 text-gray-400" />
      <h3 class="mt-2 text-sm font-medium text-gray-900 dark:text-white">No campaigns</h3>
      <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
        Get started by creating a new campaign.
      </p>
      <div class="mt-6">
        <NuxtLink
          to="/dashboard/campaigns/new"
          class="inline-flex items-center px-4 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700"
        >
          <PlusIcon class="h-5 w-5 mr-2" />
          New Campaign
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup>
import { PlusIcon, RectangleStackIcon } from '@heroicons/vue/24/outline'

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const campaigns = ref([])
const loading = ref(true)
const error = ref(null)

// Fetch user's campaigns
const fetchCampaigns = async () => {
  try {
    loading.value = true
    error.value = null

    const { data, error: err } = await supabase
      .from('campaigns')
      .select('*')
      .eq('user_id', user.value.id)
      .order('created_at', { ascending: false })

    if (err) throw err
    campaigns.value = data
  } catch (err) {
    error.value = err.message
    console.error('Error fetching campaigns:', err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchCampaigns()
})

definePageMeta({
  middleware: 'auth',
  layout: 'dashboard'
})
</script>