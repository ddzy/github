import 'package:json_annotation/json_annotation.dart';

part 'organization_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class OrganizationModel {
  OrganizationModel({
    this.id = '',
    this.name = '',
    this.avatarUrl = ''
  });

  final String id;
  final String name;
  final String avatarUrl;

    factory OrganizationModel.fromJson(json) {
    return _$OrganizationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrganizationModelToJson(this);
  }
}