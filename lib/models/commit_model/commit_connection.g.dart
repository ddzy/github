// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitConnection _$CommitConnectionFromJson(Map<String, dynamic> json) =>
    CommitConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(CommitModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$CommitConnectionToJson(CommitConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
