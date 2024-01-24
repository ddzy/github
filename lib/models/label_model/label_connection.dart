import 'package:github/models/common_model/common_model.dart';
import 'package:github/models/label_model/label_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'label_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class LabelConnection {
  const LabelConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<LabelModel> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory LabelConnection.fromJson(json) {
    return _$LabelConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LabelConnectionToJson(this);
  }
}
