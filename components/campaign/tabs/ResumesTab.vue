<template>
  <div class="p-6">
    <div class="space-y-4">
      <div v-if="resumes.length === 0" class="text-center py-8">
        <DocumentIcon class="mx-auto h-12 w-12 text-gray-400" />
        <h3 class="mt-2 text-sm font-medium text-gray-900 dark:text-white">No resumes generated</h3>
        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
          Generate your first resume by clicking the "Generate Resume" button in the Preferences tab.
        </p>
      </div>
      
      <div v-else class="grid grid-cols-1 gap-4">
        <div v-for="resume in resumes" 
             :key="resume.id"
             class="flex items-center justify-between p-4 bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
          <div>
            <p class="font-medium text-gray-900 dark:text-white">
              {{ resume.filename }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">
              Generated {{ new Date(resume.created_at).toLocaleDateString() }}
            </p>
          </div>
          <div class="flex space-x-2">
            <a :href="resume.url"
               target="_blank"
               class="p-2 text-gray-400 hover:text-gray-500">
              <ArrowTopRightOnSquareIcon class="w-5 h-5" />
            </a>
            <button @click="$emit('delete', resume.id)"
                    class="p-2 text-gray-400 hover:text-red-500">
              <TrashIcon class="w-5 h-5" />
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { DocumentIcon, ArrowTopRightOnSquareIcon, TrashIcon } from '@heroicons/vue/24/outline'

defineProps({
  resumes: {
    type: Array,
    default: () => []
  }
})

defineEmits(['delete'])
</script>