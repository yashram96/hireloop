// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-04-20',
  devtools: { enabled: false },
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxtjs/color-mode',
    '@nuxtjs/supabase'
  ],
  supabase: {
    url: process.env.NUXT_PUBLIC_SUPABASE_URL,
    key: process.env.NUXT_PUBLIC_SUPABASE_ANON_KEY,
    redirect: false,
  }, runtimeConfig: {
    public: {
      apiBase: '',
      apiKey: ''
    }
  },
  colorMode: {
    classSuffix: '',
    preference: 'system',
    fallback: 'light'
  },
  vite: {
    server: {
      watch: {
        usePolling: true,
        interval: 1000, // Increased from 10ms to 1000ms to reduce server load
      },
      hmr: {
        port: 24678,
      },
    },
  },
  app: {
    head: {
      title: 'HireLoop - Land Your Next Job Automatically',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          hid: 'description',
          name: 'description',
          content: 'HireLoop applies to jobs for you every day — while you sleep.'
        }
      ],
      link: [
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap'
        }
      ],
    }
  },
  css: [
    '~/assets/css/main.css',
    '@vuepic/vue-datepicker/dist/main.css'
  ],
  build: {
    transpile: ['@vuepic/vue-datepicker']
  }
})