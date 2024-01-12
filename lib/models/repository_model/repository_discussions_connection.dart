import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/discussion_model/discussion_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_discussions_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class RepositoryDiscussionsConnection {
  const RepositoryDiscussionsConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<DiscussionModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory RepositoryDiscussionsConnection.fromJson(json) {
    return _$RepositoryDiscussionsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryDiscussionsConnectionToJson(this);
  }
}
