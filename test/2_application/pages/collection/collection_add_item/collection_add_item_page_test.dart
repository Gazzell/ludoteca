import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/cubit/collection_add_item_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_loading.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockCollectionAddItemCubit extends MockCubit<CollectionAddItemCubitState>
    implements CollectionAddItemCubit {}

void main() {
  group('CollectionAddItemPage', () {
    late CollectionAddItemCubit mockCollectionAddItemCubit;

    setUp(() => mockCollectionAddItemCubit = MockCollectionAddItemCubit());

    Widget widgetUnderTest({
      required CollectionAddItemCubit cubit,
      bool showAppBar = false,
      String? title,
    }) {
      return MaterialApp(
        home: BlocProvider(
          create: (context) => cubit,
          child: CollectionAddItemPage(
            showAppBar: showAppBar,
            title: title,
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
        final fullItem = FullItem.empty();
        whenListen(
          mockCollectionAddItemCubit,
          Stream.fromIterable(
            [
              const CollectionAddItemEmptyState(),
              CollectionAddItemLoadedState(itemDetail: fullItem),
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
  });
}
