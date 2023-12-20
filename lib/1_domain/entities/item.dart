import 'package:equatable/equatable.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

enum ItemStatus {
  available,
  unavailable,
}

class Item extends Equatable {
  final ItemId id;
  final String title;
  final ItemStatus status;
  final String imageUrl;
  final int? minAge;
  final int? minPlayers;
  final int? maxPlayers;
  final int? playingTime;

  const Item({
    required this.id,
    required this.title,
    required this.status,
    String? imageUrl,
    this.minAge = 0,
    this.minPlayers,
    this.maxPlayers,
    this.playingTime,
  }) : imageUrl = imageUrl ?? '';

  factory Item.empty() {
    return Item(
      id: ItemId(),
      title: '',
      status: ItemStatus.available,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        status,
        imageUrl,
        minAge,
        minPlayers,
        maxPlayers,
        playingTime,
      ];
}
