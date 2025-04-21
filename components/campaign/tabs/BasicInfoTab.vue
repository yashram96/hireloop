<template>
  <div class="p-6">
    <form @submit.prevent="$emit('save')" class="space-y-6">
      <div class="space-y-4">
        <FormField
          label="Job Title/Role"
          v-model="form.title"
          type="text"
          required
          placeholder="e.g., Senior Software Engineer"
        />

        <FormField
          label="Location"
          v-model="form.location"
          type="text"
          placeholder="e.g., Remote, New York, London"
        />

        <FormField
          label="Industry"
          v-model="form.industry"
          type="text"
          placeholder="e.g., Technology, Finance, Healthcare"
        />

        <FormField
          label="Keywords (comma-separated)"
          v-model="keywordsInput"
          type="text"
          placeholder="e.g., React, Node.js, TypeScript"
        />
      </div>

      <div class="flex justify-end">
        <button
          type="submit"
          :disabled="loading || !hasUnsavedChanges"
          class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50"
        >
          Save Changes
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'
import FormField from './FormField.vue'

const props = defineProps({
  form: {
    type: Object,
    required: true
  },
  loading: Boolean,
  hasUnsavedChanges: Boolean
})

defineEmits(['update:form', 'save'])

const keywordsInput = ref(props.form.keywords?.join(', ') || '')

watch(keywordsInput, (val) => {
  props.form.keywords = val.split(',').map(keyword => keyword.trim()).filter(Boolean)
})
</script>