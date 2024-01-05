// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListModel _$UserListModelFromJson(Map<String, dynamic> json) =>
    UserListModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      items: json['items'] == null
          ? const UserListItemsModel()
          : UserListItemsModel.fromJson(json['items']),
    );

Map<String, dynamic> _$UserListModelToJson(UserListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'items': instance.items.toJson(),
    };

UserListItemsModel _$UserListItemsModelFromJson(Map<String, dynamic> json) =>
    UserListItemsModel(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserListItemsModelToJson(UserListItemsModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
