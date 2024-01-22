import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/issue_model/issue_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class IssueConnection {
  const IssueConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<IssueModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory IssueConnection.fromJson(json) {
    return _$IssueConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IssueConnectionToJson(this);
  }
}
