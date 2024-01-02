import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class UserModel {
  @JsonKey(defaultValue: '')
  final String login;
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String avatar_url;
  @JsonKey(defaultValue: 'https://iph.href.lu/879x200?fg=666666&bg=cccccc')
  final String name;
  @JsonKey(defaultValue: '')
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
  @JsonKey()
  final UserPlanModel plan;

  UserModel(
      {this.login = '',
      this.id = 0,
      this.avatar_url = 'https://iph.href.lu/879x200?fg=666666&bg=cccccc',
      this.name = '',
      this.bio = '',
      this.company = '',
      this.location = '',
      this.blog = '',
      this.followers = 0,
      this.following = 0,
      this.plan = const UserPlanModel(name: '', private_repos: 0)});

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
