<template>
  <div class="bg-white dark:bg-gray-900 rounded-xl p-6 shadow-md hover:shadow-lg transition-shadow border border-gray-100 dark:border-gray-700 relative">
    <div class="absolute -top-4 -left-4 w-10 h-10 rounded-full flex items-center justify-center"
         :class="`bg-${color}-600 text-white font-bold text-lg shadow-md`">
      {{ number }}
    </div>
    
    <div class="mb-4 h-14 flex items-center justify-center">
      <component :is="icon" 
                class="w-12 h-12" 
                :class="`text-${color}-500`" />
    </div>
    
    <h3 class="text-xl font-semibold mb-3 text-gray-900 dark:text-white">{{ title }}</h3>
    <p class="text-gray-600 dark:text-gray-300">{{ description }}</p>
  </div>
</template>

<script setup>
import { 
  DocumentTextIcon, 
  RocketLaunchIcon, 
  PhoneIcon 
} from '@heroicons/vue/24/outline';

defineProps({
  number: {
    type: String,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  icon: {
    type: String,
    required: true
  },
  color: {
    type: String,
    default: 'primary'
  }
});
</script>