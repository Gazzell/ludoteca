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

abstract class CallbackFunction {
  void call(ItemId id);
}

class OnItemTappedMock extends Mock implements CallbackFunction {}

void main() {
  Widget widgetUnderTest({
    required List<Item> items,
    Function(ItemId)? onItemTapped,
    ItemId? selectedItem,
  }) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CollectionCubit(),
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
  });
}
