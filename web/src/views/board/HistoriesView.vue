<template>
  <main style="max-width: 768px; margin: auto">
    <h2>Histories</h2>
    <section v-if="error">
      {{ error }}
    </section>
    <section v-else-if="data" class="text-left mt-6">
      <div
        v-for="history in data.currentUser.histories"
        :key="history.id"
        class="border-solid border-1 border-700 p-3 mt-4"
      >
        <div class="text-xs">保存日時: {{ history.insertedAt }}</div>
        <hr />
        <div class="my-3">
          <b>■ 質問</b>
          <br />
          <span class="mt-1">{{ history.question }}</span>
        </div>
        <hr />
        <div class="my-3" style="white-space: pre-wrap">
          <b>■ 回答</b>
          <br />
          <span class="mt-1">{{ history.answer }}</span>
        </div>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import { useQuery } from '@urql/vue'
import { graphql } from '@/gql'
import UserHistories from '@/doc/query/UserHistories'

const query = graphql(UserHistories)
const { data, error } = useQuery({
  query,
  context: { additionalTypenames: ['History'] }
})
</script>
