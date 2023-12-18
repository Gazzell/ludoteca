import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data.dart';

class CollectionItemDetailLoaded extends StatelessWidget {
  final FullItem itemDetail;
  const CollectionItemDetailLoaded({super.key, required this.itemDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        color: Colors.black54,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 3,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(itemDetail.imageUrl),
                ),
              ),
              ItemDetailData(itemDetail: itemDetail)
            ],
          ),
        ),
      ),
    );
  }
}
