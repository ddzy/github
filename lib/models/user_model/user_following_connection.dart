import 'package:json_annotation/json_annotation.dart';

part 'user_following_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserFollowingConnection {
  const UserFollowingConnection({this.totalCount = 0});

  final int totalCount;

  factory UserFollowingConnection.fromJson(json) {
    return _$UserFollowingConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserFollowingConnectionToJson(this);
  }
}
