import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

class ItemDetail extends Item {
  final String? publisher;
  final String? author;
  final String? longDescription;
  final DateTime? adquisitionDate;
  const ItemDetail({
    required ItemId id,
    required String title,
    required String description,
    required String imageUrl,
    this.publisher,
    this.author,
    this.longDescription,
    this.adquisitionDate,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
        );
}
