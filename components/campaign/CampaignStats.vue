<template>
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
</template>

<script setup>
import { DocumentDuplicateIcon, ChatBubbleLeftIcon, ChartBarIcon } from '@heroicons/vue/24/outline'

defineProps({
  campaign: {
    type: Object,
    default: null
  }
})
</script>