<template>
  <div class="max-w-6xl mx-auto">
    <CampaignHeader 
      :campaign="campaign"
      @toggle="toggleCampaign"
      @delete="deleteCampaign"
    />

    <CampaignStats :campaign="campaign" />

    <CampaignTabs
      v-model:activeTab="activeTab"
    />
    <!-- Tab Panels -->
    <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
      <BasicInfoTab
        v-if="activeTab === 'basic'"
        :form="form"
        :loading="loading"
        :has-unsaved-changes="hasUnsavedChanges"
        @save="updateBasicInfo"
      />

      <PreferencesTab
        v-if="activeTab === 'preferences'"
        :form="form"
        :loading="loading"
        :has-unsaved-changes="hasUnsavedChanges"
        @save="updatePreferences"
        @generate="generateResume"
      />

      <ApplicationsTab
        v-if="activeTab === 'applications'"
        :applications="applications"
      />

      <ResumesTab
        v-if="activeTab === 'resumes'"
        :resumes="generatedResumes"
        @delete="deleteResume"
      />

      <AIInstructionsTab
        v-if="activeTab === 'ai'"
        v-model="form.ai_instructions"
        :loading="loading"
        @save="updateAIInstructions"
      />
    </div>
  </div>
</template>

<script setup>
import CampaignHeader from '~/components/campaign/CampaignHeader.vue'
import CampaignStats from '~/components/campaign/CampaignStats.vue'
import CampaignTabs from '~/components/campaign/CampaignTabs.vue'
import BasicInfoTab from '~/components/campaign/tabs/BasicInfoTab.vue'
import PreferencesTab from '~/components/campaign/tabs/PreferencesTab.vue'
import ApplicationsTab from '~/components/campaign/tabs/ApplicationsTab.vue'
import ResumesTab from '~/components/campaign/tabs/ResumesTab.vue'
import AIInstructionsTab from '~/components/campaign/tabs/AIInstructionsTab.vue'

definePageMeta({
  middleware: 'auth',
  layout: 'dashboard'
})

const route = useRoute()
const router = useRouter()
const supabase = useSupabaseClient()
const user = useSupabaseUser()

const campaign = ref(null)
const loading = ref(false)
const error = ref(null)
const activeTab = ref('preferences')

const tabs = [
  { id: 'basic', name: 'Basic Info' },
  { id: 'preferences', name: 'Preferences' },
  { id: 'applications', name: 'Applications' },
  { id: 'resumes', name: 'Generated Resumes' },
  { id: 'ai', name: 'AI Instructions' }
]

// Track form changes
const initialFormState = ref(null)
const hasUnsavedChanges = computed(() => {
  if (!initialFormState.value) return false
  return JSON.stringify(form.value) !== JSON.stringify(initialFormState.value)
})

// Generated resumes
const generatedResumes = ref([])

// Form state
const form = ref({
  title: '',
  location: '',
  industry: '',
  keywords: [],
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
  language_requirements: [],
  ai_instructions: ''
})

// Input handlers for array fields
const preferredCompaniesInput = ref('')
const blockedCompaniesInput = ref('')
const techStackInput = ref('')
const languageRequirementsInput = ref('')
const jobBoardsInput = ref('')

// Watch for changes in comma-separated inputs
watch(preferredCompaniesInput, (newVal) => {
  form.value.preferred_companies = newVal.split(',').map(item => item.trim()).filter(Boolean)
})

watch(blockedCompaniesInput, (newVal) => {
  form.value.blocked_companies = newVal.split(',').map(item => item.trim()).filter(Boolean)
})

watch(techStackInput, (newVal) => {
  form.value.preferred_tech_stack = newVal.split(',').map(item => item.trim()).filter(Boolean)
})

watch(languageRequirementsInput, (newVal) => {
  form.value.language_requirements = newVal.split(',').map(item => item.trim()).filter(Boolean)
})

watch(jobBoardsInput, (newVal) => {
  form.value.preferred_job_boards = newVal.split(',').map(item => item.trim()).filter(Boolean)
})

// Applications data
const applications = ref([])

// Fetch campaign data
const fetchCampaign = async () => {
  try {
    loading.value = true
    const { data, error: err } = await supabase
      .from('campaigns')
      .select('*')
      .eq('id', route.params.id)
      .single()

    if (err) throw err

    campaign.value = data
    form.value = { ...data }
    initialFormState.value = { ...data }

    // Set input fields for arrays
    preferredCompaniesInput.value = data.preferred_companies?.join(', ') || ''
    blockedCompaniesInput.value = data.blocked_companies?.join(', ') || ''
    techStackInput.value = data.preferred_tech_stack?.join(', ') || ''
    languageRequirementsInput.value = data.language_requirements?.join(', ') || ''
    jobBoardsInput.value = data.preferred_job_boards?.join(', ') || ''
  } catch (err) {
    error.value = err.message
    console.error('Error fetching campaign:', err)
  } finally {
    loading.value = false
  }
}

// Update basic info
const updateBasicInfo = async () => {
  try {
    loading.value = true
    const { error: err } = await supabase
      .from('campaigns')
      .update({
        title: form.value.title,
        location: form.value.location,
        industry: form.value.industry,
        keywords: form.value.keywords
      })
      .eq('id', route.params.id)

    if (err) throw err

    initialFormState.value = { ...form.value }
  } catch (err) {
    error.value = err.message
    console.error('Error updating basic info:', err)
  } finally {
    loading.value = false
  }
}

// Update campaign preferences
const updatePreferences = async () => {
  try {
    loading.value = true
    const { error: err } = await supabase
      .from('campaigns')
      .update(form.value)
      .eq('id', route.params.id)

    if (err) throw err

    initialFormState.value = { ...form.value }
  } catch (err) {
    error.value = err.message
    console.error('Error updating preferences:', err)
  } finally {
    loading.value = false
  }
}

// Update AI instructions
const updateAIInstructions = async () => {
  try {
    loading.value = true
    const { error: err } = await supabase
      .from('campaigns')
      .update({ ai_instructions: form.value.ai_instructions })
      .eq('id', route.params.id)

    if (err) throw err
  } catch (err) {
    error.value = err.message
    console.error('Error updating AI instructions:', err)
  } finally {
    loading.value = false
  }
}

// Toggle campaign status
const toggleCampaign = async () => {
  try {
    loading.value = true
    const { error: err } = await supabase
      .from('campaigns')
      .update({ is_active: !campaign.value.is_active })
      .eq('id', route.params.id)

    if (err) throw err

    campaign.value.is_active = !campaign.value.is_active
  } catch (err) {
    error.value = err.message
    console.error('Error toggling campaign:', err)
  } finally {
    loading.value = false
  }
}

// Delete campaign
const deleteCampaign = async () => {
  if (!confirm('Are you sure you want to delete this campaign? This action cannot be undone.')) {
    return
  }

  try {
    loading.value = true
    const { error: err } = await supabase
      .from('campaigns')
      .delete()
      .eq('id', route.params.id)

    if (err) throw err

    router.push('/dashboard/campaigns')
  } catch (err) {
    error.value = err.message
    console.error('Error deleting campaign:', err)
  } finally {
    loading.value = false
  }
}

// Generate resume
const generateResume = async () => {
  try {
    loading.value = true
    // Implementation for resume generation will go here
    console.log('Generating resume...')
  } catch (err) {
    error.value = err.message
    console.error('Error generating resume:', err)
  } finally {
    loading.value = false
  }
}

// Delete resume
const deleteResume = async (resumeId) => {
  if (!confirm('Are you sure you want to delete this resume?')) {
    return
  }

  try {
    loading.value = true
    // Implementation for resume deletion will go here
    console.log('Deleting resume:', resumeId)
  } catch (err) {
    error.value = err.message
    console.error('Error deleting resume:', err)
  } finally {
    loading.value = false
  }
}

// Fetch data on mount
onMounted(() => {
  fetchCampaign()
})
</script>