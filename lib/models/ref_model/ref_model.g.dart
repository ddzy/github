// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ref_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefModel _$RefModelFromJson(Map<String, dynamic> json) => RefModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      prefix: json['prefix'] as String? ?? '',
      target: json['target'] == null
          ? const GitObjectInterface()
          : GitObjectInterface.fromJson(json['target']),
    );

Map<String, dynamic> _$RefModelToJson(RefModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prefix': instance.prefix,
      'target': instance.target.toJson(),
    };
