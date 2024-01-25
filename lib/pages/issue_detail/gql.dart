part of 'issue_detail.dart';

String getInfo() {
  return """ 
    query(\$owner: String!, \$name: String!, \$number: Int!) {
      repository(owner: \$owner, name: \$name) {
        issue(number: \$number) {
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
          comments(first: 10) {
            nodes {
              id
              author {
                login
                avatarUrl
              }
              createdAt
              bodyHTML
              reactionGroups {
                content
                reactors {
                  totalCount
                }
                viewerHasReacted
              }
            }
            pageInfo {
              endCursor
              startCursor
            }
          }
        }
      }
    }
  """;
}
