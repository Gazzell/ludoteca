import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_item_ids.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:mocktail/mocktail.dart';

class CollectionRepositoryMock extends Mock implements CollectionRepository {}

final collectionIds = List<ItemId>.generate(
  5,
  (index) => ItemId.fromUniqueString('item-$index'),
);

void main() {
  group('GetCollectionItemIds use case', () {
    group('should return Right', () {
      test('with a list of item ids', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository.readItemIds()).thenAnswer(
          (_) async => Right(collectionIds),
        );

        final getCollectionItemIdsUseCase = GetCollectionItemIds(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getCollectionItemIdsUseCase(NoParams());

        expect(result, Right<Failure, List<ItemId>>(collectionIds));

        verify(() => mockCollectionRepository.readItemIds()).called(1);
      });
    });

    group('should return Left', () {
      test('with a ServerFailure', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository.readItemIds()).thenAnswer(
          (_) async => Left(ServerFailure()),
        );

        final getCollectionRepositoryUseCase = GetCollectionItemIds(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getCollectionRepositoryUseCase(NoParams());

        expect(result, Left<Failure, List<ItemId>>(ServerFailure()));

        verify(() => mockCollectionRepository.readItemIds()).called(1);
      });

      test('with a ServerFailure if threw an exception', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository.readItemIds())
            .thenThrow(Exception('Something went wrong'));

        final getCollectionRepositoryUseCase = GetCollectionItemIds(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getCollectionRepositoryUseCase(NoParams());

        expect(result.isLeft, true);
        expect(
          result.left,
          ServerFailure(stackTrace: 'Exception: Something went wrong'),
        );

        verify(() => mockCollectionRepository.readItemIds()).called(1);
      });
    });
  });
}
