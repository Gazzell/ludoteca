import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/repositories/bgg_repository.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_mock.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/widgets/collection_list_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_page.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../helpers.dart';
import '../../../mocks/go_route_mock.dart';

class MockCollectionCubit extends MockCubit<CollectionCubitState>
    implements CollectionCubit {}

class MockBggRepository extends Mock implements BggRepository {}

void main() {
  Widget widgetUnderTest({MockGoRouter? router}) {
    return withMaterialAppTranslation(
      Material(
        child: MockGoRouterProvider(
          goRouter: router ?? MockGoRouter(),
          child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider<CollectionRepository>(
                  create: (context) => CollectionRepositoryMock(),
                ),
                RepositoryProvider<BggRepository>(
                  create: (context) => MockBggRepository(),
                ),
              ],
              child: BlocProvider(
                create: (context) => CollectionCubit(),
                child: const CollectionPage(),
              )),
        ),
      ),
    );
  }

  group('CollectionPage', () {
    testWidgets('should render a CollectionListPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.byType(CollectionListPage), findsOneWidget);
    });

    testWidgets('should render a CollectionItemDetail page',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.byType(CollectionItemDetailPage), findsOneWidget);
    });

    // TODO: tests using physicalSize seems to be very flakey. Find a way of improving these
    testWidgets('should navigate to item detail page on small screen',
        (WidgetTester tester) async {
      final mockGoRouter = MockGoRouter();

      tester.view.physicalSize = const Size(300, 200);
      tester.view.devicePixelRatio = 1;

      addTearDown(tester.view.resetPhysicalSize);

      when(() => mockGoRouter.pushNamed('itemDetail'))
          .thenAnswer((invocation) async => Future.value('anything'));

      await mockNetworkImages(() async {
        await tester.pumpWidget(widgetUnderTest(router: mockGoRouter));
        await tester.pumpAndSettle();
      });

      final item = find.byType(CollectionListItem).first;

      expect(item, findsOneWidget);

      await tester.tap(item);

      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.pushNamed(
          'itemDetail',
          pathParameters: {
            'itemId': 'item-0',
          },
        ),
      ).called(1);
    });

    testWidgets('selecting item should render item detail',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(widgetUnderTest());
        await tester.pumpAndSettle();
      });

      final item = find.byType(CollectionListItem).first;

      expect(item, findsOneWidget);

      await tester.tap(item);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionItemDetailPage), findsOneWidget);
    });

    testWidgets('should render a CollectionItemAdd page',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(widgetUnderTest());
        await tester.pumpAndSettle();
      });

      final addButton = find.byKey(const Key('add_item_fab'));

      expect(addButton, findsOneWidget);

      await tester.tap(addButton);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionAddItemPage), findsOneWidget);
    });

    // TODO: Fix this test. It looks like the extra parameter if fighting with mockito
    // testWidgets('should navigate to add item page on small screen',
    //     (WidgetTester tester) async {
    //   final mockGoRouter = MockGoRouter();

    //   tester.view.physicalSize = const Size(300, 200);
    //   tester.view.devicePixelRatio = 1;

    //   addTearDown(tester.view.resetPhysicalSize);

    //   when(() => mockGoRouter.pushNamed('addItem', extra: any(named: 'extra')))
    //       .thenAnswer((invocation) async => null);

    //   await mockNetworkImages(() async {
    //     await tester.pumpWidget(widgetUnderTest(router: mockGoRouter));
    //     await tester.pumpAndSettle();
    //   });

    //   final addButton = find.byKey(const Key('add_item_fab'));

    //   expect(addButton, findsOneWidget);

    //   verifyNever(() => mockGoRouter.pushNamed('addItem'));

    //   await tester.tap(addButton);

    //   await tester.pumpAndSettle();

    //   verify(() => mockGoRouter.pushNamed(any())).called(1);
    // });

    testWidgets(
        'should show item detail when adding an item and selecting a different one',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(widgetUnderTest());
        await tester.pumpAndSettle();
      });

      final addButton = find.byKey(const Key('add_item_fab'));

      expect(addButton, findsOneWidget);

      await tester.tap(addButton);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionAddItemPage), findsOneWidget);

      final item = find.byType(CollectionListItem).first;

      expect(item, findsOneWidget);

      await tester.tap(item);

      await tester.pumpAndSettle();

      expect(find.byType(CollectionItemDetailPage), findsOneWidget);
      expect(find.byType(CollectionAddItemPage), findsNothing);
    });
  });
}
