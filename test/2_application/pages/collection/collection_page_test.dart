import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_mock.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_page.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockCollectionCubit extends MockCubit<CollectionCubitState>
    implements CollectionCubit {}

class MockBggDataSource extends Mock implements BggDataSource {}

void main() {
  Widget widgetUnderTest({required CollectionCubit cubit}) {
    return MaterialApp(
      home: Material(
        child: RepositoryProvider<CollectionRepository>(
          create: (context) =>
              CollectionRepositoryMock(bggDataSource: BggDataSource()),
          child: BlocProvider(
            create: (context) => cubit,
            child: const CollectionPage(),
          ),
        ),
      ),
    );
  }

  group('CollectionPage', () {
    late MockCollectionCubit mockCollectionCubit;

    setUp(() => mockCollectionCubit = MockCollectionCubit());

    testWidgets('should render a CollectionListPage',
        (WidgetTester tester) async {
      whenListen(
        mockCollectionCubit,
        Stream.fromIterable(
            [const CollectionItemSelectedState(selectedItem: null)]),
        initialState: const CollectionItemSelectedState(selectedItem: null),
      );
      await tester.pumpWidget(widgetUnderTest(cubit: mockCollectionCubit));

      expect(find.byType(CollectionListPage), findsOneWidget);
    });

    testWidgets('should render a CollectionItemDetail page',
        (WidgetTester tester) async {
      whenListen(
        mockCollectionCubit,
        Stream.fromIterable([
          CollectionItemSelectedState(
            selectedItem: ItemId.fromUniqueString('1'),
          )
        ]),
        initialState: const CollectionItemSelectedState(selectedItem: null),
      );

      await tester.pumpWidget(widgetUnderTest(cubit: mockCollectionCubit));

      expect(find.byType(CollectionItemDetailPage), findsOneWidget);
    });

    testWidgets('should render a CollectionItemAdd page',
        (WidgetTester tester) async {
      whenListen(
        mockCollectionCubit,
        Stream.fromIterable([const CollectionItemAddingState()]),
        initialState: const CollectionItemAddingState(),
      );

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          widgetUnderTest(cubit: mockCollectionCubit),
        );
        await tester.pumpAndSettle();
      });

      expect(find.byType(CollectionAddItemPage), findsOneWidget);
    });
  });
}
