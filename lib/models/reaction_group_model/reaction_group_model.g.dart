// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionGroupModel _$ReactionGroupModelFromJson(Map<String, dynamic> json) =>
    ReactionGroupModel(
      viewerHasReacted: json['viewerHasReacted'] as bool? ?? false,
      content:
          $enumDecodeNullable(_$ReactionContentEnumEnumMap, json['content']) ??
              ReactionContentEnum.confused,
      reactors: json['reactors'] == null
          ? const ReactionGroupReactorsConnection()
          : ReactionGroupReactorsConnection.fromJson(json['reactors']),
    );

Map<String, dynamic> _$ReactionGroupModelToJson(ReactionGroupModel instance) =>
    <String, dynamic>{
      'viewerHasReacted': instance.viewerHasReacted,
      'content': _$ReactionContentEnumEnumMap[instance.content]!,
      'reactors': instance.reactors.toJson(),
    };

const _$ReactionContentEnumEnumMap = {
  ReactionContentEnum.confused: 'CONFUSED',
  ReactionContentEnum.eyes: 'EYES',
  ReactionContentEnum.heart: 'HEART',
  ReactionContentEnum.tada: 'HOORAY',
  ReactionContentEnum.grinning: 'LAUGH',
  ReactionContentEnum.rocket: 'ROCKET',
  ReactionContentEnum.thumbsdown: 'THUMBS_DOWN',
  ReactionContentEnum.thumbsup: 'THUMBS_UP',
};
