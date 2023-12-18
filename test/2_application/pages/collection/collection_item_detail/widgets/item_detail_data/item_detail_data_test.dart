import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data_header.dart';

void main() {
  Widget widgetUnderTest({required FullItem item}) {
    return MaterialApp(
      home: Material(
        child: ItemDetailData(itemDetail: item),
      ),
    );
  }

  group('ItemDetailData', () {
    testWidgets('should render a ItemDetailHeader',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest(item: FullItem.empty()));

      expect(find.byType(ItemDetailDataHeader), findsOneWidget);
    });
  });
}
