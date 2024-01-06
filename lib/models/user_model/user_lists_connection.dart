
import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/user_list_model/user_list_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_lists_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserListsConnection {
  const UserListsConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(), 
  });

  final int totalCount;
  final List<UserListModel> nodes;
  final CommonConnectionPageInfoModel pageInfo;

  factory UserListsConnection.fromJson(json) {
    return _$UserListsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserListsConnectionToJson(this);
  }
}