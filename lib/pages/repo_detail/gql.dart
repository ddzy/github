part of 'repo_detail.dart';

String getInfo() {
  return """ 
    query(\$name: String!, \$owner: String!, \$expression: String!) {
      repository(name: \$name, owner: \$owner) {
        id
        name
        description
        owner {
          id
          login
          avatarUrl
        }
        homepageUrl
        forkCount
        stargazerCount
        viewerHasStarred
        issues {
          totalCount
        }
        pullRequests {
          totalCount
        }
        discussions {
          totalCount
        }
        defaultBranchRef {
          id
          name
          prefix
        }
        object(expression: \$expression) {
          id
          oid
          ... on Blob {
            text
            byteSize
          }
        }
      }
    }
  """;
}

String postStar() {
  return """ 
    mutation(\$id: ID!) {
      addStar(
        input: {
          starrableId: \$id
        }
      ) {
      }
    }
  """;
}

String postUnstar() {
  return """ 
    mutation(\$id: ID!) {
      removeStar(
        input: {
          starrableId: \$id
        }
      ) {}
    }
  """;
}

String getBranches() {
  return """
    query(\$name: String!, \$owner: String!, \$query: String!) {
      repository(name: \$name, owner: \$owner) {
        defaultBranchRef {
          id
          name
        }
        refs(last: 50, refPrefix: "refs/heads/", query: \$query) {
          nodes {
            id
            name
          }
        }
      }
    }
  """;
}
