import 'package:equatable/equatable.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
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
    this.minAge,
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

  factory Item.fromItemModel(ItemModel itemModel) {
    return Item(
      id: ItemId.fromUniqueString(itemModel.id),
      title: itemModel.title,
      instances: itemModel.instances,
      bggId: itemModel.bggId,
      imageUrl: itemModel.imageUrl,
      thumbnailUrl: itemModel.thumbnailUrl,
      description: itemModel.description,
      minAge: itemModel.minAge,
      minPlayers: itemModel.minPlayers,
      maxPlayers: itemModel.maxPlayers,
      playingTime: itemModel.playingTime,
      author: itemModel.author,
      publisher: itemModel.publisher,
      publishYear: itemModel.publishYear,
      complexity: itemModel.complexity,
      rating: itemModel.rating,
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
