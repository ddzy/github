part of './commit.dart';

String getInfo() {
  return """ 
    query(\$name: String!, \$owner: String!, \$branch: String!, \$after: String) {
      repository(name: \$name, owner: \$owner) {
        ref(qualifiedName: \$branch) {
          target {
            ... on Commit {
              id
              message
              status {
                id
                state
              }
              committer {
                name
                avatarUrl
                date
              }
              history(first: 20, after: \$after) {
                pageInfo {
                  endCursor
                }
                nodes {
                  id
                  message
                  status {
                    id
                    state
                  }
                  committer {
                    name
                    avatarUrl
                    date
                  }
                }
              }
            }
          }
        }
      }
    }
  """;
}
