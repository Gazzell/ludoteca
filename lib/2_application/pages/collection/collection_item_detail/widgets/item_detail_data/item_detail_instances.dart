import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_instances_row.dart';

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
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: 600, maxHeight: 600, minWidth: 300),
        child: Column(
          children: [
            Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 50),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AutoSizeText(
                        itemTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                  return ItemDetailInstancesRow(
                    index: index,
                    itemInstance: instances[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
