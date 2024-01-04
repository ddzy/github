class _Api {
  String getUser() {
    return """ 
      query() {
        viewer {
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
                  ... on Organization {
                    id
                    name
                    avatarUrl
                  }
                  ... on User {
                    id
                    name
                    avatarUrl
                    login
                  }
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
        }
      }
    """;
  }
}

var $api = _Api();
