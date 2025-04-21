<template>
  <div>
    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
      {{ label }}
    </label>
    <template v-if="type === 'select'">
      <select
        :value="modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
        class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
      >
        <option v-for="option in options" :key="option.value" :value="option.value">
          {{ option.label }}
        </option>
      </select>
    </template>
    <template v-else>
      <input
        :value="modelValue"
        @input="handleInput"
        :type="type"
        :min="min"
        :placeholder="placeholder"
        class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:text-white"
      />
    </template>
  </div>
</template>

<script setup>
const props = defineProps({
  label: {
    type: String,
    required: true
  },
  modelValue: {
    type: [String, Number],
    default: ''
  },
  type: {
    type: String,
    default: 'text'
  },
  options: {
    type: Array,
    default: () => []
  },
  min: {
    type: Number,
    default: () => 0
  },
  placeholder: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['update:modelValue'])

// Computed property to handle display value
const displayValue = computed(() => {
  if (props.type === 'number' && props.modelValue === null) {
    return ''
  }
  return props.modelValue
})

// Handle input changes with proper type conversion
const handleInput = (event) => {
  const value = event.target.value
  if (props.type === 'number') {
    const numValue = value === '' ? null : Number(value)
    if (!isNaN(numValue)) {
      emit('update:modelValue', numValue)
    }
  } else {
    emit('update:modelValue', value)
  }
}
</script>