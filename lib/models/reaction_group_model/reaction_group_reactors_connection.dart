import 'package:github/interfaces/reactor_interface.dart';
import 'package:github/models/common_model/common_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reaction_group_reactors_connection.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class ReactionGroupReactorsConnection {
  const ReactionGroupReactorsConnection({
    this.totalCount = 0,
    this.nodes = const [],
    this.pageInfo = const CommonConnectionPageInfoModel(),
  });

  final List<ReactorInterface> nodes;
  final int totalCount;
  final CommonConnectionPageInfoModel pageInfo;

  factory ReactionGroupReactorsConnection.fromJson(json) {
    return _$ReactionGroupReactorsConnectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReactionGroupReactorsConnectionToJson(this);
  }
}
