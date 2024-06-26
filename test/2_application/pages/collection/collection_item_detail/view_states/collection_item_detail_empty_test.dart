import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_empty.dart';
import '../../../../../helpers.dart';

void main() {
  Widget widgetUnderTest() {
    return withMaterialAppTranslation(const CollectionItemDetailEmpty());
  }

  group('CollectionItemDetailEmpty view state', () {
    testWidgets('should render an error text',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());

      expect(
        find.text('No item selected'),
        findsOneWidget,
      );
    });
  });
}
