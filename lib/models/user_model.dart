import 'package:github/models/organization_model.dart';
import 'package:github/models/repository_model.dart';
import 'package:github/models/user_list_model.dart';
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
  final UserListsModel lists; 

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
    this.followers = const UserFollowModel(),
    this.following = const UserFollowModel(),
    this.status = const UserStatusModel(),
    this.pinnedItems = const UserPinnedItemsModel(),
    this.repositories = const UserRepositoriesModel(),
    this.organizations = const UserOrganizationsModel(),
    this.starredRepositories = const UserStarredRepositoriesModel(),
    this.lists = const UserListsModel(),
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
  const UserFollowModel({this.totalCount = 0});

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
  const UserStatusModel({
    this.message = '',
    this.emoji = '',
    this.emojiHTML = '',
  });

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
    this.totalCount = 0,
    this.nodes = const [],
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
    this.totalCount = 0,
    this.nodes = const [],
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
    this.totalCount = 0,
    this.nodes = const [],
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
    this.totalCount = 0,
    this.nodes = const [],
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

@JsonSerializable(explicitToJson: true)
class UserListsModel {
  const UserListsModel({
    this.totalCount = 0,
    this.nodes = const [],
  });

  final int totalCount;
  final List<UserListModel> nodes;

  factory UserListsModel.fromJson(json) {
    return _$UserListsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserListsModelToJson(this);
  }
}
