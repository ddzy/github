import 'package:json_annotation/json_annotation.dart';

part 'user_status_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class UserStatusModel {
  const UserStatusModel({
    this.message = '',
    this.emoji = '',
    this.emojiHTML = '',
  });

  final String message;
  final String emoji;
  final String emojiHTML;

  factory UserStatusModel.fromJson(json) {
    return _$UserStatusModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserStatusModelToJson(this);
  }
}
