<template>
  <section class="pt-32 pb-20 md:pt-40 md:pb-24 bg-gradient-to-br from-primary-50 to-secondary-50 dark:from-gray-800 dark:to-gray-900">
    <div class="container mx-auto px-4 md:px-6">
      <div class="flex flex-col md:flex-row items-center">
        <div class="md:w-1/2 mb-12 md:mb-0">
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold leading-tight text-gray-900 dark:text-white mb-4">
            Land Your Next Job <span class="text-primary-600">Automatically</span>
          </h1>
          <p class="text-xl md:text-2xl text-gray-700 dark:text-gray-300 mb-8 max-w-xl">
            HireLoop applies to jobs for you every day — while you sleep.
          </p>
          <div class="flex flex-col sm:flex-row gap-4">
            <button class="bg-primary-600 hover:bg-primary-700 text-white px-8 py-3 rounded-lg font-medium text-lg transition-colors">
              Get Started Free
            </button>
            <button class="border-2 border-gray-300 hover:border-primary-500 text-gray-700 dark:text-gray-300 dark:border-gray-600 hover:text-primary-600 dark:hover:text-primary-500 px-8 py-3 rounded-lg font-medium text-lg transition-colors">
              See How It Works
            </button>
          </div>
          <div class="mt-8 flex items-center text-gray-500 dark:text-gray-400">
            <div class="flex -space-x-2">
              <img src="https://randomuser.me/api/portraits/women/32.jpg" class="w-8 h-8 rounded-full border-2 border-white" alt="User" />
              <img src="https://randomuser.me/api/portraits/men/44.jpg" class="w-8 h-8 rounded-full border-2 border-white" alt="User" />
              <img src="https://randomuser.me/api/portraits/women/54.jpg" class="w-8 h-8 rounded-full border-2 border-white" alt="User" />
            </div>
            <p class="ml-3 text-sm">
              Join <span class="font-medium text-primary-600 dark:text-primary-500">2,500+</span> job seekers using HireLoop
            </p>
          </div>
        </div>
        <div class="md:w-1/2 flex justify-center md:justify-end">
          <!-- Hero Image -->
          <div class="relative">
            <div class="absolute -inset-1 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-xl blur-xl opacity-30"></div>
            <div class="relative bg-white p-4 rounded-xl shadow-xl">
              <img src="https://placehold.co/600x400/EBF5FF/1E40AF?text=HireLoop+Dashboard" 
                  alt="HireLoop Dashboard Preview" 
                  class="rounded-lg w-full max-w-md h-auto" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>