import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_item_ids.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/cubit/collection_list_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCollectionItemIdsUseCase extends Mock
    implements GetCollectionItemIds {}

void main() {
  final mockGetCollectionItemIdsUseCase = MockGetCollectionItemIdsUseCase();

  group('CollectionListCubit', () {
    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionListCubit(
          getCollectionItemIds: mockGetCollectionItemIdsUseCase,
        ),
        expect: () => const <CollectionListCubitState>[],
      );

      blocTest(
        'CollectionListErrorState when readItemIds fails',
        setUp: () =>
            when(() => mockGetCollectionItemIdsUseCase.call(NoParams()))
                .thenAnswer(
          (invocation) => Future.value(
            Left(ServerFailure()),
          ),
        ),
        build: () => CollectionListCubit(
          getCollectionItemIds: mockGetCollectionItemIdsUseCase,
        ),
        act: (cubit) => cubit.readItemIds(),
        expect: () => const <CollectionListCubitState>[
          CollectionListErrorState(),
        ],
      );

      blocTest(
        'CollectionListLoadedState when readItemIds succeeds',
        setUp: () =>
            when(() => mockGetCollectionItemIdsUseCase.call(NoParams()))
                .thenAnswer(
          (invocation) => Future.value(
            Right([ItemId.fromUniqueString('item-0')]),
          ),
        ),
        build: () => CollectionListCubit(
          getCollectionItemIds: mockGetCollectionItemIdsUseCase,
        ),
        act: (cubit) => cubit.readItemIds(),
        expect: () => <CollectionListCubitState>[
          CollectionListItemIdsLoadedState(
            itemIds: [ItemId.fromUniqueString('item-0')],
          ),
        ],
      );
    });
  });
}
