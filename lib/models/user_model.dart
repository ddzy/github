import 'package:github/models/organization_model.dart';
import 'package:github/models/repository_model.dart';
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
  final UserFollowModel followers;
  final UserFollowModel following;
  final UserStatusModel status;
  final UserPinnedItemsModel pinnedItems;
  final UserRepositoriesModel repositories;
  final UserOrganizationsModel organizations;
  final UserStarredRepositoriesModel starredRepositories;

  UserModel({
    this.login = '',
    this.id = '',
    this.avatarUrl = 'https://iph.href.lu/879x200?fg=666666&bg=cccccc',
    this.name = '',
    this.bio = '',
    this.company = '',
    this.location = '',
    this.websiteUrl = '',
    this.isDeveloperProgramMember = false,
    this.followers = const UserFollowModel(totalCount: 0),
    this.following = const UserFollowModel(totalCount: 0),
    this.status = const UserStatusModel(message: '', emoji: '', emojiHTML: ''),
    this.pinnedItems = const UserPinnedItemsModel(totalCount: 0, nodes: []),
    this.repositories = const UserRepositoriesModel(totalCount: 0, nodes: []),
    this.organizations = const UserOrganizationsModel(totalCount: 0, nodes: []),
    this.starredRepositories =
        const UserStarredRepositoriesModel(totalCount: 0, nodes: []),
  });

  factory UserModel.fromJson(json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class UserFollowModel {
  const UserFollowModel({required this.totalCount});

  final int totalCount;

  factory UserFollowModel.fromJson(json) {
    return _$UserFollowModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserFollowModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class UserStatusModel {
  const UserStatusModel(
      {required this.message, required this.emoji, required this.emojiHTML});

  final String message;
  final String emoji;
  final String emojiHTML;

  factory UserStatusModel.fromJson(json) {
    return _$UserStatusModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserStatusModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class UserPinnedItemsModel {
  const UserPinnedItemsModel({
    required this.totalCount,
    required this.nodes,
  });

  final int totalCount;
  final List<RepositoryModel> nodes;

  factory UserPinnedItemsModel.fromJson(json) {
    return _$UserPinnedItemsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserPinnedItemsModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class UserRepositoriesModel {
  const UserRepositoriesModel({
    required this.totalCount,
    required this.nodes,
  });

  final int totalCount;
  final List<RepositoryModel> nodes;

  factory UserRepositoriesModel.fromJson(json) {
    return _$UserRepositoriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserRepositoriesModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class UserOrganizationsModel {
  const UserOrganizationsModel({
    required this.totalCount,
    required this.nodes,
  });

  final int totalCount;
  final List<OrganizationModel> nodes;

  factory UserOrganizationsModel.fromJson(json) {
    return _$UserOrganizationsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserOrganizationsModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class UserStarredRepositoriesModel {
  const UserStarredRepositoriesModel({
    required this.totalCount,
    required this.nodes,
  });

  final int totalCount;
  final List<RepositoryModel> nodes;

  factory UserStarredRepositoriesModel.fromJson(json) {
    return _$UserStarredRepositoriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserStarredRepositoriesModelToJson(this);
  }
}
