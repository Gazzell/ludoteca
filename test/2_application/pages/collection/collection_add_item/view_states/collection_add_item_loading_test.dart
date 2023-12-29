import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_loading.dart';

void main() {
  group('CollectionAddItemLoading view state', () {
    testWidgets('should render a progress indicator',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const CollectionAddItemLoading());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
