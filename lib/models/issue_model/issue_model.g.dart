// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueModel _$IssueModelFromJson(Map<String, dynamic> json) => IssueModel(
      id: json['id'] as String? ?? '',
      number: json['number'] as int? ?? 0,
      author: json['author'] == null
          ? const ActorModel()
          : ActorModel.fromJson(json['author']),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      createdViaEmail: json['createdViaEmail'] as bool? ?? false,
      editor: json['editor'] == null
          ? const ActorModel()
          : ActorModel.fromJson(json['editor']),
      labels: json['labels'] == null
          ? const LabelConnection()
          : LabelConnection.fromJson(json['labels']),
      state: $enumDecodeNullable(_$IssueStateEnumEnumMap, json['state']) ??
          IssueStateEnum.OPEN,
      repository: json['repository'] == null
          ? const RepositoryModel()
          : RepositoryModel.fromJson(json['repository']),
    );

Map<String, dynamic> _$IssueModelToJson(IssueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'author': instance.author.toJson(),
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdViaEmail': instance.createdViaEmail,
      'editor': instance.editor.toJson(),
      'labels': instance.labels.toJson(),
      'state': _$IssueStateEnumEnumMap[instance.state]!,
      'repository': instance.repository.toJson(),
    };

const _$IssueStateEnumEnumMap = {
  IssueStateEnum.CLOSED: 'CLOSED',
  IssueStateEnum.OPEN: 'OPEN',
};
