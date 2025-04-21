<template>
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
        @click="$emit('toggle')"
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
        @click="$emit('delete')"
        class="p-2 text-gray-400 hover:text-red-500 dark:text-gray-500 dark:hover:text-red-400"
      >
        <TrashIcon class="w-5 h-5" />
      </button>
    </div>
  </div>
</template>

<script setup>
import { MapPinIcon, BuildingOfficeIcon, TrashIcon } from '@heroicons/vue/24/outline'

defineProps({
  campaign: {
    type: Object,
    default: null
  }
})

defineEmits(['toggle', 'delete'])
</script>