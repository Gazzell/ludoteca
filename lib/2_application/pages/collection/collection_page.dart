import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/2_application/core/page_config.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';

class CollectionPageProvider extends StatelessWidget {
  const CollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionCubit(),
      child: const CollectionPage(),
    );
  }
}

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.menu_book_outlined,
    name: 'collection',
    child: CollectionPageProvider(),
  );

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
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
              builder: (context) {
                return BlocBuilder<CollectionCubit, CollectionCubitState>(
                  builder: (context, state) {
                    if (state is CollectionItemAddingState) {
                      return const CollectionAddItemPage();
                    }

                    final selectedItem = (state is CollectionItemSelectedState)
                        ? state.selectedItem
                        : null;
                    return CollectionItemDetailPageProvider(
                      key: Key('detail-${selectedItem?.value}'),
                      selectedItem: selectedItem,
                    );
                  },
                );
              })
        },
      ),
    );
  }
}
