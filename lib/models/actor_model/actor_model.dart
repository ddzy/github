import 'package:json_annotation/json_annotation.dart';

part 'actor_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class ActorModel {
  const ActorModel({
    this.login = '',
    this.id = '',
    this.avatarUrl = '',
  });
  
  final String login;
  final String id;
  final String avatarUrl;

  factory ActorModel.fromJson(json) {
    return _$ActorModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ActorModelToJson(this);
  }
}
