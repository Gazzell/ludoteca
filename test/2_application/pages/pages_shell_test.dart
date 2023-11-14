import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/pages_shell.dart';

void main() {
  Widget widgetUnderTest() {
    return MaterialApp(
      home: Material(
        child: PagesShell(tab: 'home'),
      ),
    );
  }

  group('PagesShell', () {
    testWidgets('should render a BottonNavigationBar',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });
}
