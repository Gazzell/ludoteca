import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data.dart';

class CollectionAddItemLoaded extends StatelessWidget {
  final FullItem itemDetail;
  const CollectionAddItemLoaded({super.key, required this.itemDetail});

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
            child: Image.network(itemDetail.imageUrl),
          ),
        ),
        ItemDetailData(itemDetail: itemDetail)
      ],
    );
  }
}
