import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/add_item_instance.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockCollectionRepository extends Mock implements CollectionRepository {}

void main() {
  final fakeItemInstance = ItemInstance(
    id: ItemInstanceId.fromUniqueString('0'),
    itemId: ItemId.fromUniqueString('1'),
    status: ItemInstanceStatus.available,
    incidences: const ['incidence'],
    returnedAt: DateTime.now(),
  );

  group('AddItemInstance use case', () {
    group('should return Right', () {
      test('with an ItemInstance', () async {
        final mockCollectionRepository = MockCollectionRepository();
        when(() => mockCollectionRepository.addItemInstance(fakeItemInstance))
            .thenAnswer((_) async => Right(fakeItemInstance));

        final addItemInstanceUseCase = AddItemInstance(
          collectionRepository: mockCollectionRepository,
        );

        final result = await addItemInstanceUseCase(
          AddItemInstanceParams(itemInstance: fakeItemInstance),
        );

        expect(result, Right<Failure, ItemInstance>(fakeItemInstance));

        verify(() => mockCollectionRepository.addItemInstance(fakeItemInstance))
            .called(1);
      });
    });

    group('should return left', () {
      test('with a ServerFailure if threw an exception', () async {
        final mockCollectionRepository = MockCollectionRepository();
        when(() => mockCollectionRepository.addItemInstance(fakeItemInstance))
            .thenThrow(Exception('something went wrong'));

        final addItemInstanceUseCase = AddItemInstance(
          collectionRepository: mockCollectionRepository,
        );

        final result = await addItemInstanceUseCase(
          AddItemInstanceParams(itemInstance: fakeItemInstance),
        );

        expect(result.isLeft, true);
        expect(
          result.left,
          ServerFailure(stackTrace: 'Exception: something went wrong'),
        );

        verify(() => mockCollectionRepository.addItemInstance(fakeItemInstance))
            .called(1);
      });
    });
  });
}
