import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/0_data/repositories/bgg_repository.dart';
import 'package:ludoteca/1_domain/use_cases/add_item_instance.dart';
import 'package:ludoteca/1_domain/use_cases/get_bgg_item.dart';
import 'package:ludoteca/i18n/strings.g.dart';
import '../../../../1_domain/entities/item.dart';
import '../../../../1_domain/repositories/collection_repository.dart';
import '../../../../1_domain/use_cases/add_collection_item.dart';
import '../collection_page.dart';
import 'cubit/collection_add_item_cubit.dart';
import 'view_states/collection_add_item_empty.dart';
import 'view_states/collection_add_item_error.dart';
import 'view_states/collection_add_item_loaded.dart';
import 'view_states/collection_add_item_loading.dart';

class CollectionAddItemPageProvider extends StatelessWidget {
  final bool showAppBar;
  final String? title;
  final Function(Item?) onItemAdded;
  const CollectionAddItemPageProvider({
    super.key,
    this.showAppBar = false,
    this.title,
    required this.onItemAdded,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final collectionRepository =
            RepositoryProvider.of<CollectionRepository>(context);
        final bggRepository = RepositoryProvider.of<BggRepository>(context);
        return CollectionAddItemCubit(
          getBggItem: GetBggItem(bggRepository: bggRepository),
          addItem: AddCollectionItem(
            collectionRepository: collectionRepository,
          ),
          addItemInstance: AddItemInstance(
            collectionRepository: collectionRepository,
          ),
        );
      },
      child: CollectionAddItemPage(
        title: title,
        showAppBar: showAppBar,
        onItemAdded: onItemAdded,
      ),
    );
  }
}

class CollectionAddItemPage extends StatelessWidget {
  final bool showAppBar;
  final String? title;
  final Function(Item?) onItemAdded;

  const CollectionAddItemPage({
    super.key,
    this.showAppBar = false,
    this.title,
    required this.onItemAdded,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocBuilder<CollectionAddItemCubit, CollectionAddItemCubitState>(
      builder: (context, state) {
        closePage({Item? item}) {
          onItemAdded(item);
          if (Breakpoints.small.isActive(context)) {
            if (context.canPop()) {
              context.pop(item);
              return;
            }
            context.goNamed(
              'shell',
              pathParameters: {'tab': CollectionPage.pageConfig.name},
            );
          }
        }

        return BlocListener<CollectionAddItemCubit,
            CollectionAddItemCubitState>(
          listener: (context, state) {
            if (state is CollectionAddItemAddedState) {
              closePage(item: state.item);
            }
          },
          child: PopScope(
            canPop: true,
            onPopInvokedWithResult: (_, result) => onItemAdded(null),
            child: Scaffold(
              appBar: showAppBar
                  ? AppBar(
                      title: Text(title ?? ''),
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: closePage,
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
                            hintText: t.collectionAddItemSearchBgg,
                            onSubmitted: (value) {
                              context
                                  .read<CollectionAddItemCubit>()
                                  .readItemDetail(value);
                            },
                          ),
                        ),
                        body,
                      ],
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.done_outline_outlined),
                onPressed: () {
                  if (state is CollectionAddItemLoadedState) {
                    context
                        .read<CollectionAddItemCubit>()
                        .addCollectionItem(state.item);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
