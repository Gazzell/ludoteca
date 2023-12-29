import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/widgets/collection_list_item.dart';
import 'package:ludoteca/2_application/pages/collection/widgets/item_play_properties.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

abstract class OnTapCallback {
  void call();
}

class MockOnTapCallback extends Mock implements OnTapCallback {}

void main() {
  group('CollectionListItem', () {
    Widget widgetUnderTest(
        {required Item item, Function()? onTap, bool selected = false}) {
      return MaterialApp(
        home: Material(
          child: CollectionListItem(
            item: item,
            onTap: onTap,
            selected: selected,
          ),
        ),
      );
    }

    testWidgets('should render all data', (WidgetTester tester) async {
      final item = Item(
        id: ItemId.fromUniqueString('0'),
        title: 'a title',
        instances: const[],
        imageUrl:
            'https://cf.geekdo-images.com/x3zxjr-Vw5iU4yDPg70Jgw__imagepagezoom/img/7a0LOL48K-7JNIOSGtcsNsIxkN0=/fit-in/1200x900/filters:no_upscale():strip_icc()/pic3490053.jpg',
      );

      await mockNetworkImages(
        () async => tester.pumpWidget(widgetUnderTest(item: item)),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('a title'), findsOneWidget);
      expect(find.byType(ItemPlayProperties), findsOneWidget);
    });

    testWidgets('should emit onTap', (WidgetTester tester) async {
      final item = Item(
        id: ItemId.fromUniqueString('0'),
        title: 'a title',
        instances: const[],
        imageUrl: '',
      );

      final mockOnTap = MockOnTapCallback();

      await mockNetworkImages(
        () async => tester.pumpWidget(widgetUnderTest(
          item: item,
          onTap: mockOnTap.call,
        )),
      );

      verifyNever(() => mockOnTap());

      await tester.tap(find.byType(InkWell));

      verify(() => mockOnTap()).called(1);
    });
  });
}
