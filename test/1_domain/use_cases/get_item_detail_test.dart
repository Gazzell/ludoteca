import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item_detail.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_item_detail.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:mocktail/mocktail.dart';

class CollectionRepositoryMock extends Mock implements CollectionRepository {}

void main() {
  final itemDetail = ItemDetail(
    id: ItemId.fromUniqueString('0'),
    title: 'title',
    description: 'description',
    imageUrl: '',
    author: 'author',
    publisher: 'publisher',
    longDescription: 'longDescription',
    adquisitionDate: DateTime.now(),
  );

  group('GetItemDetail use case', () {
    group('should return Right', () {
      test('with an ItemDetail', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository
            .readItemDetail(ItemId.fromUniqueString('0'))).thenAnswer(
          (_) async => Right(itemDetail),
        );

        final getItemDetailUseCase = GetItemDetail(
          collectionRepository: mockCollectionRepository,
        );

        final result = await getItemDetailUseCase(
          ItemParams(
            itemId: ItemId.fromUniqueString('0'),
          ),
        );

        expect(result, Right<Failure, ItemDetail>(itemDetail));

        verify(
          () => mockCollectionRepository.readItemDetail(
            ItemId.fromUniqueString('0'),
          ),
        ).called(1);
      });
    });

    group('should return left', () {
      test('with a ServerFailure if threw an exception', () async {
        final mockCollectionRepository = CollectionRepositoryMock();
        when(() => mockCollectionRepository
            .readItemDetail(ItemId.fromUniqueString('0'))).thenThrow(
          Exception('something went wrong'),
        );

        final getItemDetailUseCase = GetItemDetail(
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
          () => mockCollectionRepository.readItemDetail(
            ItemId.fromUniqueString('0'),
          ),
        ).called(1);
      });
    });
  });
}
