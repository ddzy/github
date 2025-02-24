// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelConnection _$LabelConnectionFromJson(Map<String, dynamic> json) =>
    LabelConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(LabelModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$LabelConnectionToJson(LabelConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
