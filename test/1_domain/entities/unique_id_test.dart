import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

void main() {
  group('UniqueId', () {
    test('should create a unique id with the right length', () {
      final id = UniqueId();

      expect(id.value.length, 36);
    });

    test('should create an id with the given value', () {
      final id = UniqueId.fromUniqueString('a key');

      expect(id.value, 'a key');
    });

    test('can be compared', () {
      final id1 = UniqueId.fromUniqueString('an id');
      final id2 = UniqueId.fromUniqueString('an id');

      expect(id1, id2);
    });
  });
}
