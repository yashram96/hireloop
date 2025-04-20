<template>
  <div class="min-h-screen bg-gray-50 dark:bg-gray-900 flex relative">
    <!-- Sidebar -->
    <aside class="fixed inset-y-0 left-0 w-64 bg-white dark:bg-gray-800 border-r border-gray-200 dark:border-gray-700 z-30">
      <div class="flex flex-col h-full">
        <!-- Logo -->
        <div class="p-4 border-b border-gray-200 dark:border-gray-700">
          <NuxtLink to="/" class="text-2xl font-bold">
            <span class="text-primary-600">Hire</span><span class="text-secondary-600">Loop</span>
          </NuxtLink>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 p-4 space-y-1">
          <NuxtLink
            v-for="item in navigation"
            :key="item.path"
            :to="item.path"
            :class="[
              'flex items-center px-3 py-2 rounded-lg text-sm font-medium transition-colors',
              $route.path === item.path
                ? 'bg-primary-50 dark:bg-primary-900/20 text-primary-600 dark:text-primary-400'
                : 'text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700'
            ]"
          >
            <component :is="item.icon" class="w-5 h-5 mr-3" />
            {{ item.name }}
          </NuxtLink>
        </nav>

        <!-- User Menu -->
        <div class="p-4 border-t border-gray-200 dark:border-gray-700">
          <button
            @click="handleLogout"
            class="flex items-center w-full px-3 py-2 text-sm font-medium text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors"
          >
            <ArrowLeftOnRectangleIcon class="w-5 h-5 mr-3" />
            Sign out
          </button>
        </div>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 pl-64">
      <div class="p-8 w-full">
        <slot />
      </div>
    </main>
  </div>
</template>

<script setup>
import {
  HomeIcon,
  BriefcaseIcon,
  AcademicCapIcon,
  RectangleStackIcon,
  GlobeAltIcon,
  Cog6ToothIcon,
  ArrowLeftOnRectangleIcon
} from '@heroicons/vue/24/outline'

const supabase = useSupabaseClient()
const router = useRouter()

const navigation = [
  { name: 'Welcome', icon: HomeIcon, path: '/dashboard' },
  { name: 'Job Feed', icon: BriefcaseIcon, path: '/dashboard/job-feed' },
  { name: 'Campaigns', icon: RectangleStackIcon, path: '/dashboard/campaigns' },
  { name: 'Career Info', icon: AcademicCapIcon, path: '/dashboard/career-info/' },
  { name: 'Job Portals', icon: GlobeAltIcon, path: '/dashboard/portals' },
  { name: 'Settings', icon: Cog6ToothIcon, path: '/dashboard/settings' },
]

const handleLogout = async () => {
  await supabase.auth.signOut()
  router.push('/auth/login')
}
</script>