// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_object_interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitObjectInterface _$GitObjectInterfaceFromJson(Map<String, dynamic> json) =>
    GitObjectInterface(
      typeName: json['typeName'] as String? ?? '',
      id: json['id'] as String? ?? '',
      oid: json['oid'] as String? ?? '',
      commitUrl: json['commitUrl'] as String? ?? '',
      text: json['text'] as String? ?? '',
      byteSize: json['byteSize'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      committer: json['committer'] == null
          ? const GitActorModel()
          : GitActorModel.fromJson(json['committer']),
      history: json['history'] == null
          ? const CommitHistoryConnection()
          : CommitHistoryConnection.fromJson(json['history']),
      entries: (json['entries'] as List<dynamic>?)
              ?.map(TreeEntryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GitObjectInterfaceToJson(GitObjectInterface instance) =>
    <String, dynamic>{
      'typeName': instance.typeName,
      'id': instance.id,
      'oid': instance.oid,
      'commitUrl': instance.commitUrl,
      'text': instance.text,
      'byteSize': instance.byteSize,
      'message': instance.message,
      'committer': instance.committer.toJson(),
      'history': instance.history.toJson(),
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };
