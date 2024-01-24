part of './issue.dart';

String getIssuesByUser() {
  return """ 
    query(\$login: String!, \$after: String) {
      user(login: \$login) {
        issues(first: 20, after: \$after) {
          nodes {
            number
            title
            state
            repository {
              name
              owner {
                login
                avatarUrl
              }
            }
          }
          pageInfo {
            endCursor
            startCursor
          }
        }
      }
    }
  """;
}

String getIssuesByRepo() {
  return """ 
    query(login: \$login, name: \$name, \$after: String) {
      repository(owner: \$login, name: \$name) {
        issues(first: 20, after: \$after) {
          nodes {
            number
            title
            state
            repository {
              name
              owner {
                login
                avatarUrl
              }
            }
          }
          pageInfo {
            endCursor
          }
        }
      }
    }
  """;
}
