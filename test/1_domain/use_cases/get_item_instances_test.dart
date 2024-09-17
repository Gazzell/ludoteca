import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_item_instances.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockCollectionRepository extends Mock implements CollectionRepository {}

void main() {
  final fakeItemInstances = [
    ItemInstance(
      id: ItemInstanceId.fromUniqueString('i0'),
      itemId: ItemId.fromUniqueString('0'),
      status: ItemInstanceStatus.available,
    ),
    ItemInstance(
      id: ItemInstanceId.fromUniqueString('i1'),
      itemId: ItemId.fromUniqueString('0'),
      status: ItemInstanceStatus.unavailable,
      borrowedAt: DateTime.now(),
      borrowedBy: UniqueId.fromUniqueString('u0'),
    ),
  ];

  group('GetItemInstances use case', () {
    group('should return Right', () {
      test('with ItemDetail list', () async {
        final mockCollectionRepository = MockCollectionRepository();
        when(
          () => mockCollectionRepository.readItemInstances([
            ItemInstanceId.fromUniqueString('i0'),
            ItemInstanceId.fromUniqueString('i1')
          ]),
        ).thenAnswer(
          (_) async => Right(fakeItemInstances),
        );

        final getItemDetailUseCase = GetItemInstances(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getItemDetailUseCase(
          GetItemInstancesParams(
            itemInstanceIds: [
              ItemInstanceId.fromUniqueString('i0'),
              ItemInstanceId.fromUniqueString('i1')
            ],
          ),
        );

        expect(result, Right<Failure, List<ItemInstance>>(fakeItemInstances));

        verify(
          () => mockCollectionRepository.readItemInstances([
            ItemInstanceId.fromUniqueString('i0'),
            ItemInstanceId.fromUniqueString('i1')
          ]),
        ).called(1);
      });
    });

    group('should return left', () {
      test('with a ServerFailure if threw an exception', () async {
        final mockCollectionRepository = MockCollectionRepository();
        when(() => mockCollectionRepository
                .readItemInstances([ItemInstanceId.fromUniqueString('0')]))
            .thenThrow(
          Exception('something went wrong'),
        );

        final getItemDetailUseCase = GetItemInstances(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getItemDetailUseCase(
          GetItemInstancesParams(
            itemInstanceIds: [ItemInstanceId.fromUniqueString('0')],
          ),
        );

        expect(result.isLeft, true);
        expect(
          result.left,
          ServerFailure(stackTrace: 'Exception: something went wrong'),
        );

        verify(
          () => mockCollectionRepository.readItemInstances(
            [ItemInstanceId.fromUniqueString('0')],
          ),
        ).called(1);
      });
    });
  });
}
