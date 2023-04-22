const MUTATION = /* GraphQL */ `
  mutation SaveHistory($history: InputHistory!) {
    saveHistory(history: $history) {
      id
    }
  }
`
export default MUTATION
