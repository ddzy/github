part of './home.dart';

String getInfo() {
  return """ 
    query() {
      viewer {
        id
        login
        avatarUrl
        name
      }
    }
  """;
}
