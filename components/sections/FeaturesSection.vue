<template>
  <section id="features" class="py-20 bg-gray-50 dark:bg-gray-800">
    <div class="container mx-auto px-4 md:px-6">
      <div class="text-center mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
          Powerful Features to Get You Hired
        </h2>
        <p class="text-xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
          HireLoop combines AI technology with automation to make your job search efficient and effective.
        </p>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <FeatureCard
          title="Smart Job Matching"
          description="Our AI analyzes your resume and preferences to find the perfect job matches for your skills and experience."
          icon="MagnifyingGlassIcon"
        />
        
        <FeatureCard
          title="AI-Powered Resume Parsing"
          description="Advanced parsing technology extracts and understands your skills, experience, and qualifications automatically."
          icon="DocumentIcon"
        />
        
        <FeatureCard
          title="Auto-Apply Engine"
          description="Automatically applies to jobs that match your criteria, saving you hours of repetitive application work."
          icon="PaperAirplaneIcon"
        />
        
        <FeatureCard
          title="Application Tracker"
          description="Keep track of all your applications in one place with status updates and interview scheduling."
          icon="ClipboardDocumentListIcon"
        />
        
        <FeatureCard
          title="Interview Preparation"
          description="Get company-specific interview tips and questions to help you prepare for each opportunity."
          icon="UserGroupIcon"
        />
        
        <FeatureCard
          title="Privacy First"
          description="Your data is encrypted and secure. We never share your information without your explicit permission."
          icon="ShieldCheckIcon"
        />
      </div>
    </div>
  </section>
</template>

<script setup>
// Component imports handled by child components
</script>