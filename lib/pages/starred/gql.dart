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
            descriptionHTML
            stargazerCount
            primaryLanguage {
              id
              name
              color
            }
            owner {
              id
              login
              avatarUrl
            }
          }
        }
      }
    }
  """;
}
