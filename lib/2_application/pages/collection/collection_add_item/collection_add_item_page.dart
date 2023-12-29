import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/cubit/collection_add_item_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_empty.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/view_states/collection_add_item_loading.dart';

class CollectionAddItemPageProvider extends StatelessWidget {
  final bool showAppBar;
  final String? title;
  const CollectionAddItemPageProvider(
      {super.key, this.showAppBar = false, this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CollectionAddItemCubit(
          getItem: GetItem(
            collectionRepository:
                RepositoryProvider.of<CollectionRepository>(context),
          ),
        );
      },
      child: CollectionAddItemPage(title: title),
    );
  }
}

class CollectionAddItemPage extends StatelessWidget {
  final bool showAppBar;
  final String? title;

  const CollectionAddItemPage({super.key, this.showAppBar = false, this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionAddItemCubit, CollectionAddItemCubitState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black54,
          appBar: showAppBar
              ? AppBar(
                  title: Text(title ?? ''),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                )
              : null,
          body: Builder(
            builder: (context) {
              Widget body;
              if (state is CollectionAddItemLoadingState) {
                body = const CollectionAddItemLoading();
              } else if (state is CollectionAddItemErrorState) {
                body = const CollectionAddItemError();
              } else if (state is CollectionAddItemLoadedState) {
                body = CollectionAddItemLoaded(
                  key: Key(state.item.id.value),
                  item: state.item,
                );
              } else {
                body = const CollectionAddItemEmpty();
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchBar(
                        leading: const Icon(Icons.search_outlined),
                        hintText: 'BGG id',
                        onSubmitted: (value) {
                          context
                              .read<CollectionAddItemCubit>()
                              .readItemDetail(ItemId.fromUniqueString(value));
                        },
                      ),
                    ),
                    body,
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
