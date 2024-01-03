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
        }
      }
    """;
  }
}

var $api = _Api();
