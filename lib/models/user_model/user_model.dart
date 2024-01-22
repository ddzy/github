import 'package:github/models/issue_model/issue_connection.dart';
import 'package:github/models/user_model/user_followers_connection.dart';
import 'package:github/models/user_model/user_following_connection.dart';
import 'package:github/models/user_model/user_lists_connection.dart';
import 'package:github/models/user_model/user_organizations_connection.dart';
import 'package:github/models/user_model/user_pinned_items_connection.dart';
import 'package:github/models/user_model/user_repositories_connection.dart';
import 'package:github/models/user_model/user_starred_repositories_connection.dart';
import 'package:github/models/user_status_model/user_status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// [UserModel] https://docs.github.com/zh/graphql/reference/objects#user
@JsonSerializable(
  explicitToJson: true,
)
class UserModel {
  final String login;
  final String id;
  final String avatarUrl;
  final String name;
  final String bio;
  final String company;
  final String location;
  final String websiteUrl;
  final bool isDeveloperProgramMember;
  final UserFollowersConnection followers;
  final UserFollowingConnection following;
  final UserStatusModel status;
  final UserPinnedItemsConnection pinnedItems;
  final UserRepositoriesConnection repositories;
  final UserOrganizationsConnection organizations;
  final UserStarredRepositoriesConnection starredRepositories;
  final UserListsConnection lists;
  final IssueConnection issues;

  const UserModel({
    this.login = '',
    this.id = '',
    this.avatarUrl = 'https://iph.href.lu/879x200?fg=666666&bg=cccccc',
    this.name = '',
    this.bio = '',
    this.company = '',
    this.location = '',
    this.websiteUrl = '',
    this.isDeveloperProgramMember = false,
    this.followers = const UserFollowersConnection(),
    this.following = const UserFollowingConnection(),
    this.status = const UserStatusModel(),
    this.pinnedItems = const UserPinnedItemsConnection(),
    this.repositories = const UserRepositoriesConnection(),
    this.organizations = const UserOrganizationsConnection(),
    this.starredRepositories = const UserStarredRepositoriesConnection(),
    this.lists = const UserListsConnection(),
    this.issues = const IssueConnection(),
  });

  factory UserModel.fromJson(json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}
