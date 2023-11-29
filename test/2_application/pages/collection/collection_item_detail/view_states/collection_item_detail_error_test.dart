import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_error.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(home: CollectionItemDetailError());
  }

  group('CollectionItemDetailError view state', () {
    testWidgets('should render an error text',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());

      expect(
        find.text('Error getting collection items. Try again later.'),
        findsOneWidget,
      );
    });
  });
}
