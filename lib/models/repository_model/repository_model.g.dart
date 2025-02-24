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
      stargazerCount: (json['stargazerCount'] as num?)?.toInt() ?? 0,
      forkCount: (json['forkCount'] as num?)?.toInt() ?? 0,
      homepageUrl: json['homepageUrl'] as String? ?? '',
      viewerHasStarred: json['viewerHasStarred'] as bool? ?? false,
      owner: json['owner'] == null
          ? const RepositoryOwnerInterface()
          : RepositoryOwnerInterface.fromJson(json['owner']),
      object: json['object'] == null
          ? const GitObjectInterface()
          : GitObjectInterface.fromJson(json['object']),
      primaryLanguage: json['primaryLanguage'] == null
          ? const LanguageModel()
          : LanguageModel.fromJson(json['primaryLanguage']),
      defaultBranchRef: json['defaultBranchRef'] == null
          ? const RefModel()
          : RefModel.fromJson(json['defaultBranchRef']),
      ref: json['ref'] == null
          ? const RefModel()
          : RefModel.fromJson(json['ref']),
      issues: json['issues'] == null
          ? const RepositoryIssuesConnection()
          : RepositoryIssuesConnection.fromJson(json['issues']),
      pullRequests: json['pullRequests'] == null
          ? const RepositoryPrsConnection()
          : RepositoryPrsConnection.fromJson(json['pullRequests']),
      discussions: json['discussions'] == null
          ? const RepositoryDiscussionsConnection()
          : RepositoryDiscussionsConnection.fromJson(json['discussions']),
      refs: json['refs'] == null
          ? const RepositoryRefsConnection()
          : RepositoryRefsConnection.fromJson(json['refs']),
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
      'object': instance.object.toJson(),
      'primaryLanguage': instance.primaryLanguage.toJson(),
      'defaultBranchRef': instance.defaultBranchRef.toJson(),
      'ref': instance.ref.toJson(),
      'issues': instance.issues.toJson(),
      'pullRequests': instance.pullRequests.toJson(),
      'discussions': instance.discussions.toJson(),
      'refs': instance.refs.toJson(),
    };
