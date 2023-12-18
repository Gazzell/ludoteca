import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data_header.dart';

class ItemDetailData extends StatelessWidget {
  const ItemDetailData({
    super.key,
    required this.itemDetail,
  });

  final FullItem itemDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ItemDetailDataHeader(title: itemDetail.title),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(itemDetail.longDescription ?? 'itemDetail.description'),
          )
        ],
      ),
    );
  }
}
