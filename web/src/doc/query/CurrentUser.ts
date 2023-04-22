const QUERY = /* GraphQL */ `
  query CurrentUser {
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
