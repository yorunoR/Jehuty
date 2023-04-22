const MUTATION = /* GraphQL */ `
  mutation SendQuestion($question: String!) {
    sendQuestion(question: $question) {
      answer
    }
  }
`
export default MUTATION
