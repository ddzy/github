import 'package:github/models/repository_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list_model.g.dart';

/// [UserListModel] https://docs.github.com/zh/graphql/reference/objects#userlist
@JsonSerializable(explicitToJson: true)
class UserListModel {
  const UserListModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.items = const UserListItemsModel(),
  });

  final String id;
  final String name;
  final String description;
  final UserListItemsModel items;

  factory UserListModel.fromJson(json) {
    return _$UserListModelFromJson(json); 
  }

  Map<String, dynamic> toJson() {
    return _$UserListModelToJson(this);
  }
}

/// [UserListItemsModel] https://docs.github.com/zh/graphql/reference/unions#userlistitems
@JsonSerializable(explicitToJson: true)
class UserListItemsModel {
  const UserListItemsModel({
    this.totalCount = 0,
    this.nodes = const [],
  });

  final int totalCount;
  final List<RepositoryModel> nodes;

  factory UserListItemsModel.fromJson(json) {
    return _$UserListItemsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserListItemsModelToJson(this);
  }
}
