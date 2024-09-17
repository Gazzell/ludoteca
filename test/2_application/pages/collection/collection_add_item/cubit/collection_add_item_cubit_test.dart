import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/add_item_instance.dart';
import 'package:ludoteca/1_domain/use_cases/get_bgg_item.dart';
import 'package:ludoteca/1_domain/use_cases/add_collection_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/cubit/collection_add_item_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBggItemDetailUseCase extends Mock implements GetBggItem {}

class MockAddCollectionItemUseCase extends Mock implements AddCollectionItem {}

class MockAddItemInstanceUseCase extends Mock implements AddItemInstance {}

void main() {
  group('CollectionAddItemCubit', () {
    final mockGetBggItemDetailUseCase = MockGetBggItemDetailUseCase();
    final mockAddCollectionItemUseCase = MockAddCollectionItemUseCase();
    final mockAddItemInstanceUseCase = MockAddItemInstanceUseCase();

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

    final fakeItemInstance = ItemInstance(
      id: ItemInstanceId.fromUniqueString('1'),
      itemId: fakeItem.id,
      status: ItemInstanceStatus.available,
    );

    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionAddItemCubit(
            getBggItem: mockGetBggItemDetailUseCase,
            addItem: mockAddCollectionItemUseCase,
            addItemInstance: mockAddItemInstanceUseCase),
        expect: () => const <CollectionAddItemCubitState>[],
      );

      blocTest(
        'CollectionAddItemErrorState when readItemIds fails',
        setUp: () => when(
          () => mockGetBggItemDetailUseCase.call(
            GetBggItemParams(
              itemId: 'itemId',
            ),
          ),
        ).thenAnswer((invocation) => Future.value(Left(ServerFailure()))),
        build: () => CollectionAddItemCubit(
          getBggItem: mockGetBggItemDetailUseCase,
          addItem: mockAddCollectionItemUseCase,
          addItemInstance: mockAddItemInstanceUseCase,
        ),
        act: (cubit) => cubit.readItemDetail('itemId'),
        expect: () => const <CollectionAddItemCubitState>[
          CollectionAddItemLoadingState(),
          CollectionAddItemErrorState(),
        ],
      );

      blocTest(
        'CollectionAddItemLoadedState when readItemDetail succeds',
        setUp: () => when(() => mockGetBggItemDetailUseCase
                .call(GetBggItemParams(itemId: 'itemId')))
            .thenAnswer((invocation) => Future.value(Right(fakeItem))),
        build: () => CollectionAddItemCubit(
          getBggItem: mockGetBggItemDetailUseCase,
          addItem: mockAddCollectionItemUseCase,
          addItemInstance: mockAddItemInstanceUseCase,
        ),
        act: (cubit) => cubit.readItemDetail('itemId'),
        expect: () => <CollectionAddItemCubitState>[
          const CollectionAddItemLoadingState(),
          CollectionAddItemLoadedState(item: fakeItem),
        ],
      );

      blocTest(
        'CollectionAddItemErrorState when addCollectionItem fails',
        setUp: () => when(
          () => mockAddCollectionItemUseCase.call(
            AddItemParams(item: fakeItem),
          ),
        ).thenAnswer((invocation) => Future.value(Left(ServerFailure()))),
        build: () => CollectionAddItemCubit(
          getBggItem: mockGetBggItemDetailUseCase,
          addItem: mockAddCollectionItemUseCase,
          addItemInstance: mockAddItemInstanceUseCase,
        ),
        act: (cubit) => cubit.addCollectionItem(fakeItem),
        expect: () => const <CollectionAddItemCubitState>[
          CollectionAddItemLoadingState(),
          CollectionAddItemErrorState(),
        ],
      );

      blocTest(
        'CollectionAddItemAddedState when addCollectionItem succeds',
        setUp: () {
          registerFallbackValue(
              AddItemInstanceParams(itemInstance: fakeItemInstance));
          when(
            () => mockAddCollectionItemUseCase.call(AddItemParams(
              item: fakeItem,
            )),
          ).thenAnswer((invocation) => Future.value(Right(fakeItem)));
          when(
            () => mockAddItemInstanceUseCase
                .call(any(that: isA<AddItemInstanceParams>())),
          ).thenAnswer(
            (invocation) => Future.value(Right(fakeItemInstance)),
          );
        },
        build: () => CollectionAddItemCubit(
          getBggItem: mockGetBggItemDetailUseCase,
          addItem: mockAddCollectionItemUseCase,
          addItemInstance: mockAddItemInstanceUseCase,
        ),
        act: (cubit) => cubit.addCollectionItem(fakeItem),
        expect: () => <CollectionAddItemCubitState>[
          const CollectionAddItemLoadingState(),
          CollectionAddItemAddedState(item: fakeItem),
        ],
        verify: (_) {
          verify(
            () => mockAddItemInstanceUseCase.call(any(
              that: isA<AddItemInstanceParams>(),
            )),
          ).called(1);
        },
      );
    });
  });
}
