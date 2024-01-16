import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_items.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/cubit/collection_list_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loading.dart';

import '../../../../1_domain/entities/unique_id.dart';

class CollectionListPageProvider extends StatelessWidget {
  final Function(ItemId)? onItemTapped;
  final ItemId? selectedItem;
  const CollectionListPageProvider({
    super.key,
    this.onItemTapped,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionListCubit(
        getCollectionItems: GetCollectionItems(
          collectionRepository:
              RepositoryProvider.of<CollectionRepository>(context),
        ),
      )..readItems(),
      child: CollectionListPage(
        onItemTapped: onItemTapped,
        selectedItem: selectedItem,
      ),
    );
  }
}

class CollectionListPage extends StatelessWidget {
  final Function(ItemId)? onItemTapped;
  final ItemId? selectedItem;
  const CollectionListPage({
    super.key,
    required this.onItemTapped,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: BlocBuilder<CollectionListCubit, CollectionListCubitState>(
        builder: (context, state) {
          if (state is CollectionListLoadingState) {
            return const CollectionListLoading();
          }
          if (state is CollectionListItemsLoadedState) {
            return CollectionListLoaded(
              items: state.items,
              onItemTapped: onItemTapped,
              selectedItem: selectedItem,
            );
          }
          return const CollectionListError();
        },
      ),
    );
  }
}
