// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_refs_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryRefsConnection _$RepositoryRefsConnectionFromJson(
        Map<String, dynamic> json) =>
    RepositoryRefsConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes:
          (json['nodes'] as List<dynamic>?)?.map(RefModel.fromJson).toList() ??
              const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$RepositoryRefsConnectionToJson(
        RepositoryRefsConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
