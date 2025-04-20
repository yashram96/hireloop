<template>
  <div class="max-w-4xl mx-auto">
    <!-- Header -->
    <div class="mb-8">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">
        Career Information
      </h1>
      <p class="text-gray-600 dark:text-gray-400">
        This information helps HireLoop personalize your job applications and generate tailored resumes for different campaigns.
      </p>
    </div>

    <!-- Progress Bar -->
    <div class="mb-8">
      <div class="flex items-center justify-between mb-2">
        <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Profile Completion</span>
        <span class="text-sm font-medium text-primary-600">{{ completionPercentage }}%</span>
      </div>
      <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
        <div class="bg-primary-600 h-2 rounded-full" :style="{ width: `${completionPercentage}%` }"></div>
      </div>
    </div>

    <!-- Sections -->
    <div class="space-y-6">
      <!-- Education Section -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
        <div class="p-6">
          <div class="flex items-center justify-between mb-4">
            <div class="flex items-center">
              <AcademicCapIcon class="w-6 h-6 text-primary-500 mr-2" />
              <h2 class="text-lg font-medium text-gray-900 dark:text-white">Education</h2>
              <button
                type="button"
                class="ml-2 text-gray-400 hover:text-gray-500"
                @mouseenter="showTooltip = 'education'"
                @mouseleave="showTooltip = null"
              >
                <InformationCircleIcon class="w-5 h-5" />
              </button>
            </div>
            <button
              @click="addEducation"
              class="inline-flex items-center px-3 py-1.5 border border-transparent text-sm font-medium rounded-lg text-primary-600 bg-primary-50 hover:bg-primary-100 dark:bg-primary-900/20 dark:hover:bg-primary-900/30"
            >
              <PlusIcon class="w-4 h-4 mr-1" />
              Add Education
            </button>
          </div>

          <div v-if="showTooltip === 'education'" class="mb-4 p-3 bg-gray-50 dark:bg-gray-700 rounded-lg text-sm text-gray-600 dark:text-gray-300">
            Your educational background helps employers understand your academic qualifications and is automatically included in your resumes.
          </div>

          <!-- Education List -->
          <div class="space-y-4">
            <div v-for="edu in education" :key="edu.id" class="border border-gray-200 dark:border-gray-700 rounded-lg p-4">
              <div class="flex justify-between items-start">
                <div>
                  <h3 class="font-medium text-gray-900 dark:text-white">{{ edu.degree_name }}</h3>
                  <p class="text-gray-600 dark:text-gray-400">{{ edu.institution }}</p>
                  <p class="text-sm text-gray-500 dark:text-gray-400">
                    {{ formatDate(edu.start_date) }} - {{ formatDate(edu.end_date) }}
                  </p>
                </div>
                <div class="flex space-x-2">
                  <button
                    @click="editEducation(edu)"
                    class="text-gray-400 hover:text-gray-500"
                  >
                    <PencilIcon class="w-4 h-4" />
                  </button>
                  <button
                    @click="deleteEducation(edu.id)"
                    class="text-gray-400 hover:text-red-500"
                  >
                    <TrashIcon class="w-4 h-4" />
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Work Experience Section -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
        <div class="p-6">
          <div class="flex items-center justify-between mb-4">
            <div class="flex items-center">
              <BriefcaseIcon class="w-6 h-6 text-primary-500 mr-2" />
              <h2 class="text-lg font-medium text-gray-900 dark:text-white">Work Experience</h2>
              <button
                type="button"
                class="ml-2 text-gray-400 hover:text-gray-500"
                @mouseenter="showTooltip = 'work'"
                @mouseleave="showTooltip = null"
              >
                <InformationCircleIcon class="w-5 h-5" />
              </button>
            </div>
            <button
              @click="addWorkExperience"
              class="inline-flex items-center px-3 py-1.5 border border-transparent text-sm font-medium rounded-lg text-primary-600 bg-primary-50 hover:bg-primary-100 dark:bg-primary-900/20 dark:hover:bg-primary-900/30"
            >
              <PlusIcon class="w-4 h-4 mr-1" />
              Add Experience
            </button>
          </div>

          <div v-if="showTooltip === 'work'" class="mb-4 p-3 bg-gray-50 dark:bg-gray-700 rounded-lg text-sm text-gray-600 dark:text-gray-300">
            Your work history demonstrates your professional experience and is a key factor in job applications.
          </div>

          <!-- Work Experience List -->
          <div class="space-y-4">
            <div v-for="exp in workExperience" :key="exp.id" class="border border-gray-200 dark:border-gray-700 rounded-lg p-4">
              <div class="flex justify-between items-start">
                <div>
                  <h3 class="font-medium text-gray-900 dark:text-white">{{ exp.job_title }}</h3>
                  <p class="text-gray-600 dark:text-gray-400">{{ exp.company }}</p>
                  <p class="text-sm text-gray-500 dark:text-gray-400">
                    {{ formatDate(exp.start_date) }} - {{ exp.end_date ? formatDate(exp.end_date) : 'Present' }}
                  </p>
                  <p class="mt-2 text-gray-600 dark:text-gray-400">{{ exp.description }}</p>
                </div>
                <div class="flex space-x-2">
                  <button
                    @click="editWorkExperience(exp)"
                    class="text-gray-400 hover:text-gray-500"
                  >
                    <PencilIcon class="w-4 h-4" />
                  </button>
                  <button
                    @click="deleteWorkExperience(exp.id)"
                    class="text-gray-400 hover:text-red-500"
                  >
                    <TrashIcon class="w-4 h-4" />
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Skills Section -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
        <div class="p-6">
          <div class="flex items-center justify-between mb-4">
            <div class="flex items-center">
              <WrenchIcon class="w-6 h-6 text-primary-500 mr-2" />
              <h2 class="text-lg font-medium text-gray-900 dark:text-white">Skills</h2>
              <button
                type="button"
                class="ml-2 text-gray-400 hover:text-gray-500"
                @mouseenter="showTooltip = 'skills'"
                @mouseleave="showTooltip = null"
              >
                <InformationCircleIcon class="w-5 h-5" />
              </button>
            </div>
            <button
              @click="addSkill"
              class="inline-flex items-center px-3 py-1.5 border border-transparent text-sm font-medium rounded-lg text-primary-600 bg-primary-50 hover:bg-primary-100 dark:bg-primary-900/20 dark:hover:bg-primary-900/30"
            >
              <PlusIcon class="w-4 h-4 mr-1" />
              Add Skill
            </button>
          </div>

          <div v-if="showTooltip === 'skills'" class="mb-4 p-3 bg-gray-50 dark:bg-gray-700 rounded-lg text-sm text-gray-600 dark:text-gray-300">
            Skills are crucial for job matching and are used to highlight your capabilities in applications.
          </div>

          <!-- Skills List -->
          <div class="space-y-4">
            <div v-for="category in skillCategories" :key="category" class="space-y-2">
              <h3 class="text-sm font-medium text-gray-700 dark:text-gray-300">{{ category }}</h3>
              <div class="flex flex-wrap gap-2">
                <div
                  v-for="skill in getSkillsByCategory(category)"
                  :key="skill.id"
                  class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-gray-100 dark:bg-gray-700 text-gray-800 dark:text-gray-200"
                >
                  {{ skill.name }}
                  <button
                    @click="deleteSkill(skill.id)"
                    class="ml-2 text-gray-500 hover:text-red-500"
                  >
                    <XMarkIcon class="w-4 h-4" />
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Languages Section -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
        <div class="p-6">
          <div class="flex items-center justify-between mb-4">
            <div class="flex items-center">
              <LanguageIcon class="w-6 h-6 text-primary-500 mr-2" />
              <h2 class="text-lg font-medium text-gray-900 dark:text-white">Languages</h2>
              <button
                type="button"
                class="ml-2 text-gray-400 hover:text-gray-500"
                @mouseenter="showTooltip = 'languages'"
                @mouseleave="showTooltip = null"
              >
                <InformationCircleIcon class="w-5 h-5" />
              </button>
            </div>
            <button
              @click="addLanguage"
              class="inline-flex items-center px-3 py-1.5 border border-transparent text-sm font-medium rounded-lg text-primary-600 bg-primary-50 hover:bg-primary-100 dark:bg-primary-900/20 dark:hover:bg-primary-900/30"
            >
              <PlusIcon class="w-4 h-4 mr-1" />
              Add Language
            </button>
          </div>

          <div v-if="showTooltip === 'languages'" class="mb-4 p-3 bg-gray-50 dark:bg-gray-700 rounded-lg text-sm text-gray-600 dark:text-gray-300">
            Language skills can be a valuable asset and are highlighted in relevant job applications.
          </div>

          <!-- Languages List -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div
              v-for="lang in languages"
              :key="lang.id"
              class="flex justify-between items-center p-3 border border-gray-200 dark:border-gray-700 rounded-lg"
            >
              <div>
                <p class="font-medium text-gray-900 dark:text-white">{{ lang.name }}</p>
                <p class="text-sm text-gray-500 dark:text-gray-400">{{ lang.proficiency }}</p>
              </div>
              <div class="flex space-x-2">
                <button
                  @click="editLanguage(lang)"
                  class="text-gray-400 hover:text-gray-500"
                >
                  <PencilIcon class="w-4 h-4" />
                </button>
                <button
                  @click="deleteLanguage(lang.id)"
                  class="text-gray-400 hover:text-red-500"
                >
                  <TrashIcon class="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modals -->
    <EducationModal
      v-if="showEducationModal"
      :show="showEducationModal"
      :education="selectedEducation"
      @close="showEducationModal = false"
      @save="fetchEducation"
    />
    <WorkExperienceModal
      v-if="showWorkExperienceModal"
      :show="showWorkExperienceModal"
      :experience="selectedWorkExperience"
      @close="showWorkExperienceModal = false"
      @save="fetchWorkExperience"
    />
    <SkillModal
      v-if="showSkillModal"
      :show="showSkillModal"
      :categories="skillCategories"
      @close="showSkillModal = false"
      @save="fetchSkills"
    />
    <LanguageModal
      v-if="showLanguageModal"
      :show="showLanguageModal"
      :language="selectedLanguage"
      @close="showLanguageModal = false"
      @save="fetchLanguages"
    />
  </div>
</template>

<script setup>
import {
  AcademicCapIcon,
  BriefcaseIcon,
  WrenchIcon,
  LanguageIcon,
  InformationCircleIcon,
  PlusIcon,
  PencilIcon,
  TrashIcon,
  XMarkIcon
} from '@heroicons/vue/24/outline';

import EducationModal from '~/components/modals/EducationModal.vue'
import WorkExperienceModal from '~/components/modals/WorkExperienceModal.vue'
import SkillModal from '~/components/modals/SkillModal.vue'
import LanguageModal from '~/components/modals/LanguageModal.vue'

definePageMeta({
  middleware: 'auth',
  layout: 'dashboard'
})

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const { getData } = useApi()

// Initialize reactive variables
const education = ref([])
const workExperience = ref([])
const skills = ref(null)
const languages = ref([])
const showTooltip = ref(null)

// Modal states
const showEducationModal = ref(false)
const selectedEducation = ref(null)
const showWorkExperienceModal = ref(false)
const selectedWorkExperience = ref(null)
const showSkillModal = ref(false)
const showLanguageModal = ref(false)
const selectedLanguage = ref(null)

// Computed completion percentage
const completionPercentage = computed(() => {
  if (!education.value || !workExperience.value || !skills.value || !languages.value) {
    return 0
  }

  if (!education.value || !workExperience.value || !skills.value || !languages.value) return 0
  
  const sections = [
    education.value.length > 0,
    workExperience.value.length > 0,
    skills.value.length > 0,
    languages.value.length > 0
  ]
  
  return Math.round((sections.filter(Boolean).length / sections.length) * 100)
})

// Define skill categories
const skillCategories = [
  'Programming Languages',
  'Frameworks & Libraries',
  'Tools & Technologies',
  'Soft Skills'
]

const getSkillsByCategory = (category) => {
  if (!skills.value) return []
  return skills.value.filter(skill => skill.category === category) || []
}

// Date formatter
const formatDate = (date) => {
  if (!date) return ''
  return new Date(date).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })
}

// Fetch data
const fetchEducation = async () => {
  if (!user.value?.id) return
  const { data } = await supabase
    .from('education')
    .select('*')
    .eq('user_id', user.value.id)
    .order('start_date', { ascending: false })
  
  education.value = data || []
}

const fetchWorkExperience = async () => {
  if (!user.value?.id) return
  const { data } = await supabase
    .from('work_experience')
    .select('*')
    .eq('user_id', user.value.id)
    .order('start_date', { ascending: false })
  
  workExperience.value = data || []
}

const fetchSkills = async () => {
  if (!user.value?.id) return
  const { data } = await supabase
    .from('skills')
    .select('*')
    .eq('user_id', user.value.id)
    .order('category', { ascending: true })
  
  skills.value = data || []
}

const fetchLanguages = async () => {
  if (!user.value?.id) return
  const { data } = await supabase
    .from('languages')
    .select('*')
    .eq('user_id', user.value.id)
    .order('name', { ascending: true })
  
  languages.value = data || []
}

// CRUD operations
const addEducation = () => {
  selectedEducation.value = null
  showEducationModal.value = true
}

const editEducation = (education) => {
  selectedEducation.value = education
  showEducationModal.value = true
}

const deleteEducation = async (id) => {
  if (!confirm('Are you sure you want to delete this education entry?')) return
  
  const { error } = await supabase
    .from('education')
    .delete()
    .eq('id', id)
  
  if (error) {
    console.error('Error deleting education:', error)
    return
  }
  
  await fetchEducation()
}

const addWorkExperience = () => {
  selectedWorkExperience.value = null
  showWorkExperienceModal.value = true
}

const editWorkExperience = (experience) => {
  selectedWorkExperience.value = experience
  showWorkExperienceModal.value = true
}

const deleteWorkExperience = async (id) => {
  if (!confirm('Are you sure you want to delete this work experience?')) return
  
  const { error } = await supabase
    .from('work_experience')
    .delete()
    .eq('id', id)
  
  if (error) {
    console.error('Error deleting work experience:', error)
    return
  }
  
  await fetchWorkExperience()
}

const addSkill = () => {
  showSkillModal.value = true
}

const deleteSkill = async (id) => {
  const { error } = await supabase
    .from('skills')
    .delete()
    .eq('id', id)
  
  if (error) {
    console.error('Error deleting skill:', error)
    return
  }
  
  await fetchSkills()
}

const addLanguage = () => {
  selectedLanguage.value = null
  showLanguageModal.value = true
}

const editLanguage = (language) => {
  selectedLanguage.value = language
  showLanguageModal.value = true
}

const deleteLanguage = async (id) => {
  if (!confirm('Are you sure you want to delete this language?')) return
  
  const { error } = await supabase
    .from('languages')
    .delete()
    .eq('id', id)
  
  if (error) {
    console.error('Error deleting language:', error)
    return
  }
  
  await fetchLanguages()
}

// Watch for user changes and fetch data
watch(user, async () => {
  if (user.value?.id) {
    await Promise.all([
      fetchEducation(),
      fetchWorkExperience(),
      fetchSkills(),
      fetchLanguages()
    ])
  }
}, { immediate: true })
</script>