String getInfo() {
  return """ 
    query(\$from) {
      viewer {
        issues(first: 5) {
          nodes {
            number
            title
          }
        }
        issueComments(first: 5) {
          nodes {
            body
            issue {
              comments() {
                totalCount
              }
            }
          }
        }
      }
    }
  """;
}
