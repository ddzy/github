part of './repo.dart';

String getInfo() {
  return """ 
    query(\$user: String!, \$isArchived: Boolean, \$isFork: Boolean, \$visibility: RepositoryVisibility) {
      user(login: \$user) {
        repositories(last: 50, isArchived: \$isArchived, isFork: \$isFork, visibility: \$visibility) {
          nodes {
            id
            name
            owner {
              login
              avatarUrl
            }
          }
        }
      }
    }
  """;
}
