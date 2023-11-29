import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/get_full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/cubit/collection_item_detail_cubit.dart';

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
      body: CollectionItemDetailPage(selectedItem: selectedItem),
    );
  }
}

class CollectionItemDetailPageProvider extends StatelessWidget {
  final ItemId? itemId;
  const CollectionItemDetailPageProvider(
      {super.key, required this.itemId, req});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CollectionItemDetailCubit(
          getItemDetail: GetFullItem(
            collectionRepository:
                RepositoryProvider.of<CollectionRepository>(context),
          ),
        );
        if (itemId != null) {
          cubit.readItemDetail(itemId!);
        }
        return cubit;
      },
      child: CollectionItemDetailPage(selectedItem: itemId),
    );
  }
}

class CollectionItemDetailPage extends StatelessWidget {
  final ItemId? selectedItem;
  const CollectionItemDetailPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Text(selectedItem?.value ?? '');
  }
}
