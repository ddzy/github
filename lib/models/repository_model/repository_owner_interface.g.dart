// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_owner_interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryOwnerInterface _$RepositoryOwnerInterfaceFromJson(
        Map<String, dynamic> json) =>
    RepositoryOwnerInterface(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );

Map<String, dynamic> _$RepositoryOwnerInterfaceToJson(
        RepositoryOwnerInterface instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };
