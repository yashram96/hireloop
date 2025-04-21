<template>
  <div v-if="show" class="fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
      <div class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75" @click="close"></div>

      <!-- Modal panel -->
      <div class="inline-block px-4 pt-5 pb-4 overflow-hidden text-left align-bottom transition-all transform bg-white dark:bg-gray-800 rounded-lg shadow-xl sm:my-8 sm:align-middle sm:max-w-lg sm:w-full sm:p-6">
        <div class="flex justify-between items-center mb-4">
          <h3 class="text-lg font-medium text-gray-900 dark:text-white">
            {{ isEditing ? 'Edit Education' : 'Add Education' }}
          </h3>
          <button @click="close" class="text-gray-400 hover:text-gray-500">
            <XMarkIcon class="w-6 h-6" />
          </button>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Degree Name
            </label>
            <input
              v-model="form.degree_name"
              type="text"
              required
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Institution
            </label>
            <input
              v-model="form.institution"
              type="text"
              required
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            />
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                Start Date
              </label>
              <div class="grid grid-cols-2 gap-2">
                <select
                  v-model="startMonth"
                  class="px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option v-for="(month, index) in months" :key="index" :value="index">
                    {{ month }}
                  </option>
                </select>
                <select
                  v-model="startYear"
                  class="px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option v-for="year in years" :key="year" :value="year">
                    {{ year }}
                  </option>
                </select>
              </div>
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                End Date
              </label>
              <div class="grid grid-cols-2 gap-2">
                <select
                  v-model="endMonth"
                  class="px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option v-for="(month, index) in months" :key="index" :value="index">
                    {{ month }}
                  </option>
                </select>
                <select
                  v-model="endYear"
                  class="px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option v-for="year in years" :key="year" :value="year">
                    {{ year }}
                  </option>
                </select>
              </div>
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Grade/GPA
            </label>
            <input
              v-model="form.grade"
              type="text"
              class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Description
            </label>
            <textarea
              v-model="form.description"
              rows="3"
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
import { XMarkIcon } from '@heroicons/vue/24/outline';
import { ref, computed, watch } from 'vue';

const props = defineProps({
  show: Boolean,
  education: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['close', 'save'])

const user = useSupabaseUser()
const { getData } = useApi()

const isEditing = computed(() => !!props.education)
const loading = ref(false)
const error = ref(null)

const form = ref({
  degree_name: '',
  institution: '',
  start_date: '',
  end_date: '',
  grade: '',
  description: ''
})

// Date selection
const currentYear = new Date().getFullYear()
const years = Array.from({ length: 50 }, (_, i) => currentYear - i)
const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

const startMonth = ref(0)
const startYear = ref(currentYear)
const endMonth = ref(0)
const endYear = ref(currentYear)

// Convert date string to month/year
const dateToMonthYear = (dateStr) => {
  if (!dateStr) return null
  const date = new Date(dateStr)
  return {
    month: date.getMonth(),
    year: date.getFullYear()
  }
}

// Convert month/year to date string
const monthYearToDate = (month, year) => {
  if (month === null || year === null) return null
  // Create date at noon to avoid timezone issues
  const date = new Date(year, month, 1, 12, 0, 0)
  return date.toISOString().split('T')[0]
}

// Watch for changes in month/year selections and update form
watch([startMonth, startYear], ([month, year]) => {
  form.value.start_date = monthYearToDate(month, year)
})

watch([endMonth, endYear], ([month, year]) => {
  form.value.end_date = monthYearToDate(month, year)
})

const { colorMode } = useColorMode()
const isDark = computed(() => colorMode?.value === 'dark')

// Initialize form with education data if editing
watch(() => props.education, (newEducation) => {
  if (newEducation) {
    const startDate = dateToMonthYear(newEducation.start_date)
    const endDate = dateToMonthYear(newEducation.end_date)
    
    if (startDate) {
      startMonth.value = startDate.month
      startYear.value = startDate.year
    }
    
    if (endDate) {
      endMonth.value = endDate.month
      endYear.value = endDate.year
    }
    
    form.value = {
      degree_name: newEducation.degree_name,
      institution: newEducation.institution,
      start_date: newEducation.start_date,
      end_date: newEducation.end_date,
      grade: newEducation.grade,
      description: newEducation.description
    }
  } else {
    startMonth.value = new Date().getMonth()
    startYear.value = currentYear
    form.value = {
      degree_name: '',
      institution: '',
      start_date: '',
      end_date: '',
      grade: '',
      description: ''
    }
  }
}, { immediate: true })

const handleSubmit = async () => {
  try {
    loading.value = true
    error.value = null
    
    // Ensure dates are properly formatted
    const formData = {
      ...form.value,
      user_id: user.value.id,
      start_date: form.value.start_date ? monthYearToDate(startMonth.value, startYear.value) : null,
      end_date: form.value.end_date ? monthYearToDate(endMonth.value, endYear.value) : null
    }

    let response
    if (isEditing.value) {
      response = await getData(
        `/api/education/${props.education.id}`,
        'PUT',
        formData,
        { 'Content-Type': 'application/json' }
      )
    } else {
      response = await getData(
        '/api/education',
        'POST',
        formData,
        { 'Content-Type': 'application/json' }
      )
    }

    if (!response) throw new Error('Failed to save education')

    emit('save')
    close()
  } catch (error) {
    console.error('Error saving education:', error)
    error.value = error.message || 'Failed to save education'
  } finally {
    loading.value = false
  }
}

const close = () => {
  // Reset form to initial state
  form.value = {
    degree_name: '',
    institution: '',
    start_date: '',
    end_date: '',
    grade: '',
    description: ''
  }
  startMonth.value = new Date().getMonth()
  startYear.value = currentYear
  endMonth.value = new Date().getMonth()
  endYear.value = currentYear
  emit('close')
}
</script>