part of 'starred.dart';

String getInfo() {
  return """
    query (\$after: String) {
      viewer {
        lists(last: 100) {
          totalCount
          nodes {
            id
            name
            items {
              totalCount
            }
          }
        }
        starredRepositories(first: 10, orderBy: { direction: DESC, field: STARRED_AT }, after: \$after) {
          totalCount
          nodes {
            id
            name
            description
            descriptionHTML
            stargazerCount
            primaryLanguage {
              id
              name
              color
            }
            owner {
              ... on Organization {
                id
                name
                avatarUrl
              }
              ... on User {
                id
                name: login
                avatarUrl
              }
            }
          }
          pageInfo {
            endCursor
            hasNextPage
          }
        }
      }
    }
  """;
}
