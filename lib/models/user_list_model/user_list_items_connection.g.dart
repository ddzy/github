// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_items_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListItemsConnection _$UserListItemsConnectionFromJson(
        Map<String, dynamic> json) =>
    UserListItemsConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserListItemsConnectionToJson(
        UserListItemsConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
