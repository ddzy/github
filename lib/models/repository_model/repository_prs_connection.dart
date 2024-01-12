import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/issue_model/issue_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_prs_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class RepositoryPrsConnection {
  const RepositoryPrsConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<IssueModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory RepositoryPrsConnection.fromJson(json) {
    return _$RepositoryPrsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryPrsConnectionToJson(this);
  }
}
