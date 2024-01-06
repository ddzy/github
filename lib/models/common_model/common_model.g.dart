// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonConnectionPageInfoModel _$CommonConnectionPageInfoModelFromJson(
        Map<String, dynamic> json) =>
    CommonConnectionPageInfoModel(
      endCursor: json['endCursor'] as String? ?? '',
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
      startCursor: json['startCursor'] as String? ?? '',
    );

Map<String, dynamic> _$CommonConnectionPageInfoModelToJson(
        CommonConnectionPageInfoModel instance) =>
    <String, dynamic>{
      'endCursor': instance.endCursor,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'startCursor': instance.startCursor,
    };
