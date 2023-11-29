import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loading.dart';

void main() {
  group('CollectionItemDetailLoading view state', () {
    testWidgets('should render a progress indicator',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const CollectionItemDetailLoading());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
