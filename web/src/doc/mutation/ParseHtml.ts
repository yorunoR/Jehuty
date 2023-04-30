const MUTATION = /* GraphQL */ `
  mutation ParseHtml($url: String!) {
    parseHtml(url: $url) {
      document
    }
  }
`
export default MUTATION
