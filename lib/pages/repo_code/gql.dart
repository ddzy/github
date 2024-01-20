part of 'repo_code.dart';

String getInfo() {
  return """ 
    query(\$name: String!, \$owner: String!, \$expression: String!) {
      repository(name: \$name, owner: \$owner) {
        id
        name
        object(expression: \$expression) {
          typeName: __typename
          ... on Tree {
            entries {
              oid
              name
              path
              type
              extension
              language {
                id
                name
              }
              object {
                ... on Blob {
                  id
                  text
                }
              }
            }
          }
          ... on Blob {
            id
            text
          }
        }
      }
    }
  """;
}
