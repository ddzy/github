part of 'create_user_list.dart';

String postUserList() {
  return """ 
    mutation(\$name: String!, \$description: String) {
      createUserList(
        input: {
          name: \$name,
          description: \$description,
        },
      ) {
      }
    }
  """;
}
