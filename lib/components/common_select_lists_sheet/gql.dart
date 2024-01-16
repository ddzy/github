String getLists() {
  return """
    query() {
      viewer {
        lists(last: 20) {
          nodes {
            id
            name
            items(last: 20) {
              nodes {
                ... on Repository {
                  id
                }
              }
            }
          },
        }
      }
    }
  """;
}

String addIntoLists() {
  return """ 
    mutation(\$itemId: ID!, \$listIds: [ID!]!) {
      updateUserListsForItem(
        input: {
          itemId: \$itemId,
          listIds: \$listIds,
        }
      ) {}
    }
  """;
}
