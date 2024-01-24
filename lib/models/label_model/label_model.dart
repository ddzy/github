import 'package:github/models/actor_model/actor_model.dart';
import 'package:github/models/issue_model/issue_connection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'label_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class LabelModel {
  const LabelModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.color = '',
    this.createdAt = '',
    this.isDefault = false,
    this.issues = const IssueConnection(),
    this.updatedAt = '',
  });

  final String id;
  final String name;
  final String description;
  final String color;
  final String createdAt;
  final bool isDefault;
  final IssueConnection issues;
  final String updatedAt;


  factory LabelModel.fromJson(json) {
    return _$LabelModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LabelModelToJson(this);
  }
}
