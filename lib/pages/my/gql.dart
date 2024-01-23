part of 'my.dart';

String genGql() {
  return """ 
      query getUser(\$user: String!) {
        user(login: \$user) {
          id
          login
          avatarUrl
          name
          bio
          company
          location
          websiteUrl
          followers {
            totalCount
          }
          following {
            totalCount
          }
          isDeveloperProgramMember
          status {
            message
            emoji
            emojiHTML
          }
          pinnedItems(first: 20) {
            totalCount
            nodes {
              ... on Repository {
                id
                name
                description
                owner {
                  id
                  login
                  avatarUrl
                }
                stargazerCount
                primaryLanguage {
                  id
                  color
                  name
                }
              }
            }
          }
          repositories(last: 0) {
            totalCount
            nodes {}
          }
          organizations(last: 0) {
            totalCount
            nodes {}
          }
          starredRepositories(last: 0) {
            totalCount
            nodes {}
          }
        }
      }
    """;
}
