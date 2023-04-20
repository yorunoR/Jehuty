<template>
  <div>
    <h1>This is a ping page</h1>
    <Button>PrimeVue Valid</Button>
    <section>
      <div v-if="fetching">Loading...</div>
      <div v-else-if="error">Oh no... {{ error }}</div>
      <div v-else>
        <p v-if="data">
          {{ data.ping }}
        </p>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { useQuery } from '@urql/vue'
import { graphql } from '@/gql'
import Ping from '@/doc/query/Ping'

const query = graphql(Ping)
const { fetching, error, data } = useQuery({ query })
</script>
