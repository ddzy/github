import 'package:github/models/user_list_model/user_list_items_connection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list_model.g.dart';

/// [UserListModel] https://docs.github.com/zh/graphql/reference/objects#userlist
@JsonSerializable(explicitToJson: true)
class UserListModel {
  const UserListModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.items = const UserListItemsConnection(),
  });

  final String id;
  final String name;
  final String description;
  final UserListItemsConnection items;

  factory UserListModel.fromJson(json) {
    return _$UserListModelFromJson(json); 
  }

  Map<String, dynamic> toJson() {
    return _$UserListModelToJson(this);
  }
}

