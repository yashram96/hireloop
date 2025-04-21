<template>
  <div class="space-y-4">
    <div v-for="integration in integrations" :key="integration.provider" 
         class="flex items-center justify-between p-4 border border-gray-200 dark:border-gray-700 rounded-lg">
      <div class="flex items-center space-x-3">
        <component :is="integration.icon" 
                  :class="[
                    'w-6 h-6',
                    isConnected(integration.provider) ? 'text-green-500' : 'text-gray-700 dark:text-gray-300'
                  ]" />
        <div>
          <span class="font-medium text-gray-900 dark:text-white">{{ integration.name }}</span>
          <span v-if="isConnected(integration.provider)" 
                class="ml-2 text-sm text-green-600 dark:text-green-400">
            Connected
          </span>
        </div>
      </div>
      <button 
        @click="handleIntegration(integration)"
        :class="[
          'px-4 py-2 rounded-lg text-sm font-medium transition-colors',
          isConnected(integration.provider)
            ? 'text-red-600 hover:text-red-700 border border-red-200 hover:bg-red-50 dark:border-red-800 dark:hover:bg-red-900/20'
            : 'border border-gray-300 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-700'
        ]"
      >
        {{ isConnected(integration.provider) ? 'Disconnect' : 'Connect' }}
      </button>
    </div>
    
    <!-- Confirmation Modal -->
    <div v-if="showConfirmation" class="fixed inset-0 z-50 overflow-y-auto">
      <div class="flex items-center justify-center min-h-screen px-4 pt-4 pb-20 text-center">
        <div class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75" @click="showConfirmation = false"></div>
        <div class="relative inline-block p-6 overflow-hidden text-left align-bottom transition-all transform bg-white dark:bg-gray-800 rounded-lg shadow-xl">
          <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-4">
            Disconnect {{ selectedIntegration?.name }}?
          </h3>
          <p class="text-gray-600 dark:text-gray-400 mb-6">
            Are you sure you want to disconnect your {{ selectedIntegration?.name }} account? 
            This will remove access to your {{ selectedIntegration?.name }} data.
          </p>
          <div class="flex justify-end space-x-3">
            <button
              @click="showConfirmation = false"
              class="px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-lg"
            >
              Cancel
            </button>
            <button
              @click="confirmDisconnect"
              class="px-4 py-2 text-sm font-medium text-white bg-red-600 hover:bg-red-700 rounded-lg"
            >
              Disconnect
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { 
  BriefcaseIcon,
  XMarkIcon,
  GlobeAltIcon,
  BuildingOfficeIcon
} from '@heroicons/vue/24/outline'

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const connections = ref([])
const showConfirmation = ref(false)
const selectedProvider = ref(null)
const selectedIntegration = computed(() => 
  integrations.find(i => i.provider === selectedProvider.value)
)

const integrations = [
  { 
    name: 'LinkedIn',
    provider: 'linkedin', 
    icon: BriefcaseIcon,
    description: 'Import your professional profile and network'
  },
  {
    name: 'Indeed',
    provider: 'indeed',
    icon: GlobeAltIcon,
    description: 'Access millions of job listings'
  },
  {
    name: 'Naukri',
    provider: 'naukri',
    icon: BuildingOfficeIcon,
    description: 'Connect with top employers in India'
  }
]

// Fetch user's OAuth connections
const fetchConnections = async () => {
  const { data } = await supabase
    .from('oauth_connections')
    .select('provider')
    .eq('user_id', user.value.id)
  
  connections.value = data || []
}

// Check if a provider is connected
const isConnected = (provider) => {
  return connections.value.some(conn => conn.provider === provider)
}

// Handle connect/disconnect
const handleIntegration = (integration) => {
  if (isConnected(integration.provider)) {
    selectedProvider.value = integration.provider
    showConfirmation.value = true
  } else {
    connectProvider(integration.provider)
  }
}

// Connect to provider
const connectProvider = (provider) => {
  // This would typically redirect to OAuth flow
  console.log(`Connecting to ${provider}...`)
}

// Confirm disconnection
const confirmDisconnect = async () => {
  if (!selectedProvider.value) return
  
  const { error } = await supabase
    .from('oauth_connections')
    .delete()
    .eq('user_id', user.value.id)
    .eq('provider', selectedProvider.value)
  
  if (!error) {
    await fetchConnections()
  }
  
  showConfirmation.value = false
  selectedProvider.value = null
}

onMounted(() => {
  fetchConnections()
})
</script>