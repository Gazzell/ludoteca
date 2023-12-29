import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/cubit/collection_add_item_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetItemDetailUseCase extends Mock implements GetItem {}

void main() {
  group('CollectionAddItemCubit', () {
    final mockGetItemDetailUseCase = MockGetItemDetailUseCase();
    final fakeItem = Item(
      id: ItemId.fromUniqueString('itemId'),
      title: 'title',
      instances: const [],
      bggId: '122',
      imageUrl: '',
      thumbnailUrl: '',
      description: 'longDescription',
      minAge: 5,
      minPlayers: 2,
      maxPlayers: 2,
      publisher: 'publisher',
      publishYear: 2000,
      author: 'author',
      complexity: 2.3,
      rating: 7.6,
    );

    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionAddItemCubit(
          getItem: mockGetItemDetailUseCase,
        ),
        expect: () => const <CollectionAddItemCubitState>[],
      );

      blocTest(
        'CollectionAddItemErrorState when readItemIds fails',
        setUp: () => when(
          () => mockGetItemDetailUseCase.call(
            ItemParams(
              itemId: ItemId.fromUniqueString('itemId'),
            ),
          ),
        ).thenAnswer((invocation) => Future.value(Left(ServerFailure()))),
        build: () => CollectionAddItemCubit(
          getItem: mockGetItemDetailUseCase,
        ),
        act: (cubit) => cubit.readItemDetail(ItemId.fromUniqueString('itemId')),
        expect: () => const <CollectionAddItemCubitState>[
          CollectionAddItemLoadingState(),
          CollectionAddItemErrorState(),
        ],
      );

      blocTest(
        'CollectionAddItemLoadedState when readItemDetail succeds',
        setUp: () => when(
          () => mockGetItemDetailUseCase.call(
            ItemParams(
              itemId: ItemId.fromUniqueString('itemId'),
            ),
          ),
        ).thenAnswer((invocation) => Future.value(Right(fakeItem))),
        build: () => CollectionAddItemCubit(
          getItem: mockGetItemDetailUseCase,
        ),
        act: (cubit) => cubit.readItemDetail(ItemId.fromUniqueString('itemId')),
        expect: () => <CollectionAddItemCubitState>[
          const CollectionAddItemLoadingState(),
          CollectionAddItemLoadedState(item: fakeItem),
        ],
      );
    });
  });
}
