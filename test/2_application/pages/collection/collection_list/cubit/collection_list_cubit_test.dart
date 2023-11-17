import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_items.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/cubit/collection_list_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCollectionItemsUseCase extends Mock
    implements GetCollectionItems {}

void main() {
  final mockGetCollectionItemsUseCase = MockGetCollectionItemsUseCase();

  group('CollectionListCubit', () {
    group('should emit', () {
      blocTest(
        'nothing when no method is called',
        build: () => CollectionListCubit(
          getCollectionItems: mockGetCollectionItemsUseCase,
        ),
        expect: () => const <CollectionListCubitState>[],
      );

      blocTest(
        'CollectionListErrorState when readItemIds fails',
        setUp: () => when(() => mockGetCollectionItemsUseCase.call(NoParams()))
            .thenAnswer(
          (invocation) => Future.value(
            Left(ServerFailure()),
          ),
        ),
        build: () => CollectionListCubit(
          getCollectionItems: mockGetCollectionItemsUseCase,
        ),
        act: (cubit) => cubit.readItems(),
        expect: () => const <CollectionListCubitState>[
          CollectionListErrorState(),
        ],
      );

      blocTest(
        'CollectionListLoadedState when readItemIds succeeds',
        setUp: () => when(() => mockGetCollectionItemsUseCase.call(NoParams()))
            .thenAnswer(
          (invocation) => Future.value(
            Right([
              Item(
                id: ItemId.fromUniqueString('0'),
                title: 'title',
                description: 'description',
              )
            ]),
          ),
        ),
        build: () => CollectionListCubit(
          getCollectionItems: mockGetCollectionItemsUseCase,
        ),
        act: (cubit) => cubit.readItems(),
        expect: () => <CollectionListCubitState>[
          CollectionListItemsLoadedState(
            items: [
              Item(
                id: ItemId.fromUniqueString('0'),
                title: 'title',
                description: 'description',
              ),
            ],
          ),
        ],
      );
    });
  });
}
