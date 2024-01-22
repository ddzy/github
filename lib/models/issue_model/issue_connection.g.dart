// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueConnection _$IssueConnectionFromJson(Map<String, dynamic> json) =>
    IssueConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(IssueModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$IssueConnectionToJson(IssueConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
