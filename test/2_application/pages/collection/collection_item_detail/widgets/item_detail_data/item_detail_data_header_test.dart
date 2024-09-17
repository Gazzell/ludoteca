import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data_header.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/rating_star.dart';

void main() {
  Widget widgetUnderTest(
      {required String title,
      double rating = -1,
      bool showItemInstancesButton = false,
      onShowItemInstances}) {
    return MaterialApp(
      home: ItemDetailDataHeader(
        title: title,
        rating: rating,
        showItemInstancesButton: showItemInstancesButton,
        onShowItemInstances: onShowItemInstances,
      ),
    );
  }

  group('ItemDetailDataHeader', () {
    testWidgets('should render a RatingStar', (WidgetTester tester) async {
      await tester.pumpWidget(
        widgetUnderTest(title: 'a title'),
      );

      expect(find.byType(RatingStar), findsOneWidget);
    });

    testWidgets('should render title', (WidgetTester tester) async {
      await tester.pumpWidget(
        widgetUnderTest(title: 'a title'),
      );

      expect(find.text('a title'), findsOneWidget);
    });

    testWidgets(
        'should render a item detail button when showItemInstancesButton is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        widgetUnderTest(title: 'a title', showItemInstancesButton: true),
      );

      expect(find.byIcon(Icons.list), findsOneWidget);
    });

    testWidgets(
        'should call onShowItemInstances when item detail button is pressed',
        (WidgetTester tester) async {
      var pressed = false;
      await tester.pumpWidget(
        widgetUnderTest(
          title: 'a title',
          showItemInstancesButton: true,
          onShowItemInstances: () {
            pressed = true;
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.list));

      expect(pressed, true);
    });
  });
}
