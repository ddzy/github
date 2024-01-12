// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_issues_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryIssuesConnection _$RepositoryIssuesConnectionFromJson(
        Map<String, dynamic> json) =>
    RepositoryIssuesConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(IssueModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$RepositoryIssuesConnectionToJson(
        RepositoryIssuesConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
