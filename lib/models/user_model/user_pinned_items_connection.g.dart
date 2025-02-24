// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_pinned_items_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPinnedItemsConnection _$UserPinnedItemsConnectionFromJson(
        Map<String, dynamic> json) =>
    UserPinnedItemsConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserPinnedItemsConnectionToJson(
        UserPinnedItemsConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
