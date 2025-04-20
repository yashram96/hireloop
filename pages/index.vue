<template>
  <div>
    <AppHeader />
    <main>
      <HeroSection />
      <HowItWorksSection />
      <FeaturesSection />
      <PricingSection />
      <EmailCaptureSection />
    </main>
    <AppFooter />
  </div>
</template>

<script setup>
// Explicitly import all section components to fix hydration errors
import HeroSection from '~/components/sections/HeroSection.vue';
import HowItWorksSection from '~/components/sections/HowItWorksSection.vue';
import FeaturesSection from '~/components/sections/FeaturesSection.vue';
import PricingSection from '~/components/sections/PricingSection.vue';
import EmailCaptureSection from '~/components/sections/EmailCaptureSection.vue';
</script>