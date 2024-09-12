import 'package:ludoteca/0_data/models/item_model.dart';

abstract class CollectionLocalSourceInterface {
  Future<List<String>> readItemIds();

  Future<List<ItemModel>> readItems(List<String> itemIds);

  Future<ItemModel> readItem({required String itemId});

  Future<bool> addItem({required ItemModel item});
  
  Future<bool> createItem({required ItemModel item});
}
