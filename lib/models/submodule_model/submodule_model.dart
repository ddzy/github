import 'package:json_annotation/json_annotation.dart';

part 'submodule_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class SubmoduleModel {
  const SubmoduleModel({
    this.name = '',
  });

  final String name;

  factory SubmoduleModel.fromJson(json) {
    return _$SubmoduleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubmoduleModelToJson(this);
  }
}