// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitModel _$CommitModelFromJson(Map<String, dynamic> json) => CommitModel(
      id: json['id'] as String? ?? '',
      oid: json['oid'] as String? ?? '',
      commitUrl: json['commitUrl'] as String? ?? '',
      message: json['message'] as String? ?? '',
      additions: json['additions'] as int? ?? 0,
      deletions: json['deletions'] as int? ?? 0,
      changedFilesIfAvailable: json['changedFilesIfAvailable'] as int? ?? 0,
      committer: json['committer'] == null
          ? const GitActorModel()
          : GitActorModel.fromJson(json['committer']),
      status: json['status'] == null
          ? const CommitStatusModel()
          : CommitStatusModel.fromJson(json['status']),
      history: json['history'] == null
          ? const CommitHistoryConnection()
          : CommitHistoryConnection.fromJson(json['history']),
      parents: json['parents'] == null
          ? const CommitConnection()
          : CommitConnection.fromJson(json['parents']),
    );

Map<String, dynamic> _$CommitModelToJson(CommitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oid': instance.oid,
      'commitUrl': instance.commitUrl,
      'message': instance.message,
      'additions': instance.additions,
      'deletions': instance.deletions,
      'changedFilesIfAvailable': instance.changedFilesIfAvailable,
      'committer': instance.committer.toJson(),
      'status': instance.status.toJson(),
      'history': instance.history.toJson(),
      'parents': instance.parents.toJson(),
    };
