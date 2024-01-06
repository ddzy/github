
import 'package:github/models/repository_model/repository_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list_items_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserListItemsConnection {
  const UserListItemsConnection({
    this.totalCount = 0,
    this.nodes = const [],
  });

  final int totalCount;
  final List<RepositoryModel> nodes;

  factory UserListItemsConnection.fromJson(json) {
    return _$UserListItemsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserListItemsConnectionToJson(this);
  }
}