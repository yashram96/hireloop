<template>
  <div v-if="show" class="fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
      <div class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75" @click="close"></div>

      <!-- Modal panel -->
      <div class="inline-block px-4 pt-5 pb-4 overflow-hidden text-left align-bottom transition-all transform bg-white dark:bg-gray-800 rounded-lg shadow-xl sm:my-8 sm:align-middle sm:max-w-lg sm:w-full sm:p-6">
        <div class="flex justify-between items-center mb-4">
          <h3 class="text-lg font-medium text-gray-900 dark:text-white">
            {{ isEditing ? 'Edit Work Experience' : 'Add Work Experience' }}
          </h3>
          <button @click="close" class="text-gray-400 hover:text-gray-500">
            <XMarkIcon class="w-6 h-6" />
          </button>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Job Title
            </label>
            <input
              v-model="form.job_title"
              type="text"
              required
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Company
            </label>
            <input
              v-model="form.company"
              type="text"
              required
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Location
            </label>
            <input
              v-model="form.location"
              type="text"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            />
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                Start Date
              </label>
              <VueDatePicker
                v-model="form.start_date"
                required
                :enable-time-picker="false"
                :format="dateFormat"
                :dark="isDark"
                text-input
                auto-apply
                class="date-picker"
              />
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                End Date
              </label>
              <VueDatePicker
                v-model="form.end_date"
                :enable-time-picker="false"
                :format="dateFormat"
                :dark="isDark"
                text-input
                auto-apply
                class="date-picker"
              />
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Description
            </label>
            <textarea
              v-model="form.description"
              rows="4"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            ></textarea>
          </div>
          
          <div v-if="error" class="text-sm text-red-600 dark:text-red-400 mt-2">
            {{ error }}
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
import VueDatePicker from '@vuepic/vue-datepicker'
import { ref, computed, watch } from 'vue';

const props = defineProps({
  show: Boolean,
  experience: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['close', 'save'])

const user = useSupabaseUser()
const { getData } = useApi()

const isEditing = computed(() => !!props.experience)
const loading = ref(false)
const error = ref(null)
const { colorMode } = useColorMode()
const isDark = computed(() => colorMode?.value === 'dark')

const form = ref({
  job_title: '',
  company: '',
  location: '',
  start_date: '',
  end_date: '',
  description: ''
})

const dateFormat = (date) => {
  if (!date) return ''
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

watch(() => props.experience, (newExperience) => {
  if (newExperience) {
    form.value = {
      job_title: newExperience.job_title,
      company: newExperience.company,
      location: newExperience.location,
      start_date: newExperience.start_date,
      end_date: newExperience.end_date,
      description: newExperience.description
    }
  } else {
    form.value = {
      job_title: '',
      company: '',
      location: '',
      start_date: '',
      end_date: '',
      description: ''
    }
  }
}, { immediate: true })

const handleSubmit = async () => {
  try {
    loading.value = true
    error.value = null

    const data = {
      ...form.value,
      user_id: user.value.id
    }

    let response
    if (isEditing.value) {
      response = await getData(
        `/api/work-experience/${props.experience.id}`,
        'PUT',
        data,
        { 'Content-Type': 'application/json' }
      )
    } else {
      response = await getData(
        '/api/work-experience',
        'POST',
        data,
        { 'Content-Type': 'application/json' }
      )
    }

    if (!response) throw new Error('Failed to save work experience')

    emit('save')
    close()
  } catch (error) {
    console.error('Error saving work experience:', error)
    error.value = error.message || 'Failed to save work experience'
  } finally {
    loading.value = false
  }
}

const close = () => {
  // Reset form to initial state
  form.value = {
    job_title: '',
    company: '',
    location: '',
    start_date: '',
    end_date: '',
    description: ''
  }
  emit('close')
}
</script>