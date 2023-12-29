import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  Widget widgetUnderTest(Item item) {
    return MaterialApp(
      home: CollectionItemDetailLoaded(item: item),
    );
  }

  group('CollectionItemDetailLoaded view state', () {
    testWidgets('should render ItemDetailData',
        (WidgetTester widgetTester) async {
      final Item item = Item(
        id: ItemId.fromUniqueString('test'),
        title: 'test name',
        instances: const [],
        imageUrl: 'image_url',
      );

      await mockNetworkImages(
        () async => widgetTester.pumpWidget(
          widgetUnderTest(item),
        ),
      );

      expect(find.byType(ItemDetailData), findsOneWidget);
    });
  });
}
