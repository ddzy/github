part of 'starred.dart';

String getInfo() {
  return """
    query () {
      viewer {
        lists(last: 10) {
          totalCount
          nodes {
            id
            name
            items {
              totalCount
            }
          }
        }
        starredRepositories(last: 10) {
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
        }
      }
    }
  """;
}
