import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_items.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/cubit/collection_list_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/widgets/collection_list_item.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../1_domain/use_cases/add_collection_item_test.dart';
import '../../../../../helpers.dart';

abstract class CallbackFunction {
  void call(ItemId id);
}

class OnItemTappedMock extends Mock implements CallbackFunction {}

class MockCollectionCubit extends MockCubit<CollectionCubitState>
    implements CollectionCubit {}

class MockCollectionListCubit extends MockCubit<CollectionListCubitState>
    implements CollectionListCubit {}

void main() {
  Widget widgetUnderTest({
    required List<Item> items,
    Function(ItemId)? onItemTapped,
    ItemId? selectedItem,
    MockCollectionCubit? mockCollectionCubit,
    MockCollectionListCubit? mockCollectionListCubit,
  }) {
    return withMaterialAppTranslation(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => mockCollectionCubit ?? CollectionCubit(),
          ),
          BlocProvider(
            create: (context) =>
                mockCollectionListCubit ??
                CollectionListCubit(
                  getCollectionItems: GetCollectionItems(
                    collectionRepository: MockCollectionRepository(),
                  ),
                ),
          ),
        ],
        child: Material(
          child: CollectionListLoaded(
            items: items,
            onItemTapped: onItemTapped,
            selectedItem: selectedItem,
          ),
        ),
      ),
    );
  }

  group('CollectionListLoaded view state', () {
    testWidgets(
      'should render a list of card items',
      (WidgetTester widgetTester) async {
        await mockNetworkImages(
          () async => widgetTester.pumpWidget(
            widgetUnderTest(
              items: List<Item>.generate(
                2,
                (index) => Item.empty(),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        expect(find.byType(CollectionListItem), findsNWidgets(2));
      },
    );

    testWidgets(
      'should emit itemSelected when an item is tapped',
      (WidgetTester widgetTester) async {
        final onItemTappedMock = OnItemTappedMock();

        await mockNetworkImages(
          () async => widgetTester.pumpWidget(
            widgetUnderTest(
              items: List<Item>.generate(
                2,
                (index) => Item(
                  id: ItemId.fromUniqueString('$index'),
                  title: '',
                  instances: const [],
                ),
                growable: false,
              ),
              onItemTapped: onItemTappedMock.call,
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        final cards = find.byType(CollectionListItem);

        await widgetTester.tap(cards.at(1));

        verify(() => onItemTappedMock.call(ItemId.fromUniqueString('1')))
            .called(1);
      },
    );

    testWidgets(
        'should add an item to the list when an item is added to the state',
        (WidgetTester widgetTester) async {
      final mockCollectionCubit = MockCollectionCubit();
      final mockCollectionListCubit = MockCollectionListCubit();

      whenListen(
        mockCollectionCubit,
        Stream.fromIterable([
          const CollectionShowingState(),
          const CollectionItemAddingState(),
          CollectionItemAddedState(item: Item.empty()),
        ]),
        initialState: const CollectionShowingState(),
      );

      when(() => mockCollectionCubit.state).thenReturn(
        CollectionItemAddedState(item: Item.empty()),
      );

      await mockNetworkImages(
        () async => widgetTester.pumpWidget(
          widgetUnderTest(
            items: List<Item>.generate(
              2,
              (index) => Item(
                id: ItemId.fromUniqueString('$index'),
                title: '',
                instances: const [],
              ),
              growable: false,
            ),
            mockCollectionCubit: mockCollectionCubit,
            mockCollectionListCubit: mockCollectionListCubit,
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      verify(() => mockCollectionListCubit.updateCollection(any())).called(1);
    });

    testWidgets('search bar should not be visible if no items in the list',
        (WidgetTester widgetTester) async {
      widgetUnderTest(items: List<Item>.empty());
      await widgetTester.pumpAndSettle();

      expect(find.byType(SearchBar), findsNothing);
    });

    testWidgets('search bar should be visible if items in the list',
        (WidgetTester widgetTester) async {
      await mockNetworkImages(
        () async => widgetTester.pumpWidget(
          widgetUnderTest(
            items: List<Item>.generate(
              2,
              (index) => Item(
                id: ItemId.fromUniqueString('$index'),
                title: '',
                instances: const [],
              ),
              growable: false,
            ),
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      expect(find.byType(SearchBar), findsOneWidget);
    });

    testWidgets('search bar should filter items by title',
        (WidgetTester widgetTester) async {
      final itemList = List<Item>.generate(
        10,
        (index) => Item(
          id: ItemId.fromUniqueString('$index'),
          title: 'Item ${index + 1}',
          instances: const [],
        ),
        growable: false,
      );

      await mockNetworkImages(
        () async => widgetTester.pumpWidget(
          widgetUnderTest(
            items: itemList,
            onItemTapped: (_) {},
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(find.byType(SearchBar), '1');

      await widgetTester.pumpAndSettle();

      expect(find.byType(CollectionListItem), findsNWidgets(2));
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 10'), findsOneWidget);

      await widgetTester.enterText(find.byType(SearchBar), '10');

      await widgetTester.pumpAndSettle();

      expect(find.byType(CollectionListItem), findsNWidgets(1));
      expect(find.text('Item 10'), findsOneWidget);
    });

    testWidgets('searchbar filtered results should be sorted by title',
        (WidgetTester tester) async {
      final items = [
        Item(
          id: ItemId.fromUniqueString('1'),
          title: 'Title with text',
          instances: const [],
        ),
        Item(
          id: ItemId.fromUniqueString('2'),
          title: 'Item 2',
          instances: const [],
        ),
        Item(
          id: ItemId.fromUniqueString('3'),
          title: 'A different title with text',
          instances: const [],
        ),
      ];

      await mockNetworkImages(
        () async => tester.pumpWidget(
          widgetUnderTest(
            items: items,
            onItemTapped: (_) {},
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(SearchBar), 'text');

      await tester.pumpAndSettle();

      final sortedItems = tester
          .widgetList<CollectionListItem>(find.byType(CollectionListItem));

      expect(sortedItems.length, 2);
      expect(
        sortedItems.elementAt(0).item.title,
        'A different title with text',
      );
      expect(
        sortedItems.elementAt(1).item.title,
        'Title with text',
      );
    });
  });
}
