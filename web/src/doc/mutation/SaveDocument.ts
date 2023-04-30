const MUTATION = /* GraphQL */ `
  mutation SaveDocument($url: String!, $document: String!) {
    saveDocument(url: $url, document: $document) {
      status
    }
  }
`
export default MUTATION
