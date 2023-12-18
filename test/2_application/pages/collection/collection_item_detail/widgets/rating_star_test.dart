import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/rating_star.dart';

void main() {
  Widget widgetUnderTest({double rating = -1}) {
    return MaterialApp(
      home: Material(
        child: RatingStar(
          rating: rating,
        ),
      ),
    );
  }

  group('RatingStar', () {
    testWidgets('should render a star icon', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('should render a - if no rating', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.text('-'), findsOneWidget);
    });

    testWidgets('should render rating', (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest(rating: 8.1));

      expect(find.text('8.1'), findsOneWidget);
    });
  });
}
