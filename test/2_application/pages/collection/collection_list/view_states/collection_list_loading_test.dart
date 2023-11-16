import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loading.dart';

void main() {
  group('CollectionListLoading view state', () {
    testWidgets('should render a progress indicator',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const CollectionListLoading());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
