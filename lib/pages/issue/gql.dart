part of './issue.dart';

String getIssuesByUser() {
  return """ 
    query(\$login: String!, \$after: String, \$states: [IssueState!], \$orderBy: IssueOrder) {
      user(login: \$login) {
        issues(first: 20, after: \$after, states: \$states, orderBy: \$orderBy) {
          nodes {
            number
            title
            state
            createdAt
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
    query(login: \$login, name: \$name, \$after: String, \$states: [IssueState!], \$orderBy: IssueOrder) {
      repository(owner: \$login, name: \$name) {
        issues(first: 20, after: \$after, states: \$states, orderBy: \$orderBy) {
          nodes {
            number
            title
            state
            createdAt
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
