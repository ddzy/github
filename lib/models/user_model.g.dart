// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      login: json['login'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      avatar_url: json['avatar_url'] as String? ?? '',
      name: json['name'] as String? ??
          'https://iph.href.lu/879x200?fg=666666&bg=cccccc',
      bio: json['bio'] as String? ?? '',
      company: json['company'] as String? ?? '',
      location: json['location'] as String? ?? '',
      blog: json['blog'] as String? ?? '',
      followers: json['followers'] as int? ?? 0,
      following: json['following'] as int? ?? 0,
      plan: json['plan'] == null
          ? const UserPlanModel(name: '', private_repos: 0)
          : UserPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatar_url,
      'name': instance.name,
      'bio': instance.bio,
      'company': instance.company,
      'location': instance.location,
      'blog': instance.blog,
      'followers': instance.followers,
      'following': instance.following,
      'plan': instance.plan.toJson(),
    };

UserPlanModel _$UserPlanModelFromJson(Map<String, dynamic> json) =>
    UserPlanModel(
      name: json['name'] as String,
      private_repos: json['private_repos'] as int,
    );

Map<String, dynamic> _$UserPlanModelToJson(UserPlanModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'private_repos': instance.private_repos,
    };
