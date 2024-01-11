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
        }
      }
    }
  """;
}
