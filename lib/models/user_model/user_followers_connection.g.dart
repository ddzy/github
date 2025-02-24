// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_followers_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFollowersConnection _$UserFollowersConnectionFromJson(
        Map<String, dynamic> json) =>
    UserFollowersConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserFollowersConnectionToJson(
        UserFollowersConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
    };
