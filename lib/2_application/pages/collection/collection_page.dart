import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/0_data/repositories/collection_repository_mock.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/2_application/core/page_config.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.menu_book_outlined,
    name: 'collection',
    child: CollectionPage(),
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CollectionRepository>(
      create: (context) => CollectionRepositoryMock(),
      child: AdaptiveLayout(
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('body-small-and-up'),
              builder: (context) => const CollectionListPageProvider(),
            )
          },
        ),
        secondaryBody: SlotLayout(
          config: {
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('collection-secondary-body-medium-and-up'),
              builder: (context) => const CollectionItemDetail(),
            )
          },
        ),
      ),
    );
  }
}
