part of 'repo_detail.dart';

String getInfo() {
  return """ 
    query(\$id: ID!) {
      node(id: \$id) {
        ... on Repository {
          id
          name
          description
          owner {
            ... on User {
              id
              name: login
              avatarUrl
            }
            ... on Organization {
              id
              name
              avatarUrl
            }
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
