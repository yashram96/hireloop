<template>
  <section id="how-it-works" class="py-20 bg-white dark:bg-gray-900">
    <div class="container mx-auto px-4 md:px-6">
      <div class="text-center mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">How HireLoop Works</h2>
        <p class="text-xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
          Three simple steps to automate your job search and land more interviews.
        </p>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <StepCard 
          number="1" 
          title="Upload Your Resume" 
          description="Upload your resume and set your job preferences. Our AI analyzes your skills and experience."
          icon="DocumentTextIcon" 
          color="primary" 
        />
        
        <StepCard 
          number="2" 
          title="We Find & Apply to Jobs" 
          description="Our AI matches you with relevant jobs and automatically applies on your behalf every day."
          icon="RocketLaunchIcon" 
          color="secondary" 
        />
        
        <StepCard 
          number="3" 
          title="You Get Interview Calls" 
          description="Focus on preparing for interviews while we handle the tedious application process."
          icon="PhoneIcon" 
          color="success" 
        />
      </div>
      
      <!-- Process Path Visualization (Desktop only) -->
      <div class="hidden md:block relative mt-12">
        <div class="absolute top-1/2 left-1/6 right-1/6 h-1 bg-gray-200 -translate-y-1/2">
          <div class="absolute top-0 left-0 h-full w-2/3 bg-primary-500 rounded-full"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
// No additional setup needed
</script>