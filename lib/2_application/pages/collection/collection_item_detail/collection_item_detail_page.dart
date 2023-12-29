import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/cubit/collection_item_detail_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_empty.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loading.dart';

class CollectionItemDetailPageProvider extends StatelessWidget {
  final ItemId? selectedItem;
  final bool showAppBar;
  const CollectionItemDetailPageProvider({
    super.key,
    required this.selectedItem,
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CollectionItemDetailCubit(
          getItem: GetItem(
            collectionRepository:
                RepositoryProvider.of<CollectionRepository>(context),
          ),
        )..readItemDetail(selectedItem);
      },
      child: CollectionItemDetailPage(
        showAppBar: showAppBar,
        title: selectedItem?.value,
      ),
    );
  }
}

class CollectionItemDetailPage extends StatelessWidget {
  final bool showAppBar;
  final String? title;
  const CollectionItemDetailPage({
    super.key,
    this.showAppBar = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionItemDetailCubit,
        CollectionItemDetailCubitState>(builder: (context, state) {
      return Scaffold(
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
            if (state is CollectionItemDetailLoadingState) {
              return const CollectionItemDetailLoading();
            }
            if (state is CollectionItemDetailLoadedState) {
              return CollectionItemDetailLoaded(item: state.item);
            }
            if (state is CollectionItemDetailEmptyState) {
              return const CollectionItemDetailEmpty();
            }
            return const CollectionItemDetailError();
          },
        ),
      );
    });
  }
}
