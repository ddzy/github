import 'package:github/models/actor_model/actor_model.dart';
import 'package:github/models/label_model/label_connection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_state_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class IssueStateModel {
  const IssueStateModel({
    this.id = '',
    this.number = 0,
    this.author = const ActorModel(),
    this.title = '',
    this.body = '',
    this.createdAt = '',
    this.createdViaEmail = false,
    this.editor = const ActorModel(),
    this.labels = const LabelConnection(),
  });

  final String id;
  final int number;
  final ActorModel author;
  final String title;
  final String body;
  final String createdAt;
  final bool createdViaEmail;
  final ActorModel editor;
  final LabelConnection labels; 

  factory IssueStateModel.fromJson(json) {
    return _$IssueStateModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IssueStateModelToJson(this);
  }
}

