import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_full_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/cubit/collection_item_detail_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetItemDetailUseCase extends Mock implements GetFullItem {}

void main() {
  group('CollectionItemDetailCubit', () {
    final mockGetItemDetailUseCase = MockGetItemDetailUseCase();
    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionItemDetailCubit(
          getItemDetail: mockGetItemDetailUseCase,
        ),
        expect: () => const <CollectionItemDetailCubitState>[],
      );

      blocTest(
        'CollectionItemDetailEmptyState when no itemId is provided',
        build: () => CollectionItemDetailCubit(
          getItemDetail: mockGetItemDetailUseCase,
        ),
        act: (cubit) => cubit.readItemDetail(null),
        expect: () => const <CollectionItemDetailCubitState>[
          CollectionItemDetailEmptyState(),
        ],
      );

      blocTest(
        'CollectionItemDetailErrorState when readItemIds fails',
        setUp: () => when(
          () => mockGetItemDetailUseCase.call(
            ItemParams(
              itemId: ItemId.fromUniqueString('itemId'),
            ),
          ),
        ).thenAnswer((invocation) => Future.value(Left(ServerFailure()))),
        build: () => CollectionItemDetailCubit(
          getItemDetail: mockGetItemDetailUseCase,
        ),
        act: (cubit) => cubit.readItemDetail(ItemId.fromUniqueString('itemId')),
        expect: () => const <CollectionItemDetailCubitState>[
          CollectionItemDetailLoadingState(),
          CollectionItemDetailErrorState(),
        ],
      );

      blocTest(
        'CollectionItemDetailLoadedState when readItemDetail succeds',
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
        build: () => CollectionItemDetailCubit(
          getItemDetail: mockGetItemDetailUseCase,
        ),
        act: (cubit) => cubit.readItemDetail(ItemId.fromUniqueString('itemId')),
        expect: () => <CollectionItemDetailCubitState>[
          const CollectionItemDetailLoadingState(),
          CollectionItemDetailLoadedState(
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
