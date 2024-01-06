// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatusModel _$UserStatusModelFromJson(Map<String, dynamic> json) =>
    UserStatusModel(
      message: json['message'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
      emojiHTML: json['emojiHTML'] as String? ?? '',
    );

Map<String, dynamic> _$UserStatusModelToJson(UserStatusModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'emoji': instance.emoji,
      'emojiHTML': instance.emojiHTML,
    };
