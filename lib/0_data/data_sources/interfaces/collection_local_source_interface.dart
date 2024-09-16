import 'package:ludoteca/0_data/models/item_instance_model.dart';
import 'package:ludoteca/0_data/models/item_model.dart';

abstract class CollectionLocalSourceInterface {
  Future<List<String>> readItemIds();

  Future<List<ItemModel>> readItems(List<String> itemIds);

  Future<ItemModel> readItem({required String itemId});

  Future<bool> addItem({required ItemModel itemModel});

  Future<List<ItemInstanceModel>> readItemInstances(List<String> itemIds);

  Future<bool> addItemInstance({required ItemInstanceModel itemInstanceModel});
}
