// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_history_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitHistoryConnection _$CommitHistoryConnectionFromJson(
        Map<String, dynamic> json) =>
    CommitHistoryConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(CommitModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$CommitHistoryConnectionToJson(
        CommitHistoryConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
