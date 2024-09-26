import 'dart:math';

import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:ludoteca/0_data/models/item_instance_model.dart';
import 'package:ludoteca/0_data/models/item_model.dart';

final bggIds = [
  255984,
  224517,
  161936,
  174430,
  342942,
  233078,
  316554,
  115746,
];

Future<List<ItemModel>> generateItems() async {
  final bgg = BggDataSource();
  final itemModels = List<ItemModel>.empty(growable: true);

  for (int id in bggIds) {
    final item = await bgg.getItem(id: id.toString());
    itemModels.add(item);
  }
  return itemModels;
}

generateInstancesForItem(String itemId) {
  return List.generate(Random().nextInt(10) + 1, (index) {
    final status = Random().nextBool() ? 'available' : 'unavailable';
    return ItemInstanceModel(
      id: '$itemId-$index',
      itemId: itemId,
      status: status,
      borrowedAt: status == 'available' ? null : DateTime.now(),
      borrowedBy: Random().nextInt(10).toString(),
      incidences: List.generate(
        Random().nextInt(5),
        (index) => 'Incidence $index',
      ),
    );
  });
}
