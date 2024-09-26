import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data_header.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_instances.dart';
import 'package:ludoteca/2_application/pages/collection/widgets/item_play_properties.dart';

void main() {
  Widget widgetUnderTest({
    required Item item,
    List<ItemInstance>? itemInstances,
  }) {
    return MaterialApp(
      home: Material(
        child: ItemDetailData(
          item: item,
          itemInstances: itemInstances,
        ),
      ),
    );
  }

  group('ItemDetailData', () {
    testWidgets('should render a ItemDetailHeader',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest(item: Item.empty()));

      expect(find.byType(ItemDetailDataHeader), findsOneWidget);
    });

    testWidgets('should render ItemPlayProperties',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest(item: Item.empty()));

      expect(find.byType(ItemPlayProperties), findsOneWidget);
    });

    testWidgets(
        'should show a dialog when item detail instances button is pressed',
        (WidgetTester tester) async {
      final item = Item(
        id: ItemId.fromUniqueString('1'),
        title: 'title',
        instances: [ItemInstanceId.fromUniqueString('i1')],
      );
      final itemInstances = [
        ItemInstance(
          id: ItemInstanceId.fromUniqueString('i1'),
          itemId: ItemId.fromUniqueString('1'),
          status: ItemInstanceStatus.available,
        ),
      ];

      await tester.pumpWidget(widgetUnderTest(
        item: item,
        itemInstances: itemInstances,
      ));

      expect(find.byType(ItemDetailInstances), findsNothing);

      final showItemInstancesButton = find.byIcon(Icons.list);
      expect(showItemInstancesButton, findsOneWidget);

      await tester.tap(showItemInstancesButton);
      await tester.pumpAndSettle();

      expect(find.byType(ItemDetailInstances), findsOneWidget);
    });
  });
}
