<template>
  <div v-if="show" class="fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
      <!-- Background overlay -->
      <div class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75" @click="close"></div>

      <!-- Modal panel -->
      <div class="inline-block px-4 pt-5 pb-4 overflow-hidden text-left align-bottom transition-all transform bg-white dark:bg-gray-800 rounded-lg shadow-xl sm:my-8 sm:align-middle sm:max-w-lg sm:w-full sm:p-6">
        <div class="flex justify-between items-center mb-4">
          <h3 class="text-lg font-medium text-gray-900 dark:text-white">
            {{ isEditing ? 'Edit Language' : 'Add Language' }}
          </h3>
          <button @click="close" class="text-gray-400 hover:text-gray-500">
            <XMarkIcon class="w-6 h-6" />
          </button>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Language
            </label>
            <input
              v-model="form.name"
              type="text"
              required
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Proficiency Level
            </label>
            <select
              v-model="form.proficiency"
              required
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            >
              <option value="">Select proficiency level</option>
              <option value="Native">Native</option>
              <option value="Fluent">Fluent</option>
              <option value="Advanced">Advanced</option>
              <option value="Intermediate">Intermediate</option>
              <option value="Basic">Basic</option>
            </select>
          </div>

          <div class="flex justify-end space-x-3 mt-6">
            <button
              type="button"
              @click="close"
              class="px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-lg"
            >
              Cancel
            </button>
            <button
              type="submit"
              :disabled="loading"
              class="px-4 py-2 text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 rounded-lg disabled:opacity-50"
            >
              {{ loading ? 'Saving...' : (isEditing ? 'Update' : 'Add') }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { XMarkIcon } from '@heroicons/vue/24/outline'

const props = defineProps({
  show: Boolean,
  language: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['close', 'save'])

const supabase = useSupabaseClient()
const user = useSupabaseUser()

const isEditing = computed(() => !!props.language)
const loading = ref(false)

const form = ref({
  name: '',
  proficiency: ''
})

watch(() => props.language, (newLanguage) => {
  if (newLanguage) {
    form.value = {
      name: newLanguage.name,
      proficiency: newLanguage.proficiency
    }
  } else {
    form.value = {
      name: '',
      proficiency: ''
    }
  }
}, { immediate: true })

const handleSubmit = async () => {
  try {
    loading.value = true

    const data = {
      ...form.value,
      user_id: user.value.id
    }

    let result
    if (isEditing.value) {
      result = await supabase
        .from('languages')
        .update(data)
        .eq('id', props.language.id)
    } else {
      result = await supabase
        .from('languages')
        .insert([data])
    }

    if (result.error) throw result.error

    emit('save')
    close()
  } catch (error) {
    console.error('Error saving language:', error)
  } finally {
    loading.value = false
  }
}

const close = () => {
  emit('close')
}
</script>