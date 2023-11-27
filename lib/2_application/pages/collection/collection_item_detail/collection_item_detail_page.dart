import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

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

class CollectionItemDetailPage extends StatelessWidget {
  final ItemId? selectedItem;
  const CollectionItemDetailPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Text(selectedItem?.value ?? '');
  }
}
