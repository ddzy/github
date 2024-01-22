// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitStatusModel _$CommitStatusModelFromJson(Map<String, dynamic> json) =>
    CommitStatusModel(
      id: json['id'] as String? ?? '',
      state: $enumDecodeNullable(_$ICommitStatusStateEnumMap, json['state']) ??
          ICommitStatusState.EXPECTED,
    );

Map<String, dynamic> _$CommitStatusModelToJson(CommitStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': _$ICommitStatusStateEnumMap[instance.state]!,
    };

const _$ICommitStatusStateEnumMap = {
  ICommitStatusState.ERROR: 'ERROR',
  ICommitStatusState.EXPECTED: 'EXPECTED',
  ICommitStatusState.FAILURE: 'FAILURE',
  ICommitStatusState.PENDING: 'PENDING',
  ICommitStatusState.SUCCESS: 'SUCCESS',
};
