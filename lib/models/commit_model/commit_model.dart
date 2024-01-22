import 'package:github/models/commit_model/commit_history_connection.dart';
import 'package:github/models/commit_status_model/commit_status_model.dart';
import 'package:github/models/git_actor_model/git_actor_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commit_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CommitModel {
  const CommitModel({
    this.id = '',
    this.commitUrl = '',
    this.message = '',
    this.additions = 0,
    this.deletions = 0,
    this.changedFilesIfAvailable = 0,
    this.committer = const GitActorModel(),
    this.status = const CommitStatusModel(),
    this.history = const CommitHistoryConnection(),
  });

  final String id;
  final String commitUrl;
  final String message;
  final int additions;
  final int deletions;
  final int changedFilesIfAvailable;
  final GitActorModel committer;
  final CommitStatusModel status;
  final CommitHistoryConnection history;

  factory CommitModel.fromJson(json) {
    return _$CommitModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CommitModelToJson(this);
  }
}