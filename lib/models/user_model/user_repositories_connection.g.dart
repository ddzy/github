// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repositories_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRepositoriesConnection _$UserRepositoriesConnectionFromJson(
        Map<String, dynamic> json) =>
    UserRepositoriesConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserRepositoriesConnectionToJson(
        UserRepositoriesConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
