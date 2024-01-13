import 'package:json_annotation/json_annotation.dart';

part 'blob_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class BlobModel {
  const BlobModel();

  factory BlobModel.fromJson(json) {
    return _$BlobModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BlobModelToJson(this);
  }
}