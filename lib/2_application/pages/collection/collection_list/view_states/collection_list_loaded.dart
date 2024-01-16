import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/widgets/collection_list_item.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';

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

    return Scaffold(
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
    );
  }
}
