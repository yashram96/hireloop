<template>
  <DashboardLayout>
    <div class="max-w-6xl">
      <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">
          Campaigns
        </h1>
        <NuxtLink
          to="/campaigns/new"
          class="inline-flex items-center px-4 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
        >
          <PlusIcon class="h-5 w-5 mr-2" />
          New Campaign
        </NuxtLink>
      </div>
      
      <p class="text-gray-600 dark:text-gray-400 mb-8">
        Create and manage your job search campaigns
      </p>
    </div>
  </DashboardLayout>
</template>

<script setup>
import { PlusIcon } from '@heroicons/vue/24/outline'

definePageMeta({
  middleware: 'auth'
})
</script>