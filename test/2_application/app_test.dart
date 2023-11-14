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

      expect(find.byType(CollectionPage), findsNothing);

      final collectionNavigationText = find.text('collection');

      expect(collectionNavigationText, findsOneWidget);

      await tester.tap(collectionNavigationText);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionPage), findsOneWidget);
    });

    testWidgets('can return to home page', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final collectionNavigationText = find.text('collection');

      await tester.tap(collectionNavigationText);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionPage), findsOneWidget);

      final homeNavigationText = find.text('home');

      await tester.tap(homeNavigationText);

      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
