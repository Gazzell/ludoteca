import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';

void main() {
  group('CollectionAddItemPage', () {
    Widget widgetUnderTest({bool showAppBar = false, String? title}) {
      return MaterialApp(
          home: CollectionAddItemPage(
        showAppBar: showAppBar,
        title: title,
      ));
    }

    testWidgets(
      'renders a CollectionAddItemPage with no header',
      (WidgetTester tester) async {
        await tester.pumpWidget(widgetUnderTest());

        expect(find.byType(AppBar), findsNothing);
        expect(find.text('title'), findsNothing);
        expect(find.byType(Placeholder), findsOneWidget);
      },
    );

    testWidgets(
      'renders a CollectionAddItemPage with a header',
      (WidgetTester tester) async {
        await tester
            .pumpWidget(widgetUnderTest(showAppBar: true, title: 'title'));

        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('title'), findsOneWidget);
        expect(find.byType(Placeholder), findsOneWidget);
      },
    );
  });
}
