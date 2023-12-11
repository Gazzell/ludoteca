import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/cubit/collection_item_detail_cubit.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_empty.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_error.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loaded.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/view_states/collection_item_detail_loading.dart';

class CollectionItemDetailSmallPage extends StatelessWidget {
  final ItemId? selectedItem;
  const CollectionItemDetailSmallPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(selectedItem?.value ?? ''),
      ),
      body: CollectionItemDetailPageProvider(selectedItem: selectedItem),
    );
  }
}

class CollectionItemDetailPageProvider extends StatelessWidget {
  final ItemId? selectedItem;
  const CollectionItemDetailPageProvider(
      {super.key, required this.selectedItem, req});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CollectionItemDetailCubit(
          getItemDetail: GetFullItem(
            collectionRepository:
                RepositoryProvider.of<CollectionRepository>(context),
          ),
        )..readItemDetail(selectedItem);
      },
      child: const CollectionItemDetailPage(),
    );
  }
}

class CollectionItemDetailPage extends StatelessWidget {
  const CollectionItemDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionItemDetailCubit,
        CollectionItemDetailCubitState>(
      builder: (context, state) {
        if (state is CollectionItemDetailLoadingState) {
          return const CollectionItemDetailLoading();
        }
        if (state is CollectionItemDetailLoadedState) {
          return CollectionItemDetailLoaded(
            itemDetail: state.itemDetail,
          );
        }
        if (state is CollectionItemDetailEmptyState) {
          return const CollectionItemDetailEmpty();
        }
        return const CollectionItemDetailError();
      },
    );
  }
}
