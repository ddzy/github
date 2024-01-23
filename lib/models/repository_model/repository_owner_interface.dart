
import 'package:json_annotation/json_annotation.dart';

part 'repository_owner_interface.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class RepositoryOwnerInterface {
  const RepositoryOwnerInterface({
    this.id = '',
    this.login = '',
    this.avatarUrl = '',
  });

  final String id;
  final String login;
  final String avatarUrl;

  factory RepositoryOwnerInterface.fromJson(json) {
    return _$RepositoryOwnerInterfaceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryOwnerInterfaceToJson(this);
  }
}