const QUERY = /* GraphQL */ `
  query UserStories {
    currentUser {
      id
      name
      email
      stories {
        id
        status
        title
        chunkSize
        insertedAt
      }
    }
  }
`
export default QUERY
