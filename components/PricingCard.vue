<template>
  <div class="rounded-xl overflow-hidden transition-all duration-300 h-full flex flex-col"
       :class="[
         featured ? 'shadow-xl ring-2 ring-primary-500 scale-105 z-10' : 'shadow-md border border-gray-100 dark:border-gray-700 hover:shadow-lg',
         featured ? 'bg-white dark:bg-gray-900' : 'bg-white dark:bg-gray-900'
       ]">
    <div class="p-6" :class="featured ? 'bg-primary-50 dark:bg-primary-900/20' : ''">
      <div class="text-center">
        <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">{{ title }}</h3>
        <div class="flex items-center justify-center">
          <span class="text-4xl font-bold text-gray-900 dark:text-white">{{ price }}</span>
          <span v-if="period" class="text-gray-500 dark:text-gray-400 ml-2">{{ period }}</span>
        </div>
        <p class="text-gray-600 dark:text-gray-300 mt-2">{{ description }}</p>
      </div>
      
      <div class="mt-4 py-2 text-center">
        <span class="font-semibold text-primary-600 dark:text-primary-500">{{ applications }}</span>
        <span class="text-gray-600 dark:text-gray-300"> applications</span>
      </div>
    </div>
    
    <div class="p-6 flex-grow">
      <ul class="space-y-3">
        <li v-for="(feature, index) in features" :key="index" class="flex items-start">
          <CheckIcon class="w-5 h-5 text-primary-500 dark:text-primary-400 flex-shrink-0 mt-0.5" />
          <span class="ml-3 text-gray-600 dark:text-gray-300">{{ feature }}</span>
        </li>
      </ul>
    </div>
    
    <div class="p-6 pt-0">
      <button class="w-full rounded-lg py-3 font-medium transition-colors"
              :class="buttonVariant === 'primary' 
                ? 'bg-primary-600 hover:bg-primary-700 text-white' 
                : 'bg-white dark:bg-gray-900 border-2 border-gray-300 dark:border-gray-600 hover:border-primary-500 text-gray-800 dark:text-gray-200 hover:text-primary-600 dark:hover:text-primary-500'">
        {{ buttonText }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { CheckIcon } from '@heroicons/vue/24/solid';

defineProps({
  title: {
    type: String,
    required: true
  },
  price: {
    type: String,
    required: true
  },
  period: {
    type: String,
    default: ''
  },
  description: {
    type: String,
    required: true
  },
  applications: {
    type: String,
    required: true
  },
  features: {
    type: Array,
    required: true
  },
  buttonText: {
    type: String,
    required: true
  },
  buttonVariant: {
    type: String,
    default: 'primary'
  },
  featured: {
    type: Boolean,
    default: false
  }
});
</script>