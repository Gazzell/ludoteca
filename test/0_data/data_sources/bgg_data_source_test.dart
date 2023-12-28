import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:http/http.dart';
import 'package:ludoteca/0_data/exceptions/exceptions.dart';
import 'package:ludoteca/0_data/models/item_model.dart';

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

// class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('BggDataSource', () {
    test('getItem should return an ItemModel', () async {
      var client = MockClient((request) async {
        return Response(htmlText, 200, headers: {'content-type': 'text/xml'});
      });

      final item = await BggDataSource(httpClient: client).getItem(id: '1');
      expect(item, const TypeMatcher<ItemModel>());
    });

    test('should throw FailedRequestException when response code is not 200',
        () {
      var client = MockClient((request) async {
        return Response('fail', 300);
      });

      expect(
        () => BggDataSource(httpClient: client).getItem(id: '1'),
        throwsA(isA<FailedRequestException>()),
      );
    });
  });
}
