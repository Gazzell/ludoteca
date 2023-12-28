import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:xml/xml.dart';

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

void main() {
  group('ItemModel', () {
    test('fromBggXml should return an ItemModel', () {
      final item = ItemModel.fromBggXml(
        XmlDocument.parse(htmlText),
      );

      const expectedItem = ItemModel(
        id: '1',
        title: 'name',
        description: 'description',
        imageUrl: 'image.jpg',
        minAge: 14,
        minPlayers: 3,
        maxPlayers: 5,
        playingTime: 240,
      );

      expect(item, equals(expectedItem));
    });
  });
}
