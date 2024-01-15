import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/ref_model/ref_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository_refs_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class RepositoryRefsConnection {
  const RepositoryRefsConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<RefModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory RepositoryRefsConnection.fromJson(json) {
    return _$RepositoryRefsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepositoryRefsConnectionToJson(this);
  }
}
