import 'package:github/models/repository_model/repository_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_pinned_items_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPinnedItemsConnection {
  const UserPinnedItemsConnection({
    this.totalCount = 0,
    this.nodes = const [],
  });

  final int totalCount;
  final List<RepositoryModel> nodes;

  factory UserPinnedItemsConnection.fromJson(json) {
    return _$UserPinnedItemsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserPinnedItemsConnectionToJson(this);
  }
}
