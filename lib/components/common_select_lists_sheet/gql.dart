String getLists() {
  return """
    query() {
      viewer {
        lists(last: 10) {
          nodes {
            id
            name
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
