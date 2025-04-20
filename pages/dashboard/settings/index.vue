<template>
  <div class="max-w-4xl">
    <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">
      Settings
    </h1>
    <p class="text-gray-600 dark:text-gray-400 mb-6">
      Manage your account settings and preferences
    </p>

    <!-- Tabs -->
    <div class="mb-6 border-b border-gray-200 dark:border-gray-700">
      <nav class="-mb-px flex space-x-8">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="[
            activeTab === tab.id
              ? 'border-primary-500 text-primary-600'
              : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
            'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm'
          ]"
        >
          {{ tab.name }}
        </button>
      </nav>
    </div>

    <!-- Tab Panels -->
    <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700">
      <div class="p-6">
        <UserDetailsTab v-if="activeTab === 'user'" />
        <SubscriptionTab v-if="activeTab === 'subscription'" />
        <ReferralsTab v-if="activeTab === 'referrals'" />
        <IntegrationsTab v-if="activeTab === 'integrations'" />
      </div>
    </div>
  </div>
</template>

<script setup>
import UserDetailsTab from '~/components/settings/UserDetailsTab.vue'
import SubscriptionTab from '~/components/settings/SubscriptionTab.vue'
import ReferralsTab from '~/components/settings/ReferralsTab.vue'
import IntegrationsTab from '~/components/settings/IntegrationsTab.vue'

definePageMeta({
  middleware: 'auth',
  layout: 'dashboard'
})

const activeTab = ref('user')

const tabs = [
  { id: 'user', name: 'User Details' },
  { id: 'subscription', name: 'Subscription' },
  { id: 'referrals', name: 'Referrals' },
  { id: 'integrations', name: 'Integrations' }
]
</script>