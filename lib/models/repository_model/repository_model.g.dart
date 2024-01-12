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
      forkCount: json['forkCount'] as int? ?? 0,
      homepageUrl: json['homepageUrl'] as String? ?? '',
      viewerHasStarred: json['viewerHasStarred'] as bool? ?? false,
      owner: json['owner'] == null
          ? const RepositoryOwnerInterface()
          : RepositoryOwnerInterface.fromJson(json['owner']),
      primaryLanguage: json['primaryLanguage'] == null
          ? const LanguageModel()
          : LanguageModel.fromJson(json['primaryLanguage']),
      issues: json['issues'] == null
          ? const RepositoryIssuesConnection()
          : RepositoryIssuesConnection.fromJson(json['issues']),
      pullRequests: json['pullRequests'] == null
          ? const RepositoryPrsConnection()
          : RepositoryPrsConnection.fromJson(json['pullRequests']),
      discussions: json['discussions'] == null
          ? const RepositoryDiscussionsConnection()
          : RepositoryDiscussionsConnection.fromJson(json['discussions']),
    );

Map<String, dynamic> _$RepositoryModelToJson(RepositoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'descriptionHTML': instance.descriptionHTML,
      'stargazerCount': instance.stargazerCount,
      'forkCount': instance.forkCount,
      'homepageUrl': instance.homepageUrl,
      'viewerHasStarred': instance.viewerHasStarred,
      'owner': instance.owner.toJson(),
      'primaryLanguage': instance.primaryLanguage.toJson(),
      'issues': instance.issues.toJson(),
      'pullRequests': instance.pullRequests.toJson(),
      'discussions': instance.discussions.toJson(),
    };
