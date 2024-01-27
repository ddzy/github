import 'package:json_annotation/json_annotation.dart';

enum ReactionContentEnum {
  @JsonValue('CONFUSED')
  confused,
  @JsonValue('EYES')
  eyes,
  @JsonValue('HEART')
  heart,
  @JsonValue('HOORAY')
  tada,
  @JsonValue('LAUGH')
  grinning,
  @JsonValue('ROCKET')
  rocket,
  @JsonValue('THUMBS_DOWN')
  thumbsdown,
  @JsonValue('THUMBS_UP')
  thumbsup,
}
