import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_instance_row_list_item.dart';

class ItemDetailInstances extends StatelessWidget {
  final List<ItemInstance> instances;
  final String itemTitle;
  const ItemDetailInstances({
    super.key,
    required this.instances,
    required this.itemTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      itemTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: instances.length,
              itemBuilder: (context, index) {
                return ItemDetailListInstanceListItem(
                  itemInstance: instances[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
