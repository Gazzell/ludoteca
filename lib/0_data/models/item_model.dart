import 'package:equatable/equatable.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:xml/xml.dart';

part 'item_model_bgg_xml.dart';

class ItemModel extends Equatable {
  final String? id;
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
    this.id,
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
