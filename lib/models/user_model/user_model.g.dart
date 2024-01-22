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
          ? const UserFollowersConnection()
          : UserFollowersConnection.fromJson(json['followers']),
      following: json['following'] == null
          ? const UserFollowingConnection()
          : UserFollowingConnection.fromJson(json['following']),
      status: json['status'] == null
          ? const UserStatusModel()
          : UserStatusModel.fromJson(json['status']),
      pinnedItems: json['pinnedItems'] == null
          ? const UserPinnedItemsConnection()
          : UserPinnedItemsConnection.fromJson(json['pinnedItems']),
      repositories: json['repositories'] == null
          ? const UserRepositoriesConnection()
          : UserRepositoriesConnection.fromJson(json['repositories']),
      organizations: json['organizations'] == null
          ? const UserOrganizationsConnection()
          : UserOrganizationsConnection.fromJson(json['organizations']),
      starredRepositories: json['starredRepositories'] == null
          ? const UserStarredRepositoriesConnection()
          : UserStarredRepositoriesConnection.fromJson(
              json['starredRepositories']),
      lists: json['lists'] == null
          ? const UserListsConnection()
          : UserListsConnection.fromJson(json['lists']),
      issues: json['issues'] == null
          ? const IssueConnection()
          : IssueConnection.fromJson(json['issues']),
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
      'issues': instance.issues.toJson(),
    };
