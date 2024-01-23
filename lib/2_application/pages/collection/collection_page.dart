import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/2_application/core/page_config.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/collection_list_page.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';

import '../../../1_domain/entities/item.dart';
import '../../../1_domain/entities/unique_id.dart';

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
  ItemId? selectedItem;

  changeSelection({ItemId? selectedItem}) {
    setState(() {
      this.selectedItem = selectedItem;
    });
  }

  onSelectionChanged(BuildContext context, ItemId? itemId) async {
    if (itemId != null) {
      if (Breakpoints.small.isActive(context)) {
        await context.pushNamed('itemDetail', pathParameters: {
          'itemId': itemId.value,
        });
        changeSelection();
      } else {
        changeSelection(selectedItem: itemId);
        context.read<CollectionCubit>().setShowingState();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectionCubit, CollectionCubitState>(
      listener: (context, state) async {
        final collectionCubit = context.read<CollectionCubit>();
        if (state is CollectionItemAddingState) {
          late Item? item;
          if (Breakpoints.small.isActive(context)) {
            item = await context.pushNamed('addItem');
            if (item != null) {
              collectionCubit.itemAdded(item);
            }
          }
          return;
        }
        if (state is CollectionItemAddedState &&
            Breakpoints.mediumAndUp.isActive(context)) {
          onSelectionChanged(context, state.item.id);
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('body-small-and-up'),
                builder: (context) => CollectionListPageProvider(
                  onItemTapped: (itemId) => onSelectionChanged(context, itemId),
                  selectedItem: selectedItem,
                ),
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
                          return const CollectionAddItemPageProvider();
                        }

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
      },
    );
  }
}
