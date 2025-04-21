<template>
  <div class="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-4">
    <h4 class="font-medium text-gray-900 dark:text-white">{{ title }}</h4>
    <slot></slot>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true
  }
})
</script>