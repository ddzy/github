import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class TagModel {
  const TagModel();

  factory TagModel.fromJson(json) {
    return _$TagModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TagModelToJson(this);
  }
}