<template>
  <div class="p-6">
    <form @submit.prevent="$emit('save')" class="space-y-6">
      <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
          Custom Instructions for AI
        </label>
        <textarea
          :value="modelValue"
          @input="$emit('update:modelValue', $event.target.value)"
          rows="6"
          class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
          placeholder="e.g., Focus on Python-heavy roles, avoid startups, prefer remote positions..."
        ></textarea>
      </div>

      <div class="flex justify-end">
        <button
          type="submit"
          :disabled="loading"
          class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50"
        >
          Save Changes
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
defineProps({
  modelValue: {
    type: String,
    required: true
  },
  loading: {
    type: Boolean,
    default: false
  }
})

defineEmits(['update:modelValue', 'save'])
</script>