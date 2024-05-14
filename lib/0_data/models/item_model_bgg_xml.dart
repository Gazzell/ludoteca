part of 'item_model.dart';

ItemModel _fromBggXml(XmlDocument document) {
    final item = document.getElement('items')?.getElement('item');
    if (item == null) {
      throw Exception('Item not found on BGG');
    }

    final String bggId = item.getAttribute('id')!;
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
      bggId: bggId,
      title: title,
      imageUrl: imageUrl,
      description: description,
      minAge: minAge,
      minPlayers: minPlayers,
      maxPlayers: maxPlayers,
      playingTime: playingTime,
    );
  }