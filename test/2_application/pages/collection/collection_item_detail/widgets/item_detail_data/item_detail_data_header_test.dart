import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data_header.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/rating_star.dart';

void main() {
  Widget widgetUnderTest({required String title, double rating = -1}) {
    return MaterialApp(
      home: ItemDetailDataHeader(
        title: title,
        rating: rating,
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
  });
}
