import 'package:json_annotation/json_annotation.dart';

part 'common_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CommonConnectionPageInfoModel {
  const CommonConnectionPageInfoModel({
    this.endCursor = '',
    this.hasNextPage = false,
    this.hasPreviousPage = false,
    this.startCursor = '',
  });

  final String endCursor;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String startCursor;

  factory CommonConnectionPageInfoModel.fromJson(json) {
    return _$CommonConnectionPageInfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommonConnectionPageInfoModelToJson(this);
  }
}
