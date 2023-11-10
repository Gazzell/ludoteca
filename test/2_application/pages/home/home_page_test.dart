import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';

void main() {
  group('HomePage', () {
    testWidgets('should render a Placeholder', (WidgetTester tester) async {
      await tester.pumpWidget(const HomePage());

      expect(find.byType(Placeholder), findsOneWidget);
    });
  });
}
