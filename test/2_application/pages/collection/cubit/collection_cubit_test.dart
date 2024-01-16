import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';

void main() {
  group('CollectionCubit', () {
    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionCubit(),
        expect: () => const <CollectionCubitState>[],
      );

      blocTest(
        '[CollectionItemAddingState] when setting add mode',
        build: () => CollectionCubit(),
        act: (cubit) => cubit.setAddingItem(),
        expect: () => const <CollectionCubitState>[CollectionItemAddingState()],
      );
    });
  });
}
