// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelModel _$LabelModelFromJson(Map<String, dynamic> json) => LabelModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      color: json['color'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
      issues: json['issues'] == null
          ? const IssueConnection()
          : IssueConnection.fromJson(json['issues']),
      updatedAt: json['updatedAt'] as String? ?? '',
    );

Map<String, dynamic> _$LabelModelToJson(LabelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
      'createdAt': instance.createdAt,
      'isDefault': instance.isDefault,
      'issues': instance.issues.toJson(),
      'updatedAt': instance.updatedAt,
    };
