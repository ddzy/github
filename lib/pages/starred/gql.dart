part of 'starred.dart';

String getInfo() {
  return """
    query (\$user: String!, \$after: String) {
      user(login: \$user) {
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

String deleteUserList() {
  return """
    mutation(\$listId: ID!) {
      deleteUserList(
        input: {
          listId: \$listId,
        }
      ) {

      }
    }
  """;
}