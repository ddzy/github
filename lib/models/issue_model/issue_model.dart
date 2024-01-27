import 'package:github/enums/issue_state_enum.dart';
import 'package:github/models/actor_model/actor_model.dart';
import 'package:github/models/issue_comment_model/issue_comment_connection.dart';
import 'package:github/models/label_model/label_connection.dart';
import 'package:github/models/repository_model/repository_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class IssueModel {
  const IssueModel({
    this.id = '',
    this.number = 0,
    this.author = const ActorModel(),
    this.title = '',
    this.body = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.createdViaEmail = false,
    this.editor = const ActorModel(),
    this.labels = const LabelConnection(),
    this.state = IssueStateEnum.open,
    this.repository = const RepositoryModel(),
    this.comments = const IssueCommentConnection(),
  });

  final String id;
  final int number;
  final ActorModel author;
  final String title;
  final String body;
  final String createdAt;
  final String updatedAt;
  final bool createdViaEmail;
  final ActorModel editor;
  final LabelConnection labels;
  final IssueStateEnum state;
  final RepositoryModel repository;
  final IssueCommentConnection comments;

  factory IssueModel.fromJson(json) {
    return _$IssueModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IssueModelToJson(this);
  }
}
