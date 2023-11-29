import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loaded.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(home: CollectionItemDetailLoaded());
  }

  group('CollectionItemDetailLoaded view state', () {
    testWidgets('should render an error text',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());

      expect(
        find.byType(Placeholder),
        findsOneWidget,
      );
    });
  });
}
