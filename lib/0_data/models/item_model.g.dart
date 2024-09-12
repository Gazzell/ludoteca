// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as String,
      bggId: json['bggId'] as String?,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      description: json['description'] as String?,
      minAge: (json['minAge'] as num?)?.toInt(),
      minPlayers: (json['minPlayers'] as num?)?.toInt(),
      maxPlayers: (json['maxPlayers'] as num?)?.toInt(),
      playingTime: (json['playingTime'] as num?)?.toInt(),
      author: json['author'] as String?,
      publisher: json['publisher'] as String?,
      publishYear: (json['publishYear'] as num?)?.toInt(),
      complexity: (json['complexity'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      instances: (json['instances'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'bggId': instance.bggId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'minAge': instance.minAge,
      'minPlayers': instance.minPlayers,
      'maxPlayers': instance.maxPlayers,
      'playingTime': instance.playingTime,
      'author': instance.author,
      'publisher': instance.publisher,
      'publishYear': instance.publishYear,
      'complexity': instance.complexity,
      'rating': instance.rating,
      'instances': instance.instances,
    };
