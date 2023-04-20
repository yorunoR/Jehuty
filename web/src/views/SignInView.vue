<template>
  <main class="h-full">
    <h1 style="margin: 100px">AI Chat bot</h1>
    <Button class="top-50" @click="signIn"> Google Sign in </Button>
  </main>
</template>

<script setup lang="ts">
import { useToast } from 'primevue/usetoast'
import router from '@/router'
// import { useSigninUserMutation } from '@/auto_generated/graphql'
import firebase from '@/services/firebase'

const toast = useToast()

// const { executeMutation: signinUser } = useSigninUserMutation()

const signIn = async () => {
  await firebase.signinWithGoogle()
  // const result = await signinUser({})
  // if (result.error) {
  //   toast.add({
  //     severity: 'error',
  //     summary: 'Sign in',
  //     detail: result.error.message
  //   })
  // } else {
  //   router.push({ name: 'question' })
  // }
}
</script>
