import 'package:github/models/actor_model/actor_model.dart';
import 'package:github/models/reaction_group_model/reaction_group_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_comment_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class IssueCommentModel {
  const IssueCommentModel({
    this.id = '',
    this.author = const ActorModel(),
    this.createdAt = '',
    this.bodyHTML = '',
    this.body = '',
    this.reactionGroups = const [],
  });

  final String id;
  final ActorModel author;
  final String createdAt;
  final String bodyHTML;
  final String body;
  final List<ReactionGroupModel> reactionGroups;

  factory IssueCommentModel.fromJson(json) {
    return _$IssueCommentModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IssueCommentModelToJson(this);
  }
}
