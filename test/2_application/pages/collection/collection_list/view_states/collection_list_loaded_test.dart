import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/widgets/collection_list_item.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../mocks/go_route_mock.dart';

class MockCollectionCubit extends MockCubit<CollectionCubitState>
    implements CollectionCubit {}

void main() {
  Widget widgetUnderTest({
    required List<Item> items,
    required CollectionCubit cubit,
    required MockGoRouter router,
  }) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => cubit,
        child: MockGoRouterProvider(
          goRouter: router,
          child: Material(
            child: CollectionListLoaded(
              items: items,
            ),
          ),
        ),
      ),
    );
  }

  group(
    'CollectionListLoaded view state',
    () {
      late MockCollectionCubit mockCollectionCubit;
      late MockGoRouter mockGoRouter;
      setUp(() {
        mockCollectionCubit = MockCollectionCubit();
        mockGoRouter = MockGoRouter();
      });

      testWidgets(
        'should render a list of card items',
        (WidgetTester widgetTester) async {
          whenListen(
            mockCollectionCubit,
            Stream.fromIterable(
              [const CollectionItemSelectedState(selectedItem: null)],
            ),
            initialState: const CollectionItemSelectedState(selectedItem: null),
          );

          await mockNetworkImages(
            () async => widgetTester.pumpWidget(
              widgetUnderTest(
                items: List<Item>.generate(
                  2,
                  (index) => Item.empty(),
                ),
                cubit: mockCollectionCubit,
                router: mockGoRouter,
              ),
            ),
          );

          await widgetTester.pumpAndSettle();

          expect(find.byType(CollectionListItem), findsNWidgets(2));
        },
      );

      testWidgets(
        'should select item',
        (WidgetTester widgetTester) async {
          whenListen(
            mockCollectionCubit,
            Stream.fromIterable(
              [const CollectionItemSelectedState(selectedItem: null)],
            ),
            initialState: const CollectionItemSelectedState(selectedItem: null),
          );

          await mockNetworkImages(
            () async => widgetTester.pumpWidget(
              widgetUnderTest(
                items: List<Item>.generate(
                  2,
                  (index) => Item(
                    id: ItemId.fromUniqueString('$index'),
                    title: '',
                    status: ItemStatus.available,
                  ),
                  growable: false,
                ),
                cubit: mockCollectionCubit,
                router: mockGoRouter,
              ),
            ),
          );

          await widgetTester.pumpAndSettle();

          final cards = find.byType(CollectionListItem);

          await widgetTester.tap(cards.at(1));
          await widgetTester.pumpAndSettle();

          verify(
            () => mockCollectionCubit.selectItem(ItemId.fromUniqueString('1')),
          ).called(1);
        },
      );

      testWidgets('should navigate to add item page',
          (WidgetTester tester) async {
        tester.view.physicalSize = const Size(300, 200);
        tester.view.devicePixelRatio = 1;

        addTearDown(tester.view.resetPhysicalSize);

        whenListen(
          mockCollectionCubit,
          Stream.fromIterable(
            [const CollectionItemSelectedState(selectedItem: null)],
          ),
          initialState: const CollectionItemSelectedState(selectedItem: null),
        );

        when(() => mockGoRouter.pushNamed('addItem'))
            .thenAnswer((invocation) async => null);

        await tester.pumpWidget(widgetUnderTest(
          items: [],
          cubit: mockCollectionCubit,
          router: mockGoRouter,
        ));

        final addButton = find.byType(FloatingActionButton);

        expect(addButton, findsOneWidget);

        verifyNever(() => mockGoRouter.pushNamed('addItem'));

        await tester.tap(addButton);

        verify(() => mockGoRouter.pushNamed('addItem')).called(1);
      });
    },
  );
}
