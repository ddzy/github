// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeEntryModel _$TreeEntryModelFromJson(Map<String, dynamic> json) =>
    TreeEntryModel(
      oid: json['oid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      path: json['path'] as String? ?? '',
      type: json['type'] as String? ?? '',
      size: json['size'] as int? ?? 0,
      language: json['language'] == null
          ? const LanguageModel()
          : LanguageModel.fromJson(json['language']),
      submodule: json['submodule'] == null
          ? const SubmoduleModel()
          : SubmoduleModel.fromJson(json['submodule']),
      object: json['object'] == null
          ? const GitObjectInterface()
          : GitObjectInterface.fromJson(json['object']),
    );

Map<String, dynamic> _$TreeEntryModelToJson(TreeEntryModel instance) =>
    <String, dynamic>{
      'oid': instance.oid,
      'name': instance.name,
      'path': instance.path,
      'type': instance.type,
      'size': instance.size,
      'language': instance.language.toJson(),
      'submodule': instance.submodule.toJson(),
      'object': instance.object.toJson(),
    };
