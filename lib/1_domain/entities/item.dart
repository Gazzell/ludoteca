import 'package:equatable/equatable.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

class Item extends Equatable {
  final ItemId id;
  final String title;
  final String description;
  final String imageUrl;

  const Item({
    required this.id,
    required this.title,
    required this.description,
    String? imageUrl,
  }) : imageUrl = imageUrl ?? '';

  factory Item.empty() {
    return Item(
      id: ItemId(),
      title: '',
      description: '',
    );
  }

  @override
  List<Object?> get props => [id, title, description, imageUrl];
}
