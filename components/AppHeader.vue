<template>
  <header class="fixed top-0 left-0 right-0 z-50 transition-all duration-300" 
          :class="[scrolled ? 'bg-white dark:bg-gray-900 shadow-md py-3' : 'bg-transparent py-5']">
    <div class="container mx-auto px-4 md:px-6 flex items-center justify-between">
      <div class="flex items-center">
        <NuxtLink to="/" class="text-2xl font-bold text-primary-600">
          <span class="text-primary-600">Hire</span><span class="text-secondary-600">Loop</span>
        </NuxtLink>
      </div>
      
      <div class="flex items-center gap-4">
        <!-- Login/Register buttons -->
        <div class="hidden md:flex items-center gap-4">
          <NuxtLink
            v-if="!user"
            to="/auth/login"
            class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium"
          >
            Sign in
          </NuxtLink>
          <NuxtLink
            v-if="!user"
            to="/auth/register"
            class="bg-primary-600 hover:bg-primary-700 text-white px-5 py-2 rounded-lg font-medium transition-colors"
          >
            Sign up
          </NuxtLink>
          <NuxtLink
            v-if="user"
            to="/dashboard"
            class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium"
          >
            Dashboard
          </NuxtLink>
        </div>

        <!-- Theme toggle -->
        <button @click="toggleColorMode" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800">
          <SunIcon v-if="colorMode === 'dark'" class="h-5 w-5 text-gray-700 dark:text-gray-300" />
          <MoonIcon v-else class="h-5 w-5 text-gray-700 dark:text-gray-300" />
        </button>

        <!-- Mobile menu button -->
        <button @click="isMenuOpen = !isMenuOpen" class="md:hidden focus:outline-none">
          <span v-if="!isMenuOpen">
            <Bars3Icon class="h-6 w-6 text-gray-700 dark:text-gray-300" />
          </span>
          <span v-else>
            <XMarkIcon class="h-6 w-6 text-gray-700 dark:text-gray-300" />
          </span>
        </button>
      </div>
      
      <!-- Desktop Navigation -->
      <nav class="hidden md:flex items-center space-x-8">
        <NuxtLink to="#how-it-works" class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium">
          How It Works
        </NuxtLink>
        <NuxtLink to="#features" class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium">
          Features
        </NuxtLink>
        <NuxtLink to="#pricing" class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium">
          Pricing
        </NuxtLink>
        <button class="bg-primary-600 hover:bg-primary-700 text-white px-5 py-2 rounded-lg font-medium transition-colors">
          Get Started
        </button>
      </nav>
    </div>
    
    <!-- Mobile Menu -->
    <div v-if="isMenuOpen" class="md:hidden bg-white dark:bg-gray-900 py-4 px-4 shadow-lg absolute w-full">
      <nav class="flex flex-col space-y-4">
        <NuxtLink to="#how-it-works" @click="isMenuOpen = false" class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium">
          How It Works
        </NuxtLink>
        <NuxtLink to="#features" @click="isMenuOpen = false" class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium">
          Features
        </NuxtLink>
        <NuxtLink to="#pricing" @click="isMenuOpen = false" class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium">
          Pricing
        </NuxtLink>
        <NuxtLink to="/auth/login" @click="isMenuOpen = false" class="text-gray-700 dark:text-gray-300 hover:text-primary-600 transition-colors font-medium">
          Sign in
        </NuxtLink>
        <button class="bg-primary-600 hover:bg-primary-700 text-white px-5 py-2 rounded-lg font-medium transition-colors">
          Sign up
        </button>
      </nav>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { Bars3Icon, XMarkIcon, SunIcon, MoonIcon } from '@heroicons/vue/24/outline';
import { useColorMode } from '#imports';
const user = useSupabaseUser();

const isMenuOpen = ref(false);
const scrolled = ref(false);
const colorMode = useColorMode();

const toggleColorMode = () => {
  colorMode.preference = colorMode.value === 'dark' ? 'light' : 'dark';
};

const checkScroll = () => {
  scrolled.value = window.scrollY > 20;
};

onMounted(() => {
  window.addEventListener('scroll', checkScroll);
  checkScroll(); // Initial check
});

onUnmounted(() => {
  window.removeEventListener('scroll', checkScroll);
});
</script>