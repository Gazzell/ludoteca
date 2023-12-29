import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_error.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(home: CollectionAddItemError());
  }

  group('CollectionAddItemError view state', () {
    testWidgets('should render an error text',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());

      expect(
        find.text('Error getting bgg item. Try again later.'),
        findsOneWidget,
      );
    });
  });
}
