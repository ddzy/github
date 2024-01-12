import 'package:json_annotation/json_annotation.dart';

part 'discussion_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DiscussionModel {
  const DiscussionModel();

  factory DiscussionModel.fromJson(json) {
    return _$DiscussionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DiscussionModelToJson(this);
  }
}
