// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_comment_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueCommentConnection _$IssueCommentConnectionFromJson(
        Map<String, dynamic> json) =>
    IssueCommentConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(IssueCommentModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$IssueCommentConnectionToJson(
        IssueCommentConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
