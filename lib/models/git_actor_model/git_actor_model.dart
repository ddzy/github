import 'package:github/models/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_actor_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class GitActorModel {
  const GitActorModel({
    this.user = const UserModel(),
    this.name = '',
    this.email = '',
    this.date = '',
    this.avatarUrl = '',
  });

  final UserModel user;
  final String name;
  final String email;
  final String date;
  final String avatarUrl;

  factory GitActorModel.fromJson(json) {
    return _$GitActorModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GitActorModelToJson(this);
  }
}
