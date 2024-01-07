// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_starred_repositories_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStarredRepositoriesConnection _$UserStarredRepositoriesConnectionFromJson(
        Map<String, dynamic> json) =>
    UserStarredRepositoriesConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$UserStarredRepositoriesConnectionToJson(
        UserStarredRepositoriesConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'pageInfo': instance.pageInfo.toJson(),
    };
