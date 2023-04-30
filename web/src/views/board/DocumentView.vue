<template>
  <main style="max-width: 768px; margin: auto">
    <h2>Document</h2>
    <section>
      <div class="text-left mt-6">
        <p><b>URLを入力してください</b></p>
      </div>
      <InputText v-model="url" class="w-full p-3" :disabled="doc != ''" />
      <Button
        class="w-full mt-3"
        label="Submit"
        :disabled="url === '' || doc != ''"
        @click="clickParseHtml"
      />
    </section>
    <hr class="my-5" />
    <section v-if="doc != ''" class="text-left">
      <div>
        <p><b>内容</b></p>
      </div>
      <p class="border-solid border-1 border-400 p-3" style="white-space: pre-wrap">
        {{ doc }}
      </p>
      <Button class="w-full mt-3" label="Save and Clear" @click="clickSaveDocument" />
      <Button class="w-full mt-2" label="Clear" @click="clear" />
    </section>
    <Dialog v-model:visible="visible" modal :closable="false" :style="{ width: '60vw' }">
      <div class="text-center pb-3">
        <b>確認中です</b>
      </div>
    </Dialog>
  </main>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useMutation } from '@urql/vue'
import { useToast } from 'primevue/usetoast'
import { graphql } from '@/gql'
import ParseHtml from '@/doc/mutation/ParseHtml'
import SaveDocument from '@/doc/mutation/SaveDocument'

const toast = useToast()

const url = ref('')
const doc = ref('')
const visible = ref(false)

const { executeMutation: parseHtml } = useMutation(graphql(ParseHtml))
const { executeMutation: saveDocument } = useMutation(graphql(SaveDocument))

const clickParseHtml = async () => {
  visible.value = true
  const res = await parseHtml({
    url: url.value
  })
  if (res.error) {
    toast.add({
      severity: 'error',
      summary: 'Parse HTML',
      detail: res.error.message
    })
  }
  visible.value = false
  doc.value = res?.data?.parseHtml?.document ?? ''
}

const clickSaveDocument = async () => {
  const res = await saveDocument({
    url: url.value,
    document: doc.value
  })
  if (res.error) {
    toast.add({
      severity: 'error',
      summary: 'Save Document',
      detail: res.error.message
    })
  } else {
    toast.add({
      severity: 'success',
      summary: 'Save Document',
      detail: 'Document を学習しました'
    })
    clear()
  }
}

const clear = () => {
  url.value = ''
  doc.value = ''
}
</script>
