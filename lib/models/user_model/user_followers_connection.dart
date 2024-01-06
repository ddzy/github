import 'package:json_annotation/json_annotation.dart';

part  'user_followers_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserFollowersConnection {
  const UserFollowersConnection({this.totalCount = 0});

  final int totalCount;

  factory UserFollowersConnection.fromJson(json) {
    return _$UserFollowersConnectionFromJson(json); 
  }

  Map<String, dynamic> toJson() {
    return _$UserFollowersConnectionToJson(this);
  }
}
