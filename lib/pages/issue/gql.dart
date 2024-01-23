part of './issue.dart';

String getInfo() {
  return """ 
    query(\$login: String!) {
      user(login: \$login) {
        issues(last: 10) {
          nodes {
            number
            title
            repository {
              name
              owner {
                login
                avatarUrl
              }
            }
          }
        }
      }
    }
  """;
}
