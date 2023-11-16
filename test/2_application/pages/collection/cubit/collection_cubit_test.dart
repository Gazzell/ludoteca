import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_item_ids.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCollectionItemIdsUseCase extends Mock
    implements GetCollectionItemIds {}

void main() {
  final mockGetCollectionItemIdsUseCase = MockGetCollectionItemIdsUseCase();

  group('CollectionCubit', () {
    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionCubit(
          getCollectionItemIds: mockGetCollectionItemIdsUseCase,
        ),
        expect: () => const <CollectionCubitState>[],
      );

      blocTest(
        '[CollectionLoadingState, CollectionErrorState] when readItemIds fails',
        setUp: () =>
            when(() => mockGetCollectionItemIdsUseCase.call(NoParams()))
                .thenAnswer(
          (invocation) => Future.value(
            Left(ServerFailure()),
          ),
        ),
        build: () => CollectionCubit(
          getCollectionItemIds: mockGetCollectionItemIdsUseCase,
        ),
        act: (cubit) => cubit.readItemIds(),
        expect: () => const <CollectionCubitState>[
          CollectionLoadingState(),
          CollectionErrorState(),
        ],
      );

      blocTest(
        '[CollectionLoadingState, CollectionLoadedState] when readItemIds succeeds',
        setUp: () =>
            when(() => mockGetCollectionItemIdsUseCase.call(NoParams()))
                .thenAnswer(
          (invocation) => Future.value(
            Right([ItemId.fromUniqueString('item-0')]),
          ),
        ),
        build: () => CollectionCubit(
          getCollectionItemIds: mockGetCollectionItemIdsUseCase,
        ),
        act: (cubit) => cubit.readItemIds(),
        expect: () => <CollectionCubitState>[
          const CollectionLoadingState(),
          CollectionItemIdsLoadedState(
            itemIds: [ItemId.fromUniqueString('item-0')],
          ),
        ],
      );
    });
  });
}
