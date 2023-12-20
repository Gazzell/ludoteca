import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

class FullItem extends Item {
  final String? publisher;
  final String? author;
  final String? longDescription;
  final DateTime? adquisitionDate;

  const FullItem({
    required ItemId id,
    required String title,
    required ItemStatus status,
    required String imageUrl,
    int? minAge,
    int? minPlayers,
    int? maxPlayers,
    int? playingTime,
    this.publisher,
    this.author,
    this.longDescription,
    this.adquisitionDate,
  }) : super(
          id: id,
          title: title,
          status: status,
          imageUrl: imageUrl,
          minAge: minAge,
          minPlayers: minPlayers,
          maxPlayers: maxPlayers,
          playingTime: playingTime,
        );

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
