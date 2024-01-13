import 'package:json_annotation/json_annotation.dart';

part 'tree_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class TreeModel {
  const TreeModel();

  factory TreeModel.fromJson(json) {
    return _$TreeModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TreeModelToJson(this);
  }
}