import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:xml/xml.dart';

void main() {
  group('ItemModel', () {
    test('fromBggXml should return an ItemModel', () {
      const htmlText = ''''
        <?xml version="1.0" encoding="utf-8"?>
        <items termsofuse="https://boardgamegeek.com/xmlapi/termsofuse">
          <item type="boardgame" id="1">
            <thumbnail>tumbnail.jpg</thumbnail>
            <image>image.jpg</image>
            <name type="primary" sortindex="5" value="name" />
            <name type="alternate" sortindex="1" value="alt name" />
            <description>description&amp;#10;&amp;#10;</description>
            <yearpublished value="1986" />
            <minplayers value="3" />
            <maxplayers value="5" />
            <playingtime value="240" />
            <minage value="14" />        
          </item>
        </items>
      ''';

      final item = ItemModel.fromBggXml(
        XmlDocument.parse(htmlText),
      );

      const expectedItem = ItemModel(
        id: '1',
        bggId: '1',
        title: 'name',
        description: 'description\n\n',
        imageUrl: 'image.jpg',
        minAge: 14,
        minPlayers: 3,
        maxPlayers: 5,
        playingTime: 240,
      );

      expect(item, equals(expectedItem));
    });

    test('fromItem should return an ItemModel', () {
      // Create a sample Item object
      final item = Item(
        id: ItemId.fromUniqueString('1'),
        bggId: '1',
        title: 'name',
        imageUrl: 'image.jpg',
        thumbnailUrl: 'thumbnail.jpg',
        description: 'description\n\n',
        minAge: 14,
        minPlayers: 3,
        maxPlayers: 5,
        playingTime: 240,
        author: 'author',
        publisher: 'publisher',
        publishYear: 1986,
        complexity: 3.5,
        rating: 4.2,
        instances: [
          ItemInstanceId.fromUniqueString('instance1'),
          ItemInstanceId.fromUniqueString('instance2')
        ],
      );

      // Convert Item to ItemModel
      final itemModel = ItemModel.fromItem(item);

      // Verify the conversion
      expect(itemModel.id, equals('1'));
      expect(itemModel.bggId, equals('1'));
      expect(itemModel.title, equals('name'));
      expect(itemModel.imageUrl, equals('image.jpg'));
      expect(itemModel.thumbnailUrl, equals('thumbnail.jpg'));
      expect(itemModel.description, equals('description\n\n'));
      expect(itemModel.minAge, equals(14));
      expect(itemModel.minPlayers, equals(3));
      expect(itemModel.maxPlayers, equals(5));
      expect(itemModel.playingTime, equals(240));
      expect(itemModel.author, equals('author'));
      expect(itemModel.publisher, equals('publisher'));
      expect(itemModel.publishYear, equals(1986));
      expect(itemModel.complexity, equals(3.5));
      expect(itemModel.rating, equals(4.2));
      expect(itemModel.instances, equals(['instance1', 'instance2']));
    });
  });
}
