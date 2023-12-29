import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/cubit/collection_item_detail_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetItemDetailUseCase extends Mock implements GetItem {}

void main() {
  group('CollectionItemDetailCubit', () {
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
        build: () => CollectionItemDetailCubit(
          getItem: mockGetItemDetailUseCase,
        ),
        expect: () => const <CollectionItemDetailCubitState>[],
      );

      blocTest(
        'CollectionItemDetailEmptyState when no itemId is provided',
        build: () => CollectionItemDetailCubit(
          getItem: mockGetItemDetailUseCase,
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
          getItem: mockGetItemDetailUseCase,
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
          (invocation) => Future.value(Right(fakeItem)),
        ),
        build: () => CollectionItemDetailCubit(
          getItem: mockGetItemDetailUseCase,
        ),
        act: (cubit) => cubit.readItemDetail(ItemId.fromUniqueString('itemId')),
        expect: () => <CollectionItemDetailCubitState>[
          const CollectionItemDetailLoadingState(),
          CollectionItemDetailLoadedState(item: fakeItem),
        ],
      );
    });
  });
}
