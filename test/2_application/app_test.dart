import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/app.dart';
import 'package:ludoteca/2_application/pages/collection/collection_page.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';
import 'package:ludoteca/2_application/pages/pages_shell.dart';

void main() {
  testWidgets('should render PagesShell', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(PagesShell), findsOneWidget);
  });

  group('navigation', () {
    testWidgets('should route to HomePage by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('on collection click goes to collection page',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(find.byType(CollectionPage), findsNothing);

      final collectionNavigationIcon = find.byIcon(Icons.menu_book_outlined);

      expect(collectionNavigationIcon, findsOneWidget);

      await tester.tap(collectionNavigationIcon);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionPage), findsOneWidget);
    });

    testWidgets('can return to home page', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final collectionNavigationIcon = find.byIcon(Icons.menu_book_outlined);

      await tester.tap(collectionNavigationIcon);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionPage), findsOneWidget);

      final homeNavigationIcon = find.byIcon(Icons.home_outlined);

      await tester.tap(homeNavigationIcon);

      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
