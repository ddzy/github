import 'package:json_annotation/json_annotation.dart';

part 'pr_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class PrModel {
  const PrModel();

  factory PrModel.fromJson(json) {
    return _$PrModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PrModelToJson(this);
  }
}
