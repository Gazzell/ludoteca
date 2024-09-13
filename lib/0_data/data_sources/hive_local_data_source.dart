import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ludoteca/0_data/data_sources/interfaces/collection_local_source_interface.dart';
import 'package:ludoteca/0_data/exceptions/exceptions.dart';
import 'package:ludoteca/0_data/models/item_model.dart';

class HiveLocalDataSource implements CollectionLocalSourceInterface {
  late BoxCollection itemsCollection;
  bool isInitialized = false;

  Future<void> init() async {
    if (isInitialized) {
      debugPrint('Hive already initialized');
      return;
    }

    itemsCollection = await BoxCollection.open(
      'collection',
      {'items'},
      path: './',
    );
    isInitialized = true;
  }

  Future<CollectionBox<Map>> _openItemsBox() async {
    return itemsCollection.openBox<Map>('items');
  }

  @override
  Future<bool> addItem({required ItemModel itemModel}) async {
    final box = await _openItemsBox();
    await box.put(itemModel.id, itemModel.toJson());
    return true;
  }

  @override
  Future<ItemModel> readItem({required String itemId}) async {
    final box = await _openItemsBox();
    final item = await box.get(itemId);
    if (item == null) {
      throw ItemNotFoundException(itemId);
    }
    return ItemModel.fromJson(item.cast<String, dynamic>());
  }

  @override
  Future<List<String>> readItemIds() async {
    final box = await _openItemsBox();
    return await box.getAllKeys();
  }

  @override
  Future<List<ItemModel>> readItems(List<String> itemIds) {
    return Future.wait(itemIds.map((id) => readItem(itemId: id)).toList());
  }
}
