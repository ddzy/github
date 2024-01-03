// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      login: json['login'] as String? ?? '',
      id: json['id'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ??
          'https://iph.href.lu/879x200?fg=666666&bg=cccccc',
      name: json['name'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      company: json['company'] as String? ?? '',
      location: json['location'] as String? ?? '',
      websiteUrl: json['websiteUrl'] as String? ?? '',
      isDeveloperProgramMember:
          json['isDeveloperProgramMember'] as bool? ?? false,
      followers: json['followers'] == null
          ? const UserFollowModel(totalCount: 0)
          : UserFollowModel.fromJson(json['followers']),
      following: json['following'] == null
          ? const UserFollowModel(totalCount: 0)
          : UserFollowModel.fromJson(json['following']),
      status: json['status'] == null
          ? const UserStatusModel(message: '', emoji: '', emojiHTML: '')
          : UserStatusModel.fromJson(json['status']),
      organizations: (json['organizations'] as List<dynamic>?)
              ?.map(OrganizationModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatarUrl': instance.avatarUrl,
      'name': instance.name,
      'bio': instance.bio,
      'company': instance.company,
      'location': instance.location,
      'websiteUrl': instance.websiteUrl,
      'isDeveloperProgramMember': instance.isDeveloperProgramMember,
      'followers': instance.followers.toJson(),
      'following': instance.following.toJson(),
      'status': instance.status.toJson(),
      'organizations': instance.organizations.map((e) => e.toJson()).toList(),
    };

UserFollowModel _$UserFollowModelFromJson(Map<String, dynamic> json) =>
    UserFollowModel(
      totalCount: json['totalCount'] as int,
    );

Map<String, dynamic> _$UserFollowModelToJson(UserFollowModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
    };

UserStatusModel _$UserStatusModelFromJson(Map<String, dynamic> json) =>
    UserStatusModel(
      message: json['message'] as String,
      emoji: json['emoji'] as String,
      emojiHTML: json['emojiHTML'] as String,
    );

Map<String, dynamic> _$UserStatusModelToJson(UserStatusModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'emoji': instance.emoji,
      'emojiHTML': instance.emojiHTML,
    };
