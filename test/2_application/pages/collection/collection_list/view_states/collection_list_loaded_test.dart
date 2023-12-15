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

class MockCollectionCubit extends MockCubit<CollectionCubitState>
    implements CollectionCubit {}

void main() {
  Widget widgetUnderTest({
    required List<Item> items,
    required CollectionCubit cubit,
  }) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => cubit,
        child: Material(
          child: CollectionListLoaded(
            items: items,
          ),
        ),
      ),
    );
  }

  group(
    'CollectionListLoaded view state',
    () {
      late MockCollectionCubit mockCollectionCubit;
      setUp(() => mockCollectionCubit = MockCollectionCubit());

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
                    description: '',
                  ),
                  growable: false,
                ),
                cubit: mockCollectionCubit,
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
    },
  );
}
