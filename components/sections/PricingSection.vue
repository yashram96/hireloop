<template>
  <section id="pricing" class="py-20 bg-white dark:bg-gray-900">
    <div class="container mx-auto px-4 md:px-6">
      <div class="text-center mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">Simple, Transparent Pricing</h2>
        <p class="text-xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
          Choose the plan that fits your job search needs. No hidden fees, cancel anytime.
        </p>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-5xl mx-auto">
        <PricingCard
          title="Free"
          price="$0"
          description="For casual job seekers"
          applications="2 per day"
          :features="[
            'Smart Job Matching',
            'Basic Resume Parsing',
            'Application Tracking',
            'Email Notifications'
          ]"
          buttonText="Get Started"
          buttonVariant="secondary"
        />
        
        <PricingCard
          title="Starter"
          price="$9.99"
          period="per month"
          description="Most popular choice"
          applications="10 per day"
          :features="[
            'Everything in Free',
            'Advanced Resume Parsing',
            'Priority Job Matching',
            'Interview Preparation',
            'Email & SMS Notifications',
          ]"
          buttonText="Get Started"
          buttonVariant="primary"
          :featured="true"
        />
        
        <PricingCard
          title="Pro"
          price="$19.99"
          period="per month"
          description="For serious job hunters"
          applications="20 per day"
          :features="[
            'Everything in Starter',
            'Unlimited Applications',
            'Premium Jobs Access',
            'Cover Letter Generation',
            'Resume Optimization',
            'Priority Support'
          ]"
          buttonText="Get Started"
          buttonVariant="secondary"
        />
      </div>
      
      <div class="mt-12 text-center text-gray-600 dark:text-gray-400">
        <p>Need a custom plan for your organization? <a href="#" class="text-primary-600 dark:text-primary-500 font-medium">Contact us</a>.</p>
      </div>
    </div>
  </section>
</template>

<script setup>
// No additional setup needed
</script>