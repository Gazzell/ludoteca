import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

void main() {
  group('Item', () {
    test('should create empty item', () {
      final item = Item.empty();

      expect(item.id.value, isNot(''));
      expect(item.title, '');
      expect(item.instances, []);
      expect(item.minAge, 0);
    });

    test('should create an identical Item', () {
      final item = Item(
        id: ItemId.fromUniqueString('1'),
        title: 'title',
        instances: const [],
      );

      final item2 = Item(
        id: ItemId.fromUniqueString('1'),
        title: 'title',
        instances: const [],
        minAge: 0,
      );

      expect(item, item2);
    });
  });
}
