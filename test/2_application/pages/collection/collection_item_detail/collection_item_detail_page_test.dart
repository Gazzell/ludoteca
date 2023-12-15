import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/cubit/collection_item_detail_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_empty.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loading.dart';

class MockCollectionItemDetailCubit
    extends MockCubit<CollectionItemDetailCubitState>
    implements CollectionItemDetailCubit {}

void main() {
  group('CollectionItemDetailPage', () {
    Widget widgetUnderTest({
      required CollectionItemDetailCubit cubit,
    }) {
      return MaterialApp(
        home: Material(
          child: BlocProvider<CollectionItemDetailCubit>(
            create: (context) => cubit,
            child: const CollectionItemDetailPage(),
          ),
        ),
      );
    }

    group('CollectionItemDetailPage', () {
      late CollectionItemDetailCubit mockCollectionItemDetailCubit;

      setUp(
        () => mockCollectionItemDetailCubit = MockCollectionItemDetailCubit(),
      );

      group('with no selectedItem', () {
        testWidgets(
          'should render a CollectionItemDetailEmpty widget',
          (WidgetTester tester) async {
            whenListen(
              mockCollectionItemDetailCubit,
              Stream.fromIterable([const CollectionItemDetailEmptyState()]),
              initialState: const CollectionItemDetailEmptyState(),
            );

            await tester.pumpWidget(
              widgetUnderTest(
                cubit: mockCollectionItemDetailCubit,
              ),
            );

            expect(find.byType(CollectionItemDetailEmpty), findsOneWidget);
          },
        );
      });

      group('with selected item', () {
        testWidgets('should render a CollectionItemDetailLoading widget',
            (WidgetTester tester) async {
          whenListen(
            mockCollectionItemDetailCubit,
            Stream.fromIterable([
              const CollectionItemDetailEmptyState(),
              const CollectionItemDetailLoadingState(),
            ]),
            initialState: const CollectionItemDetailEmptyState(),
          );

          await tester.pumpWidget(
            widgetUnderTest(
              cubit: mockCollectionItemDetailCubit,
            ),
          );

          await tester.pump();

          expect(find.byType(CollectionItemDetailLoading), findsOneWidget);
        });

        testWidgets('should render a CollectionItemDetailError widget',
            (WidgetTester tester) async {
          whenListen(
            mockCollectionItemDetailCubit,
            Stream.fromIterable([
              const CollectionItemDetailEmptyState(),
              const CollectionItemDetailLoadingState(),
              const CollectionItemDetailErrorState(),
            ]),
            initialState: const CollectionItemDetailEmptyState(),
          );

          await tester.pumpWidget(
            widgetUnderTest(cubit: mockCollectionItemDetailCubit),
          );

          await tester.pumpAndSettle();

          expect(find.byType(CollectionItemDetailError), findsOneWidget);
        });

        testWidgets('should render a CollectionItemDetailLoaded widget',
            (WidgetTester tester) async {
          whenListen(
            mockCollectionItemDetailCubit,
            Stream.fromIterable([
              const CollectionItemDetailEmptyState(),
              const CollectionItemDetailLoadingState(),
              CollectionItemDetailLoadedState(itemDetail: FullItem.empty()),
            ]),
            initialState: const CollectionItemDetailEmptyState(),
          );

          await tester.pumpWidget(
            widgetUnderTest(cubit: mockCollectionItemDetailCubit),
          );

          await tester.pumpAndSettle();

          expect(find.byType(CollectionItemDetailLoaded), findsOneWidget);
        });
      });
    });
  });
}
