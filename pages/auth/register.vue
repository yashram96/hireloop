<template>
  <AuthCard title="Create your account">
    <template #subtitle>
      Already have an account?
      <NuxtLink to="/auth/login" class="font-medium text-primary-600 hover:text-primary-500">
        Sign in
      </NuxtLink>
    </template>

    <form @submit.prevent="handleRegister" class="space-y-6">
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
          Email address
        </label>
        <div class="mt-1">
          <input
            id="email"
            v-model="email"
            type="email"
            required
            class="appearance-none block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-primary-500 focus:border-primary-500 sm:text-sm dark:bg-gray-700 dark:text-white"
          />
        </div>
      </div>

      <div>
        <label for="password" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
          Password
        </label>
        <div class="mt-1">
          <input
            id="password"
            v-model="password"
            type="password"
            required
            class="appearance-none block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-primary-500 focus:border-primary-500 sm:text-sm dark:bg-gray-700 dark:text-white"
          />
        </div>
      </div>

      <div v-if="error" class="bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 p-3 rounded-md text-sm">
        {{ error }}
      </div>

      <button
        type="submit"
        :disabled="loading"
        class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50 disabled:cursor-not-allowed"
      >
        <template v-if="loading">
          <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
          Creating account...
        </template>
        <template v-else>
          Create account
        </template>
      </button>
    </form>
    
    <!-- Referral Code Input -->
    <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700">
      <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
        Have a referral code?
      </p>
      <div class="flex gap-2">
        <input
          v-model="referralCode"
          type="text"
          placeholder="Enter 6-digit code"
          maxlength="6"
          class="flex-1 px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-primary-500 focus:border-primary-500 sm:text-sm dark:bg-gray-700 dark:text-white"
        />
      </div>
    </div>
  </AuthCard>
</template>

<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()

const email = ref('')
const password = ref('')
const referralCode = ref('')
const loading = ref(false)
const error = ref(null)

// Redirect if user is already logged in
if (user.value) {
  navigateTo('/dashboard')
}

const handleRegister = async () => {
  try {
    loading.value = true
    error.value = null
    
    // Sign up user
    const { error: err } = await supabase.auth.signUp({
      email: email.value,
      password: password.value
    })

    if (err) throw err

    // Create profile
    const { error: profileError } = await supabase
      .from('profiles')
      .insert([{ 
        id: user.value.id,
        referred_by: referralCode.value || null
      }])

    if (profileError) throw profileError

    navigateTo('/dashboard')
  } catch (err) {
    error.value = err.message
  } finally {
    loading.value = false
  }
}
</script>