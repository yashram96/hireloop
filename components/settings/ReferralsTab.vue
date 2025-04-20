<template>
  <div class="space-y-4">
    <div class="mb-6">
      <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-2">Your Referral Code</h3>
      <div class="flex items-center space-x-4">
        <div class="bg-gray-100 dark:bg-gray-700 px-4 py-2 rounded-lg font-mono text-xl">
          {{ profile?.referral_code || '------' }}
        </div>
        <button 
          @click="copyCode" 
          class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 transition-colors"
        >
          Copy Code
        </button>
      </div>
    </div>

    <div class="border-t border-gray-200 dark:border-gray-700 pt-6">
      <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-2">Share Your Link</h3>
      <p class="text-gray-600 dark:text-gray-400 mb-4">Share HireLoop with your friends and earn credits!</p>
      <div class="flex items-center space-x-4">
        <input
          type="text"
          :value="referralLink"
          readonly
          class="flex-1 px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm bg-gray-50 dark:bg-gray-600"
        />
        <button 
          @click="copyLink"
          class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 transition-colors"
        >
          Copy Link
        </button>
      </div>
    </div>
  </div>
</template>
<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()
const profile = ref(null)

// Fetch profile data
const fetchProfile = async () => {
  const { data } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.value.id)
    .single()
  
  profile.value = data
}

// Computed referral link
const referralLink = computed(() => {
  return `https://hireloop.com/ref/${profile.value?.referral_code || ''}`
})

// Copy functions
const copyCode = () => {
  navigator.clipboard.writeText(profile.value?.referral_code || '')
}

const copyLink = () => {
  navigator.clipboard.writeText(referralLink.value)
}

onMounted(() => {
  fetchProfile()
})
</script>