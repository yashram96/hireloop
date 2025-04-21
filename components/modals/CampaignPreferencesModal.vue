<template>
  <div v-if="show" class="fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
      <div class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75" @click="close"></div>

      <!-- Modal panel -->
      <div class="inline-block w-full max-w-3xl px-4 pt-5 pb-4 overflow-hidden text-left align-bottom transition-all transform bg-white dark:bg-gray-800 rounded-lg shadow-xl sm:my-8 sm:align-middle sm:p-6">
        <div class="flex justify-between items-center mb-4">
          <h3 class="text-lg font-medium text-gray-900 dark:text-white">
            Campaign Preferences
          </h3>
          <button @click="close" class="text-gray-400 hover:text-gray-500">
            <XMarkIcon class="w-6 h-6" />
          </button>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Experience & Role Type -->
          <div class="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-4">
            <h4 class="font-medium text-gray-900 dark:text-white">Experience & Role Type</h4>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Years of Experience
                </label>
                <input
                  v-model="form.years_of_experience"
                  type="number"
                  min="0"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Employment Type
                </label>
                <select
                  v-model="form.employment_type"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select type</option>
                  <option value="full-time">Full-time</option>
                  <option value="part-time">Part-time</option>
                  <option value="contract">Contract</option>
                  <option value="internship">Internship</option>
                  <option value="freelance">Freelance</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Job Level
                </label>
                <select
                  v-model="form.job_level"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select level</option>
                  <option value="entry">Entry Level</option>
                  <option value="mid">Mid Level</option>
                  <option value="senior">Senior Level</option>
                  <option value="lead">Lead/Principal</option>
                  <option value="manager">Manager</option>
                  <option value="director">Director</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Remote Preference
                </label>
                <select
                  v-model="form.remote_preference"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select preference</option>
                  <option value="remote">Fully Remote</option>
                  <option value="hybrid">Hybrid</option>
                  <option value="onsite">On-site</option>
                </select>
              </div>
            </div>
          </div>

          <!-- Company Preferences -->
          <div class="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-4">
            <h4 class="font-medium text-gray-900 dark:text-white">Company Preferences</h4>
            <div class="grid grid-cols-1 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Company Size
                </label>
                <select
                  v-model="form.company_size"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select size</option>
                  <option value="startup">Startup (1-50)</option>
                  <option value="small">Small (51-200)</option>
                  <option value="medium">Medium (201-1000)</option>
                  <option value="large">Large (1001-5000)</option>
                  <option value="enterprise">Enterprise (5000+)</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Preferred Companies (comma-separated)
                </label>
                <input
                  v-model="preferredCompaniesInput"
                  type="text"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Blocked Companies (comma-separated)
                </label>
                <input
                  v-model="blockedCompaniesInput"
                  type="text"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>
            </div>
          </div>

          <!-- Compensation -->
          <div class="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-4">
            <h4 class="font-medium text-gray-900 dark:text-white">Compensation</h4>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Minimum Salary
                </label>
                <input
                  v-model="form.salary_min"
                  type="number"
                  min="0"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Maximum Salary
                </label>
                <input
                  v-model="form.salary_max"
                  type="number"
                  min="0"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Currency
                </label>
                <select
                  v-model="form.salary_currency"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select currency</option>
                  <option value="USD">USD</option>
                  <option value="EUR">EUR</option>
                  <option value="GBP">GBP</option>
                  <option value="INR">INR</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Compensation Type
                </label>
                <select
                  v-model="form.compensation_type"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select type</option>
                  <option value="base">Base Only</option>
                  <option value="base_bonus">Base + Bonus</option>
                  <option value="base_equity">Base + Equity</option>
                  <option value="commission">Commission Based</option>
                </select>
              </div>
            </div>
          </div>

          <!-- Visa & Work Authorization -->
          <div class="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-4">
            <h4 class="font-medium text-gray-900 dark:text-white">Visa & Work Authorization</h4>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Requires Visa Sponsorship
                </label>
                <div class="mt-1">
                  <label class="inline-flex items-center">
                    <input
                      v-model="form.requires_visa"
                      type="checkbox"
                      class="rounded border-gray-300 text-primary-600 shadow-sm focus:border-primary-500 focus:ring focus:ring-primary-500 focus:ring-opacity-50"
                    />
                    <span class="ml-2 text-sm text-gray-600 dark:text-gray-400">Yes, I need visa sponsorship</span>
                  </label>
                </div>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Work Authorization Status
                </label>
                <select
                  v-model="form.work_authorization_status"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select status</option>
                  <option value="citizen">Citizen/Permanent Resident</option>
                  <option value="h1b">H1B</option>
                  <option value="l1">L1</option>
                  <option value="opt">OPT/CPT</option>
                  <option value="other">Other</option>
                </select>
              </div>
            </div>
          </div>

          <!-- Job Board Preferences -->
          <div class="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-4">
            <h4 class="font-medium text-gray-900 dark:text-white">Job Board Preferences</h4>
            <div class="grid grid-cols-1 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Preferred Job Boards (comma-separated)
                </label>
                <input
                  v-model="jobBoardsInput"
                  type="text"
                  placeholder="e.g., LinkedIn, Indeed, Glassdoor"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Application Type
                </label>
                <select
                  v-model="form.application_type"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select type</option>
                  <option value="easy_apply">Easy Apply Only</option>
                  <option value="direct">Direct Applications</option>
                  <option value="any">Any Type</option>
                </select>
              </div>
            </div>
          </div>

          <!-- Additional Preferences -->
          <div class="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-4">
            <h4 class="font-medium text-gray-900 dark:text-white">Additional Preferences</h4>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Joining Availability
                </label>
                <select
                  v-model="form.joining_availability"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select availability</option>
                  <option value="immediate">Immediate</option>
                  <option value="15_days">15 Days</option>
                  <option value="30_days">30 Days</option>
                  <option value="60_days">60 Days</option>
                  <option value="90_days">90 Days</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Posting Recency
                </label>
                <select
                  v-model="form.posting_recency"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                >
                  <option value="">Select recency</option>
                  <option value="24h">Last 24 hours</option>
                  <option value="3d">Last 3 days</option>
                  <option value="7d">Last 7 days</option>
                  <option value="14d">Last 14 days</option>
                  <option value="30d">Last 30 days</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Preferred Tech Stack (comma-separated)
                </label>
                <input
                  v-model="techStackInput"
                  type="text"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Language Requirements (comma-separated)
                </label>
                <input
                  v-model="languageRequirementsInput"
                  type="text"
                  class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
                />
              </div>
            </div>
          </div>

          <div class="flex justify-end space-x-3">
            <button
              type="button"
              @click="close"
              class="px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-lg"
            >
              Skip
            </button>
            <button
              type="submit"
              :disabled="loading"
              class="px-4 py-2 text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 rounded-lg disabled:opacity-50"
            >
              {{ loading ? 'Saving...' : 'Save Preferences' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { XMarkIcon } from '@heroicons/vue/24/outline'
import { ref, watch } from 'vue'

const props = defineProps({
  show: Boolean,
  campaignId: {
    type: String,
    required: true
  }
})

const emit = defineEmits(['close', 'save'])

const supabase = useSupabaseClient()
const loading = ref(false)

const form = ref({
  years_of_experience: null,
  employment_type: '',
  job_level: '',
  remote_preference: '',
  company_size: '',
  preferred_companies: [],
  blocked_companies: [],
  joining_availability: '',
  preferred_shift: '',
  salary_min: null,
  salary_max: null,
  salary_currency: '',
  compensation_type: '',
  requires_visa: false,
  work_authorization_status: '',
  posting_recency: '',
  preferred_job_boards: [],
  application_type: '',
  preferred_tech_stack: [],
  language_requirements: []
})

// Input fields for array values
const preferredCompaniesInput = ref('')
const blockedCompaniesInput = ref('')
const techStackInput = ref('')
const jobBoardsInput = ref('')
const languageRequirementsInput = ref('')

// Watch for input changes and update form arrays
watch(preferredCompaniesInput, (val) => {
  form.value.preferred_companies = val.split(',').map(item => item.trim()).filter(Boolean)
})

watch(blockedCompaniesInput, (val) => {
  form.value.blocked_companies = val.split(',').map(item => item.trim()).filter(Boolean)
})

watch(techStackInput, (val) => {
  form.value.preferred_tech_stack = val.split(',').map(item => item.trim()).filter(Boolean)
})

watch(languageRequirementsInput, (val) => {
  form.value.language_requirements = val.split(',').map(item => item.trim()).filter(Boolean)
})

watch(jobBoardsInput, (val) => {
  form.value.preferred_job_boards = val.split(',').map(item => item.trim()).filter(Boolean)
})

const handleSubmit = async () => {
  try {
    loading.value = true

    const { error } = await supabase
      .from('campaigns')
      .update(form.value)
      .eq('id', props.campaignId)

    if (error) throw error

    emit('save')
    close()
  } catch (error) {
    console.error('Error saving preferences:', error)
  } finally {
    loading.value = false
  }
}

const close = () => {
  emit('close')
}
</script>