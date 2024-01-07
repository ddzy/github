
import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_starred_repositories_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserStarredRepositoriesConnection {
  const UserStarredRepositoriesConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final int totalCount;
  final List<RepositoryModel> nodes;
  final CommonConnectionPageInfoModel pageInfo;

  factory UserStarredRepositoriesConnection.fromJson(json) {
    return _$UserStarredRepositoriesConnectionFromJson(json); 
  }

  Map<String, dynamic> toJson() {
    return _$UserStarredRepositoriesConnectionToJson(this);
  }
}
