<template>
  <DashboardLayout>
    <div class="max-w-6xl">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-6">
        Job Feed
      </h1>
      <p class="text-gray-600 dark:text-gray-400 mb-8">
        Coming soon: Aggregated job listings from multiple sources
      </p>
    </div>
  </DashboardLayout>
</template>

<script setup>
definePageMeta({
  middleware: 'auth'
})
</script>