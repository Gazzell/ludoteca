import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../1_domain/entities/item.dart';
import '../../../../../1_domain/entities/unique_id.dart';
import '../widgets/collection_list_item.dart';
import '../../cubit/collection_cubit.dart';
import '../cubit/collection_list_cubit.dart';

class CollectionListLoaded extends StatelessWidget {
  final List<Item> items;
  final Function(ItemId)? onItemTapped;
  final ItemId? selectedItem;

  const CollectionListLoaded({
    super.key,
    required this.items,
    this.onItemTapped,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    onItemTap(int index) async {
      if (onItemTapped != null) {
        final itemId = items[index].id;
        onItemTapped!(itemId);
      }
    }

    onAddItemTap() {
      final collectionCubit = context.read<CollectionCubit>();
      collectionCubit.setAddingItem();
    }

    return BlocListener<CollectionCubit, CollectionCubitState>(
      listener: (context, state) {
        if (state is CollectionItemAddedState && !items.contains(state.item)) {
          context
              .read<CollectionListCubit>()
              .updateCollection(List<Item>.from(items)..add(state.item));
        }
      },
      child: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return CollectionListItem(
                item: items[index],
                selected: selectedItem == items[index].id,
                onTap: () => onItemTap(index),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('add_item_fab'),
          onPressed: onAddItemTap,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
