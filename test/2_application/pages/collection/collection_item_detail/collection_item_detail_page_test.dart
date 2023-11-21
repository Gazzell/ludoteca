import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';

void main() {
  group('CollectionItemDetailPage', () {
    Widget widgetUnderTest({
      required ItemId? selectedItem,
    }) {
      return MaterialApp(
        home: Material(
          child: CollectionItemDetailPage(
            selectedItem: selectedItem,
          ),
        ),
      );
    }

    testWidgets(
      'should render a the collection id',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          widgetUnderTest(selectedItem: ItemId.fromUniqueString('itemId')),
        );

        expect(find.text('itemId'), findsOneWidget);
      },
    );
  });
}
