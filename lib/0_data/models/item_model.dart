import 'package:equatable/equatable.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:xml/xml.dart';

class ItemModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String? description;
  final int? minAge;
  final int? minPlayers;
  final int? maxPlayers;
  final int? playingTime;

  const ItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.description,
    this.minAge,
    this.minPlayers,
    this.maxPlayers,
    this.playingTime,
  });

  factory ItemModel.fromBggXml(XmlDocument document) {
    final item = document.getElement('items')?.getElement('item');
    if (item == null) {
      throw Exception('Item not found on BGG');
    }

    final String id = item.getAttribute('id')!;
    final String title = item.getElement('name')?.getAttribute('value') ?? '';
    final String imageUrl = item.getElement('image')?.innerText ?? '';
    final String? descriptionEscaped =
        item.getElement('description')?.innerText;
    final String? description = descriptionEscaped != null
        ? HtmlUnescape().convert(descriptionEscaped)
        : null;
    final int? minAge = int.tryParse(
      item.getElement('minage')?.getAttribute('value') ?? '',
    );
    final int? minPlayers = int.tryParse(
      item.getElement('minplayers')?.getAttribute('value') ?? '',
    );
    final int? maxPlayers = int.tryParse(
      item.getElement('maxplayers')?.getAttribute('value') ?? '',
    );
    final int? playingTime = int.tryParse(
      item.getElement('playingtime')?.getAttribute('value') ?? '',
    );

    return ItemModel(
      id: id,
      title: title,
      imageUrl: imageUrl,
      description: description,
      minAge: minAge,
      minPlayers: minPlayers,
      maxPlayers: maxPlayers,
      playingTime: playingTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        minAge,
        minPlayers,
        maxPlayers,
        playingTime,
      ];
}
