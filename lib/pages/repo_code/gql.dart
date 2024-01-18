part of 'repo_code.dart';

String getInfo() {
  return """ 
    query(\$id: ID!, \$expression: String!) {
      node(id: \$id) {
        ... on Repository {
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
    }
  """;
}
