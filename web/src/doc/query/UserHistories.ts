const QUERY = /* GraphQL */ `
  query UserHistories {
    currentUser {
      id
      name
      email
      histories {
        id
        question
        answer
        insertedAt
      }
    }
  }
`
export default QUERY
