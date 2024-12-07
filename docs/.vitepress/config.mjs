import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Element",
  description: "Moderation made simple",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config

    footer: {
      message: 'Released under the MIT License.',
    },

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Tutorial', link: '/tutorial/getting_started' }
    ],

    sidebar: [
      {
        text: 'Crash Course',
        items: [
          { text: 'Get Started', link: '/tutorial/getting_started' },
          { text: 'Managing Permissions', link: '/tutorial/managing_permissions' },
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/vuejs/vitepress' }
    ]
  }
})
