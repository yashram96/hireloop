<template>
  <div class="space-y-4">
    <div v-for="integration in integrations" :key="integration.name" 
         class="flex items-center justify-between p-4 border border-gray-200 dark:border-gray-700 rounded-lg">
      <div class="flex items-center space-x-3">
        <component :is="integration.icon" class="w-6 h-6 text-gray-700 dark:text-gray-300" />
        <span class="font-medium text-gray-900 dark:text-white">{{ integration.name }}</span>
      </div>
      <button 
        class="px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
      >
        Connect
      </button>
    </div>
  </div>
</template>

<script setup>
import { 
  BriefcaseIcon,
  GlobeAltIcon,
  BuildingOfficeIcon
} from '@heroicons/vue/24/outline'

const integrations = [
  { name: 'LinkedIn', icon: BriefcaseIcon },
  { name: 'Indeed', icon: GlobeAltIcon },
  { name: 'Naukri', icon: BuildingOfficeIcon }
]
</script>