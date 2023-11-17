import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_items.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/cubit/collection_list_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/view_states/collection_list_loading.dart';

class CollectionListPageProvider extends StatelessWidget {
  const CollectionListPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionListCubit(
        getCollectionItems: GetCollectionItems(
          collectionRepository:
              RepositoryProvider.of<CollectionRepository>(context),
        ),
      )..readItems(),
      child: const CollectionListPage(),
    );
  }
}

class CollectionListPage extends StatelessWidget {
  const CollectionListPage({super.key});

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
            return CollectionListLoaded(items: state.items);
          }
          return const CollectionListError();
        },
      ),
    );
  }
}
