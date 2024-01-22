import 'package:github/models/commit_model/commit_model.dart';
import 'package:github/models/common_model/common_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commit_history_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CommitHistoryConnection {
  const CommitHistoryConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<CommitModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory CommitHistoryConnection.fromJson(json) {
    return _$CommitHistoryConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommitHistoryConnectionToJson(this);
  }
}
