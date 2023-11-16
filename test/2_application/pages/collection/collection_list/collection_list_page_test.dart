import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(
      home: Material(
        child: CollectionListPage(),
      ),
    );
  }

  group('CollectionListPage', () {
    testWidgets('should render a Collection Text',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.text('Collection'), findsOneWidget);
    });
  });
}