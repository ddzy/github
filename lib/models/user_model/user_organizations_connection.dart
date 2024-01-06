
import 'package:github/models/organization_model/organization_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_organizations_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserOrganizationsConnection {
  const UserOrganizationsConnection({
    this.totalCount = 0,
    this.nodes = const [],
  });

  final int totalCount;
  final List<OrganizationModel> nodes;

  factory UserOrganizationsConnection.fromJson(json) {
    return _$UserOrganizationsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserOrganizationsConnectionToJson(this);
  }
}

