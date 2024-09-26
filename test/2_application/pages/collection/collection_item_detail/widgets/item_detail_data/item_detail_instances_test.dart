import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_instance_row_list_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_instances.dart';

void main() {
  group('ItemDetailInstances', () {
    final instances = List.generate(5, (index) {
      return ItemInstance(
        id: ItemInstanceId.fromUniqueString(index.toString()),
        itemId: ItemId.fromUniqueString('i1'),
        status: ItemInstanceStatus.available,
      );
    });

    testWidgets('renders item title', (WidgetTester tester) async {
      const itemTitle = 'Test Item Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemDetailInstances(
              instances: instances,
              itemTitle: itemTitle,
            ),
          ),
        ),
      );

      expect(find.text(itemTitle), findsOneWidget);
    });

    testWidgets('renders list of instances', (WidgetTester tester) async {
      const itemTitle = 'Test Item Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemDetailInstances(
              instances: instances,
              itemTitle: itemTitle,
            ),
          ),
        ),
      );

      expect(
        find.byType(ItemDetailListInstanceListItem),
        findsNWidgets(instances.length),
      );
    });

    testWidgets('close button pops the navigator', (WidgetTester tester) async {
      const itemTitle = 'Test Item Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemDetailInstances(
              instances: instances,
              itemTitle: itemTitle,
            ),
          ),
        ),
      );

      final closeButton = find.byIcon(Icons.close);
      expect(closeButton, findsOneWidget);

      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsNothing);
    });
  });
}
