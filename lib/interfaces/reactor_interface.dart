import 'package:json_annotation/json_annotation.dart';

part 'reactor_interface.g.dart';

/// https://docs.github.com/zh/graphql/reference/unions#reactor
@JsonSerializable(
  explicitToJson: true,
)
class ReactorInterface {
  const ReactorInterface();

  /// [BotModel]

  /// [MannequinModel]

  /// [OrganizationModel]

  /// [UserModel]

  factory ReactorInterface.fromJson(json) {
    return _$ReactorInterfaceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReactorInterfaceToJson(this);
  }
}
