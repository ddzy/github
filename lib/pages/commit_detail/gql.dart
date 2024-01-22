part of './commit_detail.dart';

String getInfo() {
  return """ 
    query(\$id: ID!) {
      node(id: \$id) {
        ... on Commit {
          id
          oid
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
          additions
          deletions
          changedFilesIfAvailable
          commitUrl
          history(first: 2) {
            nodes {
              id
              message
            }
          }
          parents(first: 1) {
            totalCount
            nodes {
              id
              message
            }
          }
        }
      }
    }
  """;
}
