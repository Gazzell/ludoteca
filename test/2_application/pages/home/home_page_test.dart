import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(
      home: Material(
        child: HomePage(),
      ),
    );
  }

  group('HomePage', () {
    testWidgets('should render a Home widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.text('Home'), findsOneWidget);
    });
  });
}
