<template>
  <div class="max-w-4xl">
   <ClientOnly>
  <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-6">
    Welcome back, {{ profile?.first_name || 'there' }}! 👋
  </h1>
</ClientOnly>


    <!-- Stats Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div v-for="stat in stats" :key="stat.name" 
             class="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border border-gray-100 dark:border-gray-700">
          <div class="flex items-center">
            <component :is="stat.icon" 
                      :class="['w-8 h-8', stat.iconColor]" />
          </div>
          <p class="mt-4 text-2xl font-semibold text-gray-900 dark:text-white">
            {{ stat.value }}
          </p>
          <p class="text-gray-600 dark:text-gray-400 text-sm">
            {{ stat.name }}
          </p>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <NuxtLink to="/dashboard/campaigns/new" 
                 class="flex items-center justify-between p-6 bg-primary-50 dark:bg-primary-900/20 rounded-xl border border-primary-100 dark:border-primary-800 group hover:bg-primary-100 dark:hover:bg-primary-900/40 transition-colors">
          <div>
            <h3 class="text-lg font-semibold text-primary-900 dark:text-primary-100 mb-2">
              Start New Campaign
            </h3>
            <p class="text-primary-700 dark:text-primary-300 text-sm">
              Create a targeted job search campaign
            </p>
          </div>
          <PlusCircleIcon class="w-8 h-8 text-primary-500 group-hover:text-primary-600 transition-colors" />
        </NuxtLink>

        <NuxtLink to="/dashboard/settings" 
                 class="flex items-center justify-between p-6 bg-secondary-50 dark:bg-secondary-900/20 rounded-xl border border-secondary-100 dark:border-secondary-800 group hover:bg-secondary-100 dark:hover:bg-secondary-900/40 transition-colors">
          <div>
            <h3 class="text-lg font-semibold text-secondary-900 dark:text-secondary-100 mb-2">
              Improve Resume
            </h3>
            <p class="text-secondary-700 dark:text-secondary-300 text-sm">
              Optimize your resume for better results
            </p>
          </div>
          <DocumentIcon class="w-8 h-8 text-secondary-500 group-hover:text-secondary-600 transition-colors" />
        </NuxtLink>
      </div>
    </div>
</template>

<script setup>
import { 
  RectangleStackIcon, 
  BriefcaseIcon, 
  ChartBarIcon, 
  ClockIcon,
  PlusCircleIcon,
  DocumentIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  middleware: 'auth',
  layout: 'dashboard'
})

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const profile = ref(null)

// Fetch user profile
const fetchProfile = async () => {
  const { data } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.value.id)
    .single()
  
  profile.value = data
}

// Mock stats data (to be replaced with real data)
const stats = [
  {
    name: 'Active Campaigns',
    value: '3',
    icon: RectangleStackIcon,
    iconColor: 'text-primary-500'
  },
  {
    name: 'Jobs Applied',
    value: '24',
    icon: BriefcaseIcon,
    iconColor: 'text-secondary-500'
  },
  {
    name: 'Success Rate',
    value: '18%',
    icon: ChartBarIcon,
    iconColor: 'text-green-500'
  },
  {
    name: 'This Week',
    value: '8',
    icon: ClockIcon,
    iconColor: 'text-purple-500'
  }
]

onMounted(() => {
  fetchProfile()
})
</script>