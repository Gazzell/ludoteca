import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data.dart';

class CollectionAddItemLoaded extends StatelessWidget {
  final Item item;
  const CollectionAddItemLoaded({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: height * 0.33,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: item.imageUrl != null
                ? Image.network(item.imageUrl!)
                : const Placeholder(),
          ),
        ),
        ItemDetailData(item: item)
      ],
    );
  }
}
