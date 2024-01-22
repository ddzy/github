import 'package:github/models/commit_model/commit_model.dart';
import 'package:github/models/common_model/common_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commit_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CommitConnection {
  const CommitConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<CommitModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory CommitConnection.fromJson(json) {
    return _$CommitConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommitConnectionToJson(this);
  }
}
