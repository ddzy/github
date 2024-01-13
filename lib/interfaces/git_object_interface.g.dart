// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_object_interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitObjectInterface _$GitObjectInterfaceFromJson(Map<String, dynamic> json) =>
    GitObjectInterface(
      id: json['id'] as String? ?? '',
      oid: json['oid'] as String? ?? '',
      commitUrl: json['commitUrl'] as String? ?? '',
      text: json['text'] as String? ?? '',
      byteSize: json['byteSize'] as int? ?? 0,
    );

Map<String, dynamic> _$GitObjectInterfaceToJson(GitObjectInterface instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oid': instance.oid,
      'commitUrl': instance.commitUrl,
      'text': instance.text,
      'byteSize': instance.byteSize,
    };
