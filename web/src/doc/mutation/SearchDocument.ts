const MUTATION = /* GraphQL */ `
  mutation SearchDocument($question: String!, $storyId: ID!) {
    searchDocument(question: $question, storyId: $storyId) {
      answer
    }
  }
`
export default MUTATION
