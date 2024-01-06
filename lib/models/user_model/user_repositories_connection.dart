
import 'package:github/models/repository_model/repository_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_repositories_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRepositoriesConnection {
  const UserRepositoriesConnection({
    this.totalCount = 0,
    this.nodes = const [],
  });

  final int totalCount;
  final List<RepositoryModel> nodes;

  factory UserRepositoriesConnection.fromJson(json) {
    return _$UserRepositoriesConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserRepositoriesConnectionToJson(this);
  }
}
