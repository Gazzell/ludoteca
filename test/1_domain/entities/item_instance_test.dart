import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/models/item_instance_model.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

void main() {
  group('ItemInstance', () {
    test('should create an ItemInstance from an ItemInstanceModel', () {
      final itemInstanceModel = ItemInstanceModel(
        instanceId: 1,
        itemId: '1',
        status: 'available',
        incidences: const ['incidence'],
        borrowedAt: DateTime.now(),
        returnedAt: DateTime.now(),
        borrowedBy: 'borrower',
      );

      final itemInstance =
          ItemInstance.fromItemInstanceModel(itemInstanceModel);

      final expectedItemInstance = ItemInstance(
        instanceId: itemInstanceModel.instanceId,
        itemId: ItemId.fromUniqueString(itemInstanceModel.itemId),
        status: ItemInstanceStatus.available,
        incidences: itemInstanceModel.incidences,
        borrowedAt: itemInstanceModel.borrowedAt,
        returnedAt: itemInstanceModel.returnedAt,
        borrowedBy: itemInstanceModel.borrowedBy != null
            ? UniqueId.fromUniqueString(itemInstanceModel.borrowedBy!)
            : null,
      );

      // Compare the two objects
      expect(itemInstance, equals(expectedItemInstance));
    });
  });
}
