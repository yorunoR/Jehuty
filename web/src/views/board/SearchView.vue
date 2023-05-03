<template>
  <main style="max-width: 768px; margin: auto">
    <h2>Search</h2>
    <section v-if="error">
      {{ error }}
    </section>
    <section v-else-if="data">
      <div class="text-left mt-6">
        <p><b>調査対象を入力してください</b></p>
      </div>
      <Dropdown
        v-model="storyId"
        :options="data.currentUser.stories"
        option-value="id"
        option-label="title"
        placeholder="Select a Story"
        class="w-full text-left"
      />
      <div class="text-left mt-6">
        <p><b>質問を入力してください</b></p>
      </div>
      <Textarea v-model="question" class="w-full p-3" :disabled="answer != ''" />
      <Button
        class="w-full mt-3"
        label="Submit"
        :disabled="storyId == null || question === '' || answer != ''"
        @click="clickSearchDocument"
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
import { useQuery, useMutation } from '@urql/vue'
import { useToast } from 'primevue/usetoast'
import { graphql } from '@/gql'
import UserStories from '@/doc/query/UserStories'
import SearchDocument from '@/doc/mutation/SearchDocument'

const toast = useToast()

const storyId = ref(null)
const question = ref('')
const answer = ref('')
const visible = ref(false)

const query = graphql(UserStories)
const { data, error } = useQuery({
  query,
  context: { additionalTypenames: ['Story'] }
})

const { executeMutation: searchDocument } = useMutation(graphql(SearchDocument))

const clickSearchDocument = async () => {
  visible.value = true
  const res = await searchDocument({
    storyId: storyId.value,
    question: question.value
  })
  if (res.error) {
    toast.add({
      severity: 'error',
      summary: 'Search Document',
      detail: res.error.message
    })
  }
  visible.value = false
  answer.value = res?.data?.searchDocument?.answer ?? ''
}

const clear = () => {
  question.value = ''
  answer.value = ''
}
</script>
