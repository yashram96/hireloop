<template>
  <div class="p-6">
    <form @submit.prevent="$emit('save')" class="space-y-6">
      <div class="space-y-6">
        <!-- Experience & Role Type -->
        <PreferenceSection title="Experience & Role Type">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <FormField
              label="Years of Experience"
              v-model="form.years_of_experience"
              type="number"
              min="0"
            />
            
            <FormField
              label="Employment Type"
              v-model="form.employment_type"
              type="select"
              :options="employmentTypes"
            />

            <FormField
              label="Job Level"
              v-model="form.job_level"
              type="select"
              :options="jobLevels"
            />

            <FormField
              label="Remote Preference"
              v-model="form.remote_preference"
              type="select"
              :options="remotePreferences"
            />
          </div>
        </PreferenceSection>

        <!-- Company Preferences -->
        <PreferenceSection title="Company Preferences">
          <div class="grid grid-cols-1 gap-4">
            <FormField
              label="Company Size"
              v-model="form.company_size"
              type="select"
              :options="companySizes"
            />

            <FormField
              label="Preferred Companies (comma-separated)"
              v-model="preferredCompaniesInput"
              type="text"
            />

            <FormField
              label="Blocked Companies (comma-separated)"
              v-model="blockedCompaniesInput"
              type="text"
            />
          </div>
        </PreferenceSection>

        <!-- Compensation -->
        <PreferenceSection title="Compensation">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <FormField
              label="Minimum Salary"
              v-model="form.salary_min"
              type="number"
              min="0"
            />

            <FormField
              label="Maximum Salary"
              v-model="form.salary_max"
              type="number"
              min="0"
            />

            <FormField
              label="Currency"
              v-model="form.salary_currency"
              type="select"
              :options="currencies"
            />

            <FormField
              label="Compensation Type"
              v-model="form.compensation_type"
              type="select"
              :options="compensationTypes"
            />
          </div>
        </PreferenceSection>

        <!-- Visa & Work Authorization -->
        <PreferenceSection title="Visa & Work Authorization">
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

            <FormField
              label="Work Authorization Status"
              v-model="form.work_authorization_status"
              type="select"
              :options="workAuthStatuses"
            />
          </div>
        </PreferenceSection>

        <!-- Job Board Preferences -->
        <PreferenceSection title="Job Board Preferences">
          <div class="grid grid-cols-1 gap-4">
            <FormField
              label="Preferred Job Boards (comma-separated)"
              v-model="jobBoardsInput"
              type="text"
              placeholder="e.g., LinkedIn, Indeed, Glassdoor"
            />

            <FormField
              label="Application Type"
              v-model="form.application_type"
              type="select"
              :options="applicationTypes"
            />
          </div>
        </PreferenceSection>

        <!-- Additional Preferences -->
        <PreferenceSection title="Additional Preferences">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <FormField
              label="Joining Availability"
              v-model="form.joining_availability"
              type="select"
              :options="joiningAvailabilities"
            />

            <FormField
              label="Posting Recency"
              v-model="form.posting_recency"
              type="select"
              :options="postingRecencies"
            />

            <FormField
              label="Preferred Tech Stack (comma-separated)"
              v-model="techStackInput"
              type="text"
            />

            <FormField
              label="Language Requirements (comma-separated)"
              v-model="languageRequirementsInput"
              type="text"
            />
          </div>
        </PreferenceSection>
      </div>

      <div class="flex justify-end">
        <button
          type="button"
          @click="$emit('generate')"
          :disabled="loading || hasUnsavedChanges"
          class="px-4 py-2 mr-3 text-sm font-medium text-white bg-secondary-600 hover:bg-secondary-700 rounded-lg disabled:opacity-50"
        >
          Generate Resume
        </button>
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
import { ref, computed, watch } from 'vue'
import PreferenceSection from './PreferenceSection.vue'
import FormField from './FormField.vue'

const props = defineProps({
  form: {
    type: Object,
    required: true
  },
  loading: Boolean,
  hasUnsavedChanges: Boolean
})
const emit = defineEmits(['save', 'generate'])

// Input fields for array values
const preferredCompaniesInput = ref('')
const blockedCompaniesInput = ref('')
const techStackInput = ref('')
const jobBoardsInput = ref('')
const languageRequirementsInput = ref('')

// Watch for form changes and update input fields
watch(() => props.form, (newForm) => {
  preferredCompaniesInput.value = newForm.preferred_companies?.join(', ') || ''
  blockedCompaniesInput.value = newForm.blocked_companies?.join(', ') || ''
  techStackInput.value = newForm.preferred_tech_stack?.join(', ') || ''
  jobBoardsInput.value = newForm.preferred_job_boards?.join(', ') || ''
  languageRequirementsInput.value = newForm.language_requirements?.join(', ') || ''
}, { immediate: true })

// Watch for input changes and update form arrays
watch(preferredCompaniesInput, (val) => {
  if (props.form) {
    props.form.preferred_companies = val.split(',').map(item => item.trim()).filter(Boolean)
  }
})

watch(blockedCompaniesInput, (val) => { 
  if (props.form) {
    props.form.blocked_companies = val.split(',').map(item => item.trim()).filter(Boolean)
  }
})

watch(techStackInput, (val) => {
  if (props.form) {
    props.form.preferred_tech_stack = val.split(',').map(item => item.trim()).filter(Boolean)
  }
})

watch(languageRequirementsInput, (val) => { 
  if (props.form) {
    props.form.language_requirements = val.split(',').map(item => item.trim()).filter(Boolean)
  }
})

watch(jobBoardsInput, (val) => {
  if (props.form) {
    props.form.preferred_job_boards = val.split(',').map(item => item.trim()).filter(Boolean)
  }
})

// Form options
const employmentTypes = [
  { value: '', label: 'Select type' },
  { value: 'full-time', label: 'Full-time' },
  { value: 'part-time', label: 'Part-time' },
  { value: 'contract', label: 'Contract' },
  { value: 'internship', label: 'Internship' },
  { value: 'freelance', label: 'Freelance' }
]

const jobLevels = [
  { value: '', label: 'Select level' },
  { value: 'entry', label: 'Entry Level' },
  { value: 'mid', label: 'Mid Level' },
  { value: 'senior', label: 'Senior Level' },
  { value: 'lead', label: 'Lead/Principal' },
  { value: 'manager', label: 'Manager' },
  { value: 'director', label: 'Director' }
]

const remotePreferences = [
  { value: '', label: 'Select preference' },
  { value: 'remote', label: 'Fully Remote' },
  { value: 'hybrid', label: 'Hybrid' },
  { value: 'onsite', label: 'On-site' }
]

const companySizes = [
  { value: '', label: 'Select size' },
  { value: 'startup', label: 'Startup (1-50)' },
  { value: 'small', label: 'Small (51-200)' },
  { value: 'medium', label: 'Medium (201-1000)' },
  { value: 'large', label: 'Large (1001-5000)' },
  { value: 'enterprise', label: 'Enterprise (5000+)' }
]

const currencies = [
  { value: '', label: 'Select currency' },
  { value: 'USD', label: 'USD' },
  { value: 'EUR', label: 'EUR' },
  { value: 'GBP', label: 'GBP' },
  { value: 'INR', label: 'INR' }
]

const compensationTypes = [
  { value: '', label: 'Select type' },
  { value: 'base', label: 'Base Only' },
  { value: 'base_bonus', label: 'Base + Bonus' },
  { value: 'base_equity', label: 'Base + Equity' },
  { value: 'commission', label: 'Commission Based' }
]

const workAuthStatuses = [
  { value: '', label: 'Select status' },
  { value: 'citizen', label: 'Citizen/Permanent Resident' },
  { value: 'h1b', label: 'H1B' },
  { value: 'l1', label: 'L1' },
  { value: 'opt', label: 'OPT/CPT' },
  { value: 'other', label: 'Other' }
]

const applicationTypes = [
  { value: '', label: 'Select type' },
  { value: 'easy_apply', label: 'Easy Apply Only' },
  { value: 'direct', label: 'Direct Applications' },
  { value: 'any', label: 'Any Type' }
]

const joiningAvailabilities = [
  { value: '', label: 'Select availability' },
  { value: 'immediate', label: 'Immediate' },
  { value: '15_days', label: '15 Days' },
  { value: '30_days', label: '30 Days' },
  { value: '60_days', label: '60 Days' },
  { value: '90_days', label: '90 Days' }
]

const postingRecencies = [
  { value: '', label: 'Select recency' },
  { value: '24h', label: 'Last 24 hours' },
  { value: '3d', label: 'Last 3 days' },
  { value: '7d', label: 'Last 7 days' },
  { value: '14d', label: 'Last 14 days' },
  { value: '30d', label: 'Last 30 days' }
]
</script>