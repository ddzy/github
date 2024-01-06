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
      descriptionHTML: json['descriptionHTML'] as String? ?? '',
      stargazerCount: json['stargazerCount'] as int? ?? 0,
      owner: json['owner'] == null
          ? const RepositoryOwnerInterface()
          : RepositoryOwnerInterface.fromJson(json['owner']),
      primaryLanguage: json['primaryLanguage'] == null
          ? const LanguageModel()
          : LanguageModel.fromJson(json['primaryLanguage']),
    );

Map<String, dynamic> _$RepositoryModelToJson(RepositoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'descriptionHTML': instance.descriptionHTML,
      'stargazerCount': instance.stargazerCount,
      'owner': instance.owner.toJson(),
      'primaryLanguage': instance.primaryLanguage.toJson(),
    };
