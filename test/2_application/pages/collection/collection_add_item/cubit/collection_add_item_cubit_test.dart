import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_full_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/cubit/collection_add_item_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetItemDetailUseCase extends Mock implements GetFullItem {}

void main() {
  group('CollectionAddItemCubit', () {
    final mockGetItemDetailUseCase = MockGetItemDetailUseCase();
    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionAddItemCubit(
          getItemDetail: mockGetItemDetailUseCase,
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
          getItemDetail: mockGetItemDetailUseCase,
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
        ).thenAnswer(
          (invocation) => Future.value(
            Right(
              FullItem(
                id: ItemId.fromUniqueString('itemId'),
                title: 'title',
                status: ItemStatus.available,
                imageUrl: '',
                publisher: 'publisher',
                author: 'author',
                longDescription: 'longDescription',
              ),
            ),
          ),
        ),
        build: () => CollectionAddItemCubit(
          getItemDetail: mockGetItemDetailUseCase,
        ),
        act: (cubit) => cubit.readItemDetail(ItemId.fromUniqueString('itemId')),
        expect: () => <CollectionAddItemCubitState>[
          const CollectionAddItemLoadingState(),
          CollectionAddItemLoadedState(
            itemDetail: FullItem(
              id: ItemId.fromUniqueString('itemId'),
              title: 'title',
              status: ItemStatus.available,
              imageUrl: '',
              publisher: 'publisher',
              author: 'author',
              longDescription: 'longDescription',
            ),
          ),
        ],
      );
    });
  });
}
