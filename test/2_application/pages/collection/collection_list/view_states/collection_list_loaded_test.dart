import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loaded.dart';

void main() {
  Widget widgetUnderTest({required List<Item> items}) {
    return MaterialApp(
      home: CollectionListLoaded(
        items: items,
      ),
    );
  }

  group('CollectionListLoaded view state', () {
    testWidgets('should render a list of card items',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        widgetUnderTest(
          items: List<Item>.generate(
            10,
            (index) => Item.empty(),
          ),
        ),
      );

      expect(find.byType(Card), findsNWidgets(10));
    });
  });
}
