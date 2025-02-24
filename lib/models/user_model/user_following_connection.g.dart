// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_following_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFollowingConnection _$UserFollowingConnectionFromJson(
        Map<String, dynamic> json) =>
    UserFollowingConnection(
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserFollowingConnectionToJson(
        UserFollowingConnection instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
    };
