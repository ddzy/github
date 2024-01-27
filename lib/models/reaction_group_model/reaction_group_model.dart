import 'package:github/enums/reaction_content_enum.dart';
import 'package:github/models/reaction_group_model/reaction_group_reactors_connection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reaction_group_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class ReactionGroupModel {
  const ReactionGroupModel({
    this.viewerHasReacted = false,
    this.content = ReactionContentEnum.confused,
    this.reactors = const ReactionGroupReactorsConnection(),
  });

  final bool viewerHasReacted;
  final ReactionContentEnum content;
  final ReactionGroupReactorsConnection reactors;

  factory ReactionGroupModel.fromJson(json) {
    return _$ReactionGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReactionGroupModelToJson(this);
  }
}
