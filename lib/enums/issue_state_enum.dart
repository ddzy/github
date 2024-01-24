import 'package:json_annotation/json_annotation.dart';

enum IssueStateEnum {
  @JsonValue('CLOSED')
  CLOSED,
  @JsonValue('OPEN')
  OPEN,
}
