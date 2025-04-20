<template>
  <section class="py-20 bg-gradient-to-br from-primary-600 to-secondary-700 text-white">
    <div class="container mx-auto px-4 md:px-6">
      <div class="max-w-3xl mx-auto text-center">
        <h2 class="text-3xl md:text-4xl font-bold mb-4">Ready to Transform Your Job Search?</h2>
        <p class="text-xl text-white/80 mb-8">
          Join our waitlist to be notified when we launch. Get early access and exclusive offers.
        </p>
        
        <form @submit.prevent="submitEmail" class="max-w-md mx-auto">
          <div class="flex flex-col sm:flex-row gap-2 mb-2">
            <input 
              v-model="email" 
              type="email" 
              placeholder="Enter your email address" 
              class="flex-grow px-4 py-3 rounded-lg text-gray-900 focus:outline-none focus:ring-2 focus:ring-white"
              required
            />
            <button 
              type="submit" 
              class="bg-white text-primary-600 hover:bg-gray-100 px-6 py-3 rounded-lg font-medium transition-colors"
              :disabled="loading"
            >
              <div v-if="loading" class="flex items-center justify-center">
                <svg class="animate-spin h-5 w-5 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Processing...
              </div>
              <span v-else>Notify Me</span>
            </button>
          </div>
          <p class="text-sm text-white/70">
            We'll never share your email address with anyone else.
          </p>
        </form>
        
        <div v-if="submitted" class="mt-6 bg-white/10 rounded-lg p-4 text-center inline-block">
          <CheckCircleIcon class="h-6 w-6 text-white inline mb-1 mr-1" />
          <span>Thank you! You're on the list.</span>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue';
import { CheckCircleIcon } from '@heroicons/vue/24/solid';

const email = ref('');
const loading = ref(false);
const submitted = ref(false);

const submitEmail = async () => {
  loading.value = true;
  
  // Simulate API call with a delay
  await new Promise(resolve => setTimeout(resolve, 1000));
  
  // In a real implementation, you would make an API call here
  // await fetch('/api/notify', {
  //   method: 'POST',
  //   headers: { 'Content-Type': 'application/json' },
  //   body: JSON.stringify({ email: email.value })
  // });
  
  loading.value = false;
  submitted.value = true;
  email.value = '';
};
</script>