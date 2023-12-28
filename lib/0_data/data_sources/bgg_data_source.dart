import 'package:http/http.dart' as http;
import 'package:ludoteca/0_data/exceptions/exceptions.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:xml/xml.dart';

class BggDataSource {
  final String apiDomain = 'boardgamegeek.com';
  final String undecodedPath = 'xmlapi2/thing';
  final http.Client? httpClient;

  BggDataSource({this.httpClient});

  Future<ItemModel> getItem({required String id}) async {
    http.Client client = httpClient ?? http.Client();

    try {
      final url = Uri.https(
        apiDomain,
        undecodedPath,
        {'id': id, 'type': 'boardgame'},
      );

      final response = await client.get(url);

      if (response.statusCode != 200) {
        throw FailedRequestException(
          'Failed to fetch item $id, ${response.statusCode}',
        );
      }

      final document = XmlDocument.parse(response.body);

      return ItemModel.fromBggXml(document);
    } finally {
      if (httpClient == null) {
        client.close();
      }
    }
  }
}
