import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_mock.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_page.dart';

void main() {
  Widget widgetUnderTest() {
    return MaterialApp(
      home: Material(
        child: RepositoryProvider<CollectionRepository>(
          create: (context) => CollectionRepositoryMock(),
          child: const CollectionPageProvider(),
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
      await tester.pumpWidget(
        widgetUnderTest(),
      );
      expect(find.byType(CollectionItemDetailPage), findsOneWidget);
    });
  });
}
