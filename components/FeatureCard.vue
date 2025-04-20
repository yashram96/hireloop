<template>
  <div class="bg-white dark:bg-gray-900 rounded-xl p-6 shadow-sm hover:shadow-md transition-all duration-300 border border-gray-100 dark:border-gray-700 h-full transform hover:-translate-y-1">
    <div class="mb-4 text-primary-500">
      <component :is="iconComponent" class="w-10 h-10" />
    </div>
    
    <h3 class="text-xl font-semibold mb-3 text-gray-900 dark:text-white">{{ title }}</h3>
    <p class="text-gray-600 dark:text-gray-300">{{ description }}</p>
  </div>
</template>

<script setup>
import { 
  MagnifyingGlassIcon, 
  DocumentIcon, 
  PaperAirplaneIcon, 
  ClipboardDocumentListIcon,
  UserGroupIcon,
  ShieldCheckIcon
} from '@heroicons/vue/24/outline';

const props = defineProps({
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  icon: {
    type: String,
    required: true
  }
});

const iconComponent = computed(() => {
  const icons = {
    MagnifyingGlassIcon,
    DocumentIcon,
    PaperAirplaneIcon,
    ClipboardDocumentListIcon,
    UserGroupIcon,
    ShieldCheckIcon
  };
  
  return icons[props.icon] || MagnifyingGlassIcon;
});
</script>