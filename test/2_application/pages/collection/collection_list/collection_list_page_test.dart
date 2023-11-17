import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/cubit/collection_list_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loading.dart';

class MockCollectionListCubit extends MockCubit<CollectionListCubitState>
    implements CollectionListCubit {}

void main() {
  Widget widgetUnderTest({required CollectionListCubit cubit}) {
    return MaterialApp(
      home: Material(
        child: BlocProvider<CollectionListCubit>(
          create: (context) => cubit,
          child: const CollectionListPage(),
        ),
      ),
    );
  }

  group('CollectionListPage', () {
    late CollectionListCubit mockCollectionListCubit;

    setUp(() => mockCollectionListCubit = MockCollectionListCubit());

    testWidgets(
      'should render CollectionListLoading view state initially',
      (WidgetTester tester) async {
        whenListen(
          mockCollectionListCubit,
          Stream.fromIterable([const CollectionListLoadingState()]),
          initialState: const CollectionListLoadingState(),
        );

        await tester.pumpWidget(widgetUnderTest(
          cubit: mockCollectionListCubit,
        ));

        expect(find.byType(CollectionListLoading), findsOneWidget);
      },
    );

    testWidgets('should render CollectionListError view state on loading error',
        (WidgetTester tester) async {
      whenListen(
        mockCollectionListCubit,
        Stream.fromIterable(
          [
            const CollectionListLoadingState(),
            const CollectionListErrorState(),
          ],
        ),
        initialState: const CollectionListLoadingState(),
      );

      await tester.pumpWidget(widgetUnderTest(
        cubit: mockCollectionListCubit,
      ));

      await tester.pumpAndSettle();

      expect(find.byType(CollectionListError), findsOneWidget);
    });

    testWidgets('should render CollectionListLoaded view state on loaded',
        (WidgetTester tester) async {
      whenListen(
        mockCollectionListCubit,
        Stream.fromIterable(
          [
            const CollectionListLoadingState(),
            CollectionListItemIdsLoadedState(itemIds: [
              ItemId.fromUniqueString('an item'),
            ]),
          ],
        ),
        initialState: const CollectionListLoadingState(),
      );

      await tester.pumpWidget(widgetUnderTest(
        cubit: mockCollectionListCubit,
      ));

      await tester.pumpAndSettle();

      expect(find.byType(CollectionListLoaded), findsOneWidget);
    });
  });
}