import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/i18n/strings.g.dart';

import '../../../../../1_domain/entities/item.dart';
import '../../../../../1_domain/entities/unique_id.dart';
import '../widgets/collection_list_item.dart';
import '../../cubit/collection_cubit.dart';
import '../cubit/collection_list_cubit.dart';

class CollectionListLoaded extends StatefulWidget {
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
  State<CollectionListLoaded> createState() => _CollectionListLoadedState();
}

class _CollectionListLoadedState extends State<CollectionListLoaded> {
  List<Item> filteredItems = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(covariant CollectionListLoaded oldWidget) {
    super.didUpdateWidget(oldWidget);
    _onSearchBarChanged(searchText);
  }

  void _onSearchBarChanged(value) {
    setState(() {
      if (searchText != value) {
        searchText = value;
      }
      filteredItems = widget.items
          .where(
              (item) => item.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    onItemTap(int index) async {
      if (widget.onItemTapped != null) {
        final itemId = filteredItems[index].id;
        widget.onItemTapped!(itemId);
      }
    }

    onAddItemTap() {
      final collectionCubit = context.read<CollectionCubit>();
      collectionCubit.setAddingItem();
    }

    return BlocListener<CollectionCubit, CollectionCubitState>(
      listener: (context, state) {
        if (state is CollectionItemAddedState &&
            state.item != null &&
            !widget.items.contains(state.item)) {
          context.read<CollectionListCubit>().updateCollection(
              List<Item>.from(widget.items)..add(state.item!));
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SearchBar(
                leading: const Icon(Icons.search_outlined),
                onChanged: _onSearchBarChanged,
                hintText: t.collectionSearch,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return CollectionListItem(
                      item: filteredItems[index],
                      selected: widget.selectedItem == filteredItems[index].id,
                      onTap: () => onItemTap(index),
                    );
                  },
                ),
              ),
            ],
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
