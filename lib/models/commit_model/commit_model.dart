import 'package:json_annotation/json_annotation.dart';

part 'commit_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CommitModel {
  const CommitModel();

  factory CommitModel.fromJson(json) {
    return _$CommitModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommitModelToJson(this);
  }
}