import { createRouter, createWebHistory } from 'vue-router'

import BoardLayout from '@/layouts/BoardLayout.vue'
import DefaultLayout from '@/layouts/DefaultLayout.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/board/question'
    },
    {
      path: '/',
      component: DefaultLayout,
      children: [
        {
          path: 'ping',
          name: 'ping',
          meta: {
            title: 'ping'
          },
          component: async () => await import(/* webpackChunkName: "ping" */ '@/views/PingView.vue')
        },
        {
          path: 'sign_in',
          name: 'sign_in',
          meta: {
            title: 'sign_in'
          },
          component: async () =>
            await import(/* webpackChunkName: "sign_in" */ '@/views/SignInView.vue')
        }
      ]
    },
    {
      path: '/board',
      component: BoardLayout,
      children: [
        {
          path: 'question',
          name: 'question',
          meta: {
            title: 'question'
          },
          component: async () =>
            await import(/* webpackChunkName: "question" */ '@/views/board/QuestionView.vue')
        },
        {
          path: 'histories',
          name: 'histories',
          meta: {
            title: 'histories'
          },
          component: async () =>
            await import(/* webpackChunkName: "histories" */ '@/views/board/HistoriesView.vue')
        },
        {
          path: 'document',
          name: 'document',
          meta: {
            title: 'document'
          },
          component: async () =>
            await import(/* webpackChunkName: "document" */ '@/views/board/DocumentView.vue')
        },
        {
          path: 'search',
          name: 'search',
          meta: {
            title: 'search'
          },
          component: async () =>
            await import(/* webpackChunkName: "search" */ '@/views/board/SearchView.vue')
        }
      ]
    },
    {
      path: '/:catchAll(.*)',
      redirect: '/board/question'
    }
  ]
})

router.afterEach((to) => {
  const title = to.meta.title as string
  document.title = title
})

export default router
