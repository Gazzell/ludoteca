import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_item_ids.dart';
import 'package:ludoteca/2_application/pages/collection/collection_list/cubit/collection_list_cubit.dart';

class CollectionListPageProvider extends StatelessWidget {
  const CollectionListPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionListCubit(
        getCollectionItemIds: GetCollectionItemIds(
          collectionRepository: RepositoryProvider.of<CollectionRepository>(context),
        ),
      )..readItemIds(),
      child: const CollectionListPage(),
    );
  }
}

class CollectionListPage extends StatelessWidget {
  const CollectionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.secondaryContainer,
      child: const Center(
          child: Column(
        children: [
          Expanded(child: Text('Collection')),
        ],
      )),
    );
  }
}
