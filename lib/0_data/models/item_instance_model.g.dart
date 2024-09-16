// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_instance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemInstanceModel _$ItemInstanceModelFromJson(Map<String, dynamic> json) =>
    ItemInstanceModel(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      status: json['status'] as String,
      incidences: (json['incidences'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      borrowedAt: json['borrowedAt'] == null
          ? null
          : DateTime.parse(json['borrowedAt'] as String),
      returnedAt: json['returnedAt'] == null
          ? null
          : DateTime.parse(json['returnedAt'] as String),
      borrowedBy: json['borrowedBy'] as String?,
    );

Map<String, dynamic> _$ItemInstanceModelToJson(ItemInstanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'status': instance.status,
      'incidences': instance.incidences,
      'borrowedAt': instance.borrowedAt?.toIso8601String(),
      'returnedAt': instance.returnedAt?.toIso8601String(),
      'borrowedBy': instance.borrowedBy,
    };
