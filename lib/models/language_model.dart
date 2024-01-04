import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LanguageModel {
  const LanguageModel({
    this.id = '',
    this.color = '',
    this.name = '',
  });

  final String id;
  final String color;
  final String name;

  factory LanguageModel.fromJson(json) {
    return _$LanguageModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LanguageModelToJson(this);
  }
}
