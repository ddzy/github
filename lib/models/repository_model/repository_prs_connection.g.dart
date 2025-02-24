// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_prs_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryPrsConnection _$RepositoryPrsConnectionFromJson(
        Map<String, dynamic> json) =>
    RepositoryPrsConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(IssueModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$RepositoryPrsConnectionToJson(
        RepositoryPrsConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
