import 'package:equatable/equatable.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:xml/xml.dart';

part 'item_model_bgg_xml.dart';
part 'item_model.g.dart';

@JsonSerializable()
class ItemModel extends Equatable {
  final String id;
  final String? bggId;
  final String title;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String? description;
  final int? minAge;
  final int? minPlayers;
  final int? maxPlayers;
  final int? playingTime;
  final String? author;
  final String? publisher;
  final int? publishYear;
  final double? complexity;
  final double? rating;
  final List<String> instances;

  const ItemModel({
    required this.id,
    this.bggId,
    required this.title,
    this.imageUrl,
    this.thumbnailUrl,
    this.description,
    this.minAge,
    this.minPlayers,
    this.maxPlayers,
    this.playingTime,
    this.author,
    this.publisher,
    this.publishYear,
    this.complexity,
    this.rating,
    this.instances = const [],
  });

  factory ItemModel.fromBggXml(XmlDocument document) => _fromBggXml(document);

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  factory ItemModel.fromItem(Item item) => ItemModel(
        id: item.id.value,
        bggId: item.bggId,
        title: item.title,
        imageUrl: item.imageUrl,
        thumbnailUrl: item.thumbnailUrl,
        description: item.description,
        minAge: item.minAge,
        minPlayers: item.minPlayers,
        maxPlayers: item.maxPlayers,
        playingTime: item.playingTime,
        author: item.author,
        publisher: item.publisher,
        publishYear: item.publishYear,
        complexity: item.complexity,
        rating: item.rating,
        instances: item.instances,
      );

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        bggId,
        title,
        imageUrl,
        thumbnailUrl,
        description,
        minAge,
        minPlayers,
        maxPlayers,
        playingTime,
        author,
        publisher,
        publishYear,
        complexity,
        rating,
        instances,
      ];
}
