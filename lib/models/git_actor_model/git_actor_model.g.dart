// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_actor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitActorModel _$GitActorModelFromJson(Map<String, dynamic> json) =>
    GitActorModel(
      user: json['user'] == null
          ? const UserModel()
          : UserModel.fromJson(json['user']),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      date: json['date'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );

Map<String, dynamic> _$GitActorModelToJson(GitActorModel instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'name': instance.name,
      'email': instance.email,
      'date': instance.date,
      'avatarUrl': instance.avatarUrl,
    };
