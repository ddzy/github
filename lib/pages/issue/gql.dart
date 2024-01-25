part of './issue.dart';

String getIssuesByUser() {
  return """ 
    query(\$login: String!, \$after: String, \$states: [IssueState!], \$orderBy: IssueOrder, \$filterBy: IssueFilters) {
      user(login: \$login) {
        issues(first: 20, after: \$after, states: \$states, orderBy: \$orderBy, filterBy: \$filterBy) {
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
    query(login: \$login, name: \$name, \$after: String, \$states: [IssueState!], \$orderBy: IssueOrder, \$filterBy: IssueFilters) {
      repository(owner: \$login, name: \$name) {
        issues(first: 20, after: \$after, states: \$states, orderBy: \$orderBy, filterBy: \$filterBy) {
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
