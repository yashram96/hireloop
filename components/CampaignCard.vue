<template>
  <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700 hover:shadow-md transition-all">
    <div class="p-4 flex items-center justify-between">
      <div class="flex-1">
        <div class="flex items-center justify-between mb-2">
          <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
            {{ campaign.title }}
          </h3>
          <span :class="[
            'px-2 py-1 text-xs font-medium rounded-full',
            campaign.is_active 
              ? 'bg-green-100 text-green-800 dark:bg-green-900/20 dark:text-green-400'
              : 'bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300'
          ]">
            {{ campaign.is_active ? 'Active' : 'Paused' }}
          </span>
        </div>
        
        <div class="flex items-center text-sm text-gray-600 dark:text-gray-400 mb-2">
          <MapPinIcon class="w-4 h-4 mr-1" />
          {{ campaign.location || 'No location specified' }}
          <span class="mx-2">•</span>
          <BuildingOfficeIcon class="w-4 h-4 mr-1" />
          {{ campaign.industry || 'No industry specified' }}
        </div>

        <div class="flex flex-wrap gap-2">
          <span v-for="keyword in campaign.keywords" :key="keyword"
                class="px-2 py-1 text-xs font-medium bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-300 rounded-full">
            {{ keyword }}
          </span>
        </div>
      </div>

      <div class="flex items-center gap-8 ml-4">
        <div class="text-center">
          <p class="text-2xl font-semibold text-gray-900 dark:text-white">
            {{ campaign.total_applications }}
          </p>
          <p class="text-sm text-gray-600 dark:text-gray-400">Applications</p>
        </div>
        <div class="text-center">
          <p class="text-2xl font-semibold text-gray-900 dark:text-white">
            {{ campaign.reply_count }}
          </p>
          <p class="text-sm text-gray-600 dark:text-gray-400">Replies</p>
        </div>
        <div class="text-center">
          <p class="text-2xl font-semibold text-gray-900 dark:text-white">
            {{ campaign.success_rate }}%
          </p>
          <p class="text-sm text-gray-600 dark:text-gray-400">Success</p>
        </div>
        
        <NuxtLink 
          :to="`/dashboard/campaigns/${campaign.id}`"
          class="ml-4 p-2 text-gray-400 hover:text-gray-500 dark:text-gray-500 dark:hover:text-gray-400"
        >
          <ChevronRightIcon class="w-6 h-6" />
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup>
import { MapPinIcon, BuildingOfficeIcon, ChevronRightIcon } from '@heroicons/vue/24/outline'

defineProps({
  campaign: {
    type: Object,
    required: true
  }
})
</script>