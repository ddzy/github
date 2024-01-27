// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_group_reactors_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionGroupReactorsConnection _$ReactionGroupReactorsConnectionFromJson(
        Map<String, dynamic> json) =>
    ReactionGroupReactorsConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(ReactorInterface.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$ReactionGroupReactorsConnectionToJson(
        ReactionGroupReactorsConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'pageInfo': instance.pageInfo.toJson(),
    };
