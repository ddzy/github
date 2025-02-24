// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueStateModel _$IssueStateModelFromJson(Map<String, dynamic> json) =>
    IssueStateModel(
      id: json['id'] as String? ?? '',
      number: (json['number'] as num?)?.toInt() ?? 0,
      author: json['author'] == null
          ? const ActorModel()
          : ActorModel.fromJson(json['author']),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      createdViaEmail: json['createdViaEmail'] as bool? ?? false,
      editor: json['editor'] == null
          ? const ActorModel()
          : ActorModel.fromJson(json['editor']),
      labels: json['labels'] == null
          ? const LabelConnection()
          : LabelConnection.fromJson(json['labels']),
    );

Map<String, dynamic> _$IssueStateModelToJson(IssueStateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'author': instance.author.toJson(),
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'createdViaEmail': instance.createdViaEmail,
      'editor': instance.editor.toJson(),
      'labels': instance.labels.toJson(),
    };
