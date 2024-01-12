import 'package:json_annotation/json_annotation.dart';

part 'issue_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class IssueModel {
  const IssueModel();

  factory IssueModel.fromJson(json) {
    return _$IssueModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IssueModelToJson(this);
  }
}
