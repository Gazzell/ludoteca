import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:mocktail/mocktail.dart';

class CollectionRepositoryMock extends Mock implements CollectionRepository {}

void main() {
  final fakeItem = Item(
    id: ItemId.fromUniqueString('0'),
    title: 'title',
    instances: const [],
    bggId: '122',
    imageUrl: '',
    thumbnailUrl: '',
    description: 'longDescription',
    minPlayers: 1,
    maxPlayers: 4,
    playingTime: 130,
    author: 'author',
    publisher: 'publisher',
    publishYear: 2000,
    complexity: 3.2,
    rating: 6.5,
  );

  group('GetItem use case', () {
    group('should return Right', () {
      test('with an ItemDetail', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() =>
                mockCollectionRepository.readItem(ItemId.fromUniqueString('0')))
            .thenAnswer(
          (_) async => Right(fakeItem),
        );

        final getItemDetailUseCase = GetItem(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getItemDetailUseCase(
          ItemParams(
            itemId: ItemId.fromUniqueString('0'),
          ),
        );

        expect(result, Right<Failure, Item>(fakeItem));

        verify(
          () => mockCollectionRepository.readItem(
            ItemId.fromUniqueString('0'),
          ),
        ).called(1);
      });
    });

    group('should return left', () {
      test('with a ServerFailure if threw an exception', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository
            .readItem(ItemId.fromUniqueString('0'))).thenThrow(
          Exception('something went wrong'),
        );

        final getItemDetailUseCase = GetItem(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getItemDetailUseCase(
          ItemParams(
            itemId: ItemId.fromUniqueString('0'),
          ),
        );

        expect(result.isLeft, true);
        expect(
          result.left,
          ServerFailure(stackTrace: 'Exception: something went wrong'),
        );

        verify(
          () => mockCollectionRepository.readItem(
            ItemId.fromUniqueString('0'),
          ),
        ).called(1);
      });
    });
  });
}
