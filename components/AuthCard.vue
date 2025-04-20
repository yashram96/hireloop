<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-50 dark:bg-gray-900 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 bg-white dark:bg-gray-800 p-8 rounded-xl shadow-lg">
      <div class="text-center">
        <NuxtLink to="/" class="text-2xl font-bold inline-block mb-6">
          <span class="text-primary-600">Hire</span><span class="text-secondary-600">Loop</span>
        </NuxtLink>
        <h2 class="text-3xl font-bold text-gray-900 dark:text-white">
          {{ title }}
        </h2>
        <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">
          <slot name="subtitle" />
        </p>
      </div>

      <div class="mt-8">
        <slot />
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true
  }
});
</script>