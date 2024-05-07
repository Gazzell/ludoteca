import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/pages_shell.dart';

import '../../helpers.dart';

void main() {
  Widget widgetUnderTest() {
    return withMaterialAppTranslation(
      MaterialApp(
        home: Material(
          child: PagesShell(tab: 'home'),
        ),
      ),
    );
  }

  group('PagesShell', () {
    testWidgets('should render navigation bar icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      final collectionNavigationIcon = find.byIcon(Icons.menu_book_outlined);
      expect(collectionNavigationIcon, findsOneWidget);

      final homeNavigationIcon = find.byIcon(Icons.home_outlined);
      expect(homeNavigationIcon, findsOneWidget);
    });
  });
}
