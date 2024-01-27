import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/issue_comment_model/issue_comment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_comment_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class IssueCommentConnection {
  const IssueCommentConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<IssueCommentModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory IssueCommentConnection.fromJson(json) {
    return _$IssueCommentConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IssueCommentConnectionToJson(this);
  }
}
