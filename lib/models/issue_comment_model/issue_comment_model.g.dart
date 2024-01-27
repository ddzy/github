// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueCommentModel _$IssueCommentModelFromJson(Map<String, dynamic> json) =>
    IssueCommentModel(
      id: json['id'] as String? ?? '',
      author: json['author'] == null
          ? const ActorModel()
          : ActorModel.fromJson(json['author']),
      createdAt: json['createdAt'] as String? ?? '',
      bodyHTML: json['bodyHTML'] as String? ?? '',
      body: json['body'] as String? ?? '',
      reactionGroups: (json['reactionGroups'] as List<dynamic>?)
              ?.map(ReactionGroupModel.fromJson)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$IssueCommentModelToJson(IssueCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author.toJson(),
      'createdAt': instance.createdAt,
      'bodyHTML': instance.bodyHTML,
      'body': instance.body,
      'reactionGroups': instance.reactionGroups.map((e) => e.toJson()).toList(),
    };
