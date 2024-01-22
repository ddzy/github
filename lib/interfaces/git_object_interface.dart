import 'package:github/models/blob_model/blob_model.dart';
import 'package:github/models/commit_model/commit_connection.dart';
import 'package:github/models/commit_model/commit_history_connection.dart';
import 'package:github/models/commit_model/commit_model.dart';
import 'package:github/models/git_actor_model/git_actor_model.dart';
import 'package:github/models/tag_model/tag_model.dart';
import 'package:github/models/tree_entry_model/tree_entry_model.dart';
import 'package:github/models/tree_model/tree_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_object_interface.g.dart';

/// https://docs.github.com/zh/graphql/reference/interfaces#gitobject
@JsonSerializable(
  explicitToJson: true,
)
class GitObjectInterface {
  const GitObjectInterface({
    this.typeName = '',
    this.id = '',
    this.oid = '',
    this.commitUrl = '',
    this.text = '',
    this.byteSize = 0,
    this.message = '',
    this.additions = 0,
    this.deletions = 0,
    this.changedFilesIfAvailable = 0,
    this.committer = const GitActorModel(),
    this.history = const CommitHistoryConnection(),
    this.parents = const CommitConnection(),
    this.entries = const [],
  });

  final String typeName;
  final String id;
  final String oid;
  final String commitUrl;

  /// [BlobModel]

  final String text;
  final int byteSize;

  /// [CommitModel]
  final String message;
  final int additions;
  final int deletions;
  final int changedFilesIfAvailable;
  final GitActorModel committer;
  final CommitHistoryConnection history;
  final CommitConnection parents;

  /// [TagModel]

  /// [TreeModel]
  final List<TreeEntryModel> entries;

  factory GitObjectInterface.fromJson(json) {
    return _$GitObjectInterfaceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GitObjectInterfaceToJson(this);
  }
}
