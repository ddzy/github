// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryModel _$RepositoryModelFromJson(Map<String, dynamic> json) =>
    RepositoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      stargazerCount: json['stargazerCount'] as int? ?? 0,
      owner: json['owner'] == null
          ? const RepositoryOwnerModel(
              id: '', name: '', avatarUrl: '', login: '')
          : RepositoryOwnerModel.fromJson(json['owner']),
      primaryLanguage: json['primaryLanguage'] == null
          ? const LanguageModel()
          : LanguageModel.fromJson(json['primaryLanguage']),
    );

Map<String, dynamic> _$RepositoryModelToJson(RepositoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'stargazerCount': instance.stargazerCount,
      'owner': instance.owner.toJson(),
      'primaryLanguage': instance.primaryLanguage.toJson(),
    };

RepositoryOwnerModel _$RepositoryOwnerModelFromJson(
        Map<String, dynamic> json) =>
    RepositoryOwnerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      login: json['login'] as String,
    );

Map<String, dynamic> _$RepositoryOwnerModelToJson(
        RepositoryOwnerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'login': instance.login,
    };