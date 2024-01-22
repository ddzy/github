// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitModel _$CommitModelFromJson(Map<String, dynamic> json) => CommitModel(
      id: json['id'] as String? ?? '',
      commitUrl: json['commitUrl'] as String? ?? '',
      message: json['message'] as String? ?? '',
      committer: json['committer'] == null
          ? const GitActorModel()
          : GitActorModel.fromJson(json['committer']),
      status: json['status'] == null
          ? const CommitStatusModel()
          : CommitStatusModel.fromJson(json['status']),
      history: json['history'] == null
          ? const CommitHistoryConnection()
          : CommitHistoryConnection.fromJson(json['history']),
    );

Map<String, dynamic> _$CommitModelToJson(CommitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commitUrl': instance.commitUrl,
      'message': instance.message,
      'committer': instance.committer.toJson(),
      'status': instance.status.toJson(),
      'history': instance.history.toJson(),
    };
