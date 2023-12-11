import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loaded.dart';

void main() {
  Widget widgetUnderTest(FullItem itemDetail) {
    return MaterialApp(
      home: CollectionItemDetailLoaded(
        itemDetail: itemDetail,
      ),
    );
  }

  group('CollectionItemDetailLoaded view state', () {
    testWidgets('should render an error text',
        (WidgetTester widgetTester) async {
      final FullItem item = FullItem(
        id: ItemId.fromUniqueString('test'),
        title: 'test name',
        description: 'description',
        imageUrl: 'image_url',
      );

      await widgetTester.pumpWidget(widgetUnderTest(item));

      expect(find.text('test name'), findsOneWidget);
    });
  });
}
