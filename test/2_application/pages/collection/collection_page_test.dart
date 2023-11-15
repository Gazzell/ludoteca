import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_page.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(
      home: Material(
        child: CollectionPage(),
      ),
    );
  }

  group('CollectionPage', () {
    testWidgets('should render a Collection Text',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.text('Collection'), findsOneWidget);
    });
  });
}