import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/cubit/collection_add_item_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_loading.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../helpers.dart';

class MockCollectionAddItemCubit extends MockCubit<CollectionAddItemCubitState>
    implements CollectionAddItemCubit {}

class MockCollectionCubit extends MockCubit<CollectionCubitState>
    implements CollectionCubit {}

void main() {
  group('CollectionAddItemPage', () {
    late CollectionAddItemCubit mockCollectionAddItemCubit;
    setUp(() {
      mockCollectionAddItemCubit = MockCollectionAddItemCubit();
    });

    Widget widgetUnderTest({
      required CollectionAddItemCubit cubit,
      bool showAppBar = false,
      String? title,
      Function(Item?)? onItemAdded,
    }) {
      return withMaterialAppTranslation(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => cubit,
              ),
              BlocProvider<CollectionCubit>(
                create: (context) => MockCollectionCubit(),
              ),
            ],
            child: CollectionAddItemPage(
              showAppBar: showAppBar,
              title: title,
              onItemAdded: onItemAdded ?? (_) {},
            ),
          ),
        ),
      );
    }

    testWidgets(
      'renders a CollectionAddItemPage with no header',
      (WidgetTester tester) async {
        whenListen(
          mockCollectionAddItemCubit,
          Stream.fromIterable([const CollectionAddItemEmptyState()]),
          initialState: const CollectionAddItemEmptyState(),
        );

        await tester
            .pumpWidget(widgetUnderTest(cubit: mockCollectionAddItemCubit));

        expect(find.byType(AppBar), findsNothing);
        expect(find.text('title'), findsNothing);
        expect(find.byType(SearchBar), findsOneWidget);
      },
    );

    testWidgets(
      'renders a CollectionAddItemPage with a header',
      (WidgetTester tester) async {
        whenListen(
          mockCollectionAddItemCubit,
          Stream.fromIterable([const CollectionAddItemEmptyState()]),
          initialState: const CollectionAddItemEmptyState(),
        );

        await tester.pumpWidget(widgetUnderTest(
          cubit: mockCollectionAddItemCubit,
          showAppBar: true,
          title: 'title',
        ));

        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('title'), findsOneWidget);
        expect(find.byType(SearchBar), findsOneWidget);
      },
    );

    testWidgets(
      'when [CollectionAddItemLoadingState] renders a CollectionAddItemLoading',
      (WidgetTester tester) async {
        whenListen(
          mockCollectionAddItemCubit,
          Stream.fromIterable([
            const CollectionAddItemEmptyState(),
            const CollectionAddItemLoadingState(),
          ]),
          initialState: const CollectionAddItemEmptyState(),
        );

        await tester
            .pumpWidget(widgetUnderTest(cubit: mockCollectionAddItemCubit));

        await tester.pump();

        expect(find.byType(CollectionAddItemLoading), findsOneWidget);
      },
    );

    testWidgets(
      'when [CollectionAddItemErrorState] renders a CollectionAddItemError',
      (WidgetTester tester) async {
        whenListen(
          mockCollectionAddItemCubit,
          Stream.fromIterable([
            const CollectionAddItemEmptyState(),
            const CollectionAddItemErrorState(),
          ]),
          initialState: const CollectionAddItemEmptyState(),
        );

        await tester
            .pumpWidget(widgetUnderTest(cubit: mockCollectionAddItemCubit));

        await tester.pump();

        expect(find.byType(CollectionAddItemError), findsOneWidget);
      },
    );

    testWidgets(
      'with [CollectionAddItemLoadedState] renders a CollectionAddItemLoaded',
      (WidgetTester tester) async {
        final fullItem = Item.empty();
        whenListen(
          mockCollectionAddItemCubit,
          Stream.fromIterable(
            [
              const CollectionAddItemEmptyState(),
              CollectionAddItemLoadedState(item: fullItem),
            ],
          ),
          initialState: const CollectionAddItemEmptyState(),
        );

        await tester.pumpWidget(
          widgetUnderTest(cubit: mockCollectionAddItemCubit),
        );

        await mockNetworkImages(() async => tester.pump());

        expect(find.byType(CollectionAddItemLoaded), findsOneWidget);
      },
    );

    testWidgets('should add item to collection when add item button is pressed',
        (WidgetTester tester) async {
      final item = Item(
        id: ItemId.fromUniqueString('111'),
        title: '',
        instances: const [],
      );

      whenListen(
        mockCollectionAddItemCubit,
        Stream.fromIterable([
          const CollectionAddItemEmptyState(),
          const CollectionAddItemLoadingState(),
          CollectionAddItemLoadedState(item: item),
        ]),
        initialState: const CollectionAddItemEmptyState(),
      );

      when(() => mockCollectionAddItemCubit.state).thenReturn(
        CollectionAddItemLoadedState(item: item),
      );

      await tester.pumpWidget(
        widgetUnderTest(cubit: mockCollectionAddItemCubit),
      );

      await mockNetworkImages(() async => await tester.pump());

      final searchBar = find.byType(SearchBar);
      expect(searchBar, findsOneWidget);

      await tester.enterText(searchBar, '111');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      verify(
        () => mockCollectionAddItemCubit
            .readItemDetail(ItemId.fromUniqueString('111')),
      ).called(1);

      final addButton = find.byIcon(Icons.done_outline_outlined);
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);

      await tester.pump();

      verify(
        () => mockCollectionAddItemCubit.addCollectionItem(item),
      ).called(1);
    });
  });
}
