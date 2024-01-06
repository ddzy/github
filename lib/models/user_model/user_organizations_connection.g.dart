// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_organizations_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrganizationsConnection _$UserOrganizationsConnectionFromJson(
        Map<String, dynamic> json) =>
    UserOrganizationsConnection(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(OrganizationModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserOrganizationsConnectionToJson(
        UserOrganizationsConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
