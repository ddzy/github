import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/issue_model/issue_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_issues_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class RepositoryIssuesConnection {
  const RepositoryIssuesConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<IssueModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory RepositoryIssuesConnection.fromJson(json) {
    return _$RepositoryIssuesConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryIssuesConnectionToJson(this);
  }
}
