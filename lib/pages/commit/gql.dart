part of './commit.dart';

String getInfo() {
  return """ 
    query(\$id: ID!) {
      repository() {}
    }
  """;
}