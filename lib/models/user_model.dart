import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';       

@JsonSerializable(
  explicitToJson: true,
)
class UserModel {
  final String login;
  final int id;
  final String avatar_url;
  final String name;
  final String bio;
  @JsonKey(defaultValue: '')
  final String company;
  @JsonKey(defaultValue: '')
  final String location;
  @JsonKey(defaultValue: '')
  final String blog;
  @JsonKey(defaultValue: 0)
  final int followers;
  @JsonKey(defaultValue: 0)
  final int following;
  final UserPlanModel plan;

  const UserModel({
    required this.login,
    required this.id,
    required this.avatar_url,
    required this.name,
    required this.bio,
    required this.company,
    required this.location,
    required this.blog,
    required this.followers,
    required this.following,
    required this.plan,  
  });

  factory UserModel.fromJson(json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}

@JsonSerializable(
  explicitToJson: true,
)
class UserPlanModel {
  const UserPlanModel({required this.name, required this.private_repos});

  final String name;
  final int private_repos;

  factory UserPlanModel.fromJson(Map<String, dynamic> json) =>
      _$UserPlanModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserPlanModelToJson(this);
}
