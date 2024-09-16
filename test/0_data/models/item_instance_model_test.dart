import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/models/item_instance_model.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

void main() {
  group('ItemInstanceModel', () {
    test('fromItemInstanceModel should return an ItemInstanceModel', () {
      final itemInstance = ItemInstance(
        id: ItemInstanceId.fromUniqueString('1'),
        itemId: ItemId.fromUniqueString('1'),
        status: ItemInstanceStatus.available,
        incidences: const ['incidence'],
        borrowedAt: DateTime.now(),
        returnedAt: DateTime.now(),
        borrowedBy: UniqueId.fromUniqueString('borrower'),
      );

      final itemInstanceModel =
          ItemInstanceModel.fromItemInstance(itemInstance);

      final expectedItemInstanceModel = ItemInstanceModel(
        id: '1',
        itemId: '1',
        status: 'available',
        incidences: const ['incidence'],
        borrowedAt: itemInstance.borrowedAt,
        returnedAt: itemInstance.returnedAt,
        borrowedBy: 'borrower',
      );

      expect(itemInstanceModel, equals(expectedItemInstanceModel));
    });
  });
}
