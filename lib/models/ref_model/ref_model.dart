import 'package:github/interfaces/git_object_interface.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ref_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class RefModel {
  const RefModel({
    this.id = '',
    this.name = '',
    this.prefix = '',
    this.target = const GitObjectInterface(),
  });

  final String id;
  final String name;
  final String prefix;
  final GitObjectInterface target;

  factory RefModel.fromJson(json) {
    return _$RefModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RefModelToJson(this);
  }
}
