// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      login: json['login'] as String? ?? '',
      id: json['id'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ??
          'https://iph.href.lu/879x200?fg=666666&bg=cccccc',
      name: json['name'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      company: json['company'] as String? ?? '',
      location: json['location'] as String? ?? '',
      websiteUrl: json['websiteUrl'] as String? ?? '',
      isDeveloperProgramMember:
          json['isDeveloperProgramMember'] as bool? ?? false,
      followers: json['followers'] == null
          ? const UserFollowModel()
          : UserFollowModel.fromJson(json['followers']),
      following: json['following'] == null
          ? const UserFollowModel()
          : UserFollowModel.fromJson(json['following']),
      status: json['status'] == null
          ? const UserStatusModel()
          : UserStatusModel.fromJson(json['status']),
      pinnedItems: json['pinnedItems'] == null
          ? const UserPinnedItemsModel()
          : UserPinnedItemsModel.fromJson(json['pinnedItems']),
      repositories: json['repositories'] == null
          ? const UserRepositoriesModel()
          : UserRepositoriesModel.fromJson(json['repositories']),
      organizations: json['organizations'] == null
          ? const UserOrganizationsModel()
          : UserOrganizationsModel.fromJson(json['organizations']),
      starredRepositories: json['starredRepositories'] == null
          ? const UserStarredRepositoriesModel()
          : UserStarredRepositoriesModel.fromJson(json['starredRepositories']),
      lists: json['lists'] == null
          ? const UserListsModel()
          : UserListsModel.fromJson(json['lists']),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatarUrl': instance.avatarUrl,
      'name': instance.name,
      'bio': instance.bio,
      'company': instance.company,
      'location': instance.location,
      'websiteUrl': instance.websiteUrl,
      'isDeveloperProgramMember': instance.isDeveloperProgramMember,
      'followers': instance.followers.toJson(),
      'following': instance.following.toJson(),
      'status': instance.status.toJson(),
      'pinnedItems': instance.pinnedItems.toJson(),
      'repositories': instance.repositories.toJson(),
      'organizations': instance.organizations.toJson(),
      'starredRepositories': instance.starredRepositories.toJson(),
      'lists': instance.lists.toJson(),
    };

UserFollowModel _$UserFollowModelFromJson(Map<String, dynamic> json) =>
    UserFollowModel(
      totalCount: json['totalCount'] as int? ?? 0,
    );

Map<String, dynamic> _$UserFollowModelToJson(UserFollowModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
    };

UserStatusModel _$UserStatusModelFromJson(Map<String, dynamic> json) =>
    UserStatusModel(
      message: json['message'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
      emojiHTML: json['emojiHTML'] as String? ?? '',
    );

Map<String, dynamic> _$UserStatusModelToJson(UserStatusModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'emoji': instance.emoji,
      'emojiHTML': instance.emojiHTML,
    };

UserPinnedItemsModel _$UserPinnedItemsModelFromJson(
        Map<String, dynamic> json) =>
    UserPinnedItemsModel(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserPinnedItemsModelToJson(
        UserPinnedItemsModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };

UserRepositoriesModel _$UserRepositoriesModelFromJson(
        Map<String, dynamic> json) =>
    UserRepositoriesModel(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserRepositoriesModelToJson(
        UserRepositoriesModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };

UserOrganizationsModel _$UserOrganizationsModelFromJson(
        Map<String, dynamic> json) =>
    UserOrganizationsModel(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(OrganizationModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserOrganizationsModelToJson(
        UserOrganizationsModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };

UserStarredRepositoriesModel _$UserStarredRepositoriesModelFromJson(
        Map<String, dynamic> json) =>
    UserStarredRepositoriesModel(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(RepositoryModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserStarredRepositoriesModelToJson(
        UserStarredRepositoriesModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };

UserListsModel _$UserListsModelFromJson(Map<String, dynamic> json) =>
    UserListsModel(
      totalCount: json['totalCount'] as int? ?? 0,
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map(UserListModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserListsModelToJson(UserListsModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };
