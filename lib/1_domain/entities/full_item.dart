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
    this.publisher,
    this.author,
    this.longDescription,
    this.adquisitionDate,
  }) : super(
          id: id,
          title: title,
          status: status,
          imageUrl: imageUrl,
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
        publisher,
        author,
        longDescription,
        adquisitionDate,
      ];
}
