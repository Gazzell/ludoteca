import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_items.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:mocktail/mocktail.dart';

class CollectionRepositoryMock extends Mock implements CollectionRepository {}

final collectionItems = List<Item>.generate(
  5,
  (index) => Item(
    id: ItemId.fromUniqueString(index.toString()),
    title: 'title',
    description: 'description',
  ),
);

void main() {
  group('GetCollectionItems use case', () {
    group('should return Right', () {
      test('with a list of items', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository.readItems()).thenAnswer(
          (_) async => Right(collectionItems),
        );

        final getCollectionItemsUseCase = GetCollectionItems(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getCollectionItemsUseCase(NoParams());

        expect(result, Right<Failure, List<Item>>(collectionItems));

        verify(() => mockCollectionRepository.readItems()).called(1);
      });
    });

    group('should return Left', () {
      test('with a ServerFailure', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository.readItems()).thenAnswer(
          (_) async => Left(ServerFailure()),
        );

        final getCollectionItemsUseCase = GetCollectionItems(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getCollectionItemsUseCase(NoParams());

        expect(result, Left<Failure, List<ItemId>>(ServerFailure()));

        verify(() => mockCollectionRepository.readItems()).called(1);
      });

      test('with a ServerFailure if threw an exception', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository.readItems())
            .thenThrow(Exception('Something went wrong'));

        final getCollectionItemsUseCase = GetCollectionItems(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getCollectionItemsUseCase(NoParams());

        expect(result.isLeft, true);
        expect(
          result.left,
          ServerFailure(stackTrace: 'Exception: Something went wrong'),
        );

        verify(() => mockCollectionRepository.readItems()).called(1);
      });
    });
  });
}
