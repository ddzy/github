// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_lists_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListsConnection _$UserListsConnectionFromJson(Map<String, dynamic> json) =>
    UserListsConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(UserListModel.fromJson)
              .toList() ??
          const [],
      pageInfo: json['pageInfo'] == null
          ? const CommonConnectionPageInfoModel()
          : CommonConnectionPageInfoModel.fromJson(json['pageInfo']),
    );

Map<String, dynamic> _$UserListsConnectionToJson(
        UserListsConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'pageInfo': instance.pageInfo.toJson(),
    };
