import 'package:equatable/equatable.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

enum ItemStatus {
  available,
  unavailable,
}

class Item extends Equatable {
  final ItemId id;
  final String title;
  final List<String> instances;
  final String? bggId;
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

  const Item({
    required this.id,
    required this.title,
    required this.instances,
    this.bggId,
    this.imageUrl,
    this.thumbnailUrl,
    this.description,
    this.minAge = 0,
    this.minPlayers,
    this.maxPlayers,
    this.playingTime,
    this.author,
    this.publisher,
    this.publishYear,
    this.complexity,
    this.rating,
  });

  factory Item.empty() {
    return Item(
      id: ItemId(),
      title: '',
      instances: const [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        instances,
        bggId,
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
      ];
}
