// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_discussions_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryDiscussionsConnection _$RepositoryDiscussionsConnectionFromJson(
        Map<String, dynamic> json) =>
    RepositoryDiscussionsConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(DiscussionModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$RepositoryDiscussionsConnectionToJson(
        RepositoryDiscussionsConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
