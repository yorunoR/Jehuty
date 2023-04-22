<template>
  <main style="max-width: 768px; margin: auto">
    <h2>Question</h2>
    <section>
      <div class="text-left mt-6">
        <p><b>質問を入力してください</b></p>
      </div>
      <Textarea v-model="question" class="w-full p-3" :disabled="answer != ''" />
      <Button
        class="w-full mt-3"
        label="Submit"
        :disabled="question === '' || answer != ''"
        @click="clickSendQuestion"
      />
    </section>
    <hr class="my-5" />
    <section v-if="answer != ''" class="text-left">
      <div>
        <p><b>回答</b></p>
      </div>
      <p class="border-solid border-1 border-400 p-3" style="white-space: pre-wrap">
        {{ answer }}
      </p>
      <Button class="w-full mt-3" label="Save and Clear" @click="clickSaveHistory" />
      <Button class="w-full mt-2" label="Clear" @click="clear" />
    </section>
    <Dialog v-model:visible="visible" modal :closable="false" :style="{ width: '60vw' }">
      <div class="text-center pb-3">
        <b>問い合わせ中です</b>
      </div>
    </Dialog>
  </main>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useMutation } from '@urql/vue'
import { useToast } from 'primevue/usetoast'
import { graphql } from '@/gql'
import SendQuestion from '@/doc/mutation/SendQuestion'
import SaveHistory from '@/doc/mutation/SaveHistory'

const toast = useToast()

const question = ref('')
const answer = ref('')
const visible = ref(false)

const { executeMutation: sendQuestion } = useMutation(graphql(SendQuestion))
const { executeMutation: saveHistory } = useMutation(graphql(SaveHistory))

const clickSendQuestion = async () => {
  visible.value = true
  const res = await sendQuestion({
    question: question.value
  })
  if (res.error) {
    toast.add({
      severity: 'error',
      summary: 'Send Question',
      detail: res.error.message
    })
  }
  visible.value = false
  answer.value = res?.data?.sendQuestion?.answer ?? ''
}

const clickSaveHistory = async () => {
  const history = {
    question: question.value,
    answer: answer.value
  }
  const res = await saveHistory({ history })
  if (res.error) {
    toast.add({
      severity: 'error',
      summary: 'Save History',
      detail: res.error.message
    })
  } else {
    toast.add({
      severity: 'success',
      summary: 'Save History',
      detail: 'Histories のページで確認できます'
    })
    clear()
  }
}

const clear = () => {
  question.value = ''
  answer.value = ''
}
</script>
