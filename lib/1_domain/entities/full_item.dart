import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

class FullItem extends Item {
  final String? publisher;
  final String? author;
  final String? longDescription;
  final DateTime? adquisitionDate;

  const FullItem({
    required super.id,
    required super.title,
    required super.status,
    required String super.imageUrl,
    super.minAge = null,
    super.minPlayers,
    super.maxPlayers,
    super.playingTime,
    this.publisher,
    this.author,
    this.longDescription,
    this.adquisitionDate,
  });

  factory FullItem.empty() {
    return FullItem(
      id: ItemId(),
      title: '',
      status: ItemStatus.available,
      imageUrl: '',
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
        publisher,
        author,
        longDescription,
        adquisitionDate,
      ];
}
