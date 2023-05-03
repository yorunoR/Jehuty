const MUTATION = /* GraphQL */ `
  mutation ParseHtml($url: String!, $selector: String!) {
    parseHtml(url: $url, selector: $selector) {
      document
    }
  }
`
export default MUTATION
