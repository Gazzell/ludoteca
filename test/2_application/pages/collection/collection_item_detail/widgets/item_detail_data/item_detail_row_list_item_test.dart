import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_instances_row.dart';

import '../../../../../../helpers.dart';

void main() {
  group('ItemDetailInstancesRow', () {
    testWidgets('should display the item instance',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        withMaterialAppTranslation(
          ItemDetailInstancesRow(
            index: 1,
            itemInstance: ItemInstance(
              id: ItemInstanceId.fromUniqueString('1'),
              itemId: ItemId.fromUniqueString('item-1'),
              status: ItemInstanceStatus.available,
            ),
          ),
        ),
      );

      expect(find.text('#1'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should not show date if instance is available',
        (WidgetTester tester) async {
      final date = DateTime.fromMicrosecondsSinceEpoch(1);
      await tester.pumpWidget(
        withMaterialAppTranslation(
          ItemDetailInstancesRow(
            index: 1,
            itemInstance: ItemInstance(
              id: ItemInstanceId.fromUniqueString('1'),
              itemId: ItemId.fromUniqueString('item-1'),
              status: ItemInstanceStatus.available,
              borrowedAt: date,
            ),
          ),
        ),
      );

      expect(find.text(DateFormat.yMMMd().format(date)), findsNothing);
    });

    testWidgets('should show date if instance is borrowed',
        (WidgetTester tester) async {
      final date = DateTime.fromMicrosecondsSinceEpoch(1);
      await tester.pumpWidget(
        withMaterialAppTranslation(
          ItemDetailInstancesRow(
            index: 1,
            itemInstance: ItemInstance(
              id: ItemInstanceId.fromUniqueString('1'),
              itemId: ItemId.fromUniqueString('item-1'),
              status: ItemInstanceStatus.unavailable,
              borrowedAt: date,
            ),
          ),
        ),
      );

      expect(find.text(DateFormat.yMMMd().format(date)), findsOneWidget);
    });

    testWidgets('should show chip with incidence count if there are incidences',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        withMaterialAppTranslation(
          ItemDetailInstancesRow(
            index: 1,
            itemInstance: ItemInstance(
              id: ItemInstanceId.fromUniqueString('1'),
              itemId: ItemId.fromUniqueString('item-1'),
              status: ItemInstanceStatus.available,
              incidences: const ['1', '2', '3'],
            ),
          ),
        ),
      );

      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('!3'), findsOneWidget);
    });

    testWidgets(
        'should not show chip with incidence count if there are no incidences',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        withMaterialAppTranslation(
          ItemDetailInstancesRow(
            index: 1,
            itemInstance: ItemInstance(
              id: ItemInstanceId.fromUniqueString('1'),
              itemId: ItemId.fromUniqueString('item-1'),
              status: ItemInstanceStatus.available,
              incidences: const [],
            ),
          ),
        ),
      );

      expect(find.byType(Chip), findsNothing);
    });
  });
}
