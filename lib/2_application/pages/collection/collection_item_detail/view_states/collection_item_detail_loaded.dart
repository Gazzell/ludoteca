import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data.dart';

class CollectionItemDetailLoaded extends StatelessWidget {
  final Item item;
  final List<ItemInstance> itemInstances;
  const CollectionItemDetailLoaded({
    super.key,
    required this.item,
    required this.itemInstances,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        color: Colors.black54,
        child: Column(
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
            ItemDetailData(item: item, itemInstances: itemInstances),
          ],
        ),
      ),
    );
  }
}
