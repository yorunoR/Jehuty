<template>
  <Sidebar v-model:visible="visibleLeft">
    <div class="h-screen adjust-height flex flex-column justify-content-between">
      <section>
        <h2>AI Chat bot</h2>
        <hr />
        <ul>
          <li style="border: none; padding: 20px">
            <router-link to="/board/question"> Question </router-link>
          </li>
          <li style="border: none; padding: 20px">
            <router-link to="/board/histories"> Histories </router-link>
          </li>
          <li style="border: none; padding: 20px">
            <router-link to="/board/document"> Document </router-link>
          </li>
          <li style="border: none; padding: 20px">
            <router-link to="/board/search"> Search </router-link>
          </li>
        </ul>
      </section>
      <Button class="p-button-secondary" @click="signOut"> サインアウト </Button>
    </div>
  </Sidebar>
  <div class="fixed top-0 flex flex-row p-3">
    <Button class="p-button-secondary" icon="pi pi-arrow-right" @click="visibleLeft = true" />
  </div>
  <div v-if="visibleMain" class="pt-6 px-3 pb-3">
    <router-view />
  </div>
  <Toast :breakpoints="{ '576px': { width: '97%', left: '6px' } }" />
</template>

<script setup lang="ts">
import { provideClient } from '@urql/vue'
import { ref } from 'vue'

import router from '@/router'
import { makeClient } from '@/services/client'
import firebase from '@/services/firebase'

const visibleMain = ref(false)
const visibleLeft = ref(false)

firebase.onAuthStateChanged((user) => {
  if (user) {
    visibleMain.value = true
  } else {
    router.push({ name: 'sign_in' })
  }
})

provideClient(makeClient())

const signOut = async () => {
  await firebase.signout()
  router.push({ name: 'sign_in' })
}
</script>

<style scoped>
.adjust-height {
  margin-top: -80px;
  padding-top: 80px;
}
</style>
