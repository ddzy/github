part of './commit_detail.dart';

String getInfo() {
  return """ 
    query(\$id: ID!) {
      node(id: \$id) {
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
          additions
          deletions
          changedFilesIfAvailable
          commitUrl
        }
      }
    }
  """;
}
