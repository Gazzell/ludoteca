import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ludoteca/0_data/data_sources/interfaces/collection_local_source_interface.dart';
import 'package:ludoteca/0_data/exceptions/exceptions.dart';
import 'package:ludoteca/0_data/models/item_instance_model.dart';
import 'package:ludoteca/0_data/models/item_model.dart';

class HiveLocalDataSource implements CollectionLocalSourceInterface {
  late BoxCollection itemsCollection;
  late BoxCollection itemInstancesCollection;

  bool isInitialized = false;

  Future<void> init() async {
    if (isInitialized) {
      debugPrint('Hive already initialized');
      return;
    }

    itemsCollection = await BoxCollection.open(
      'collection',
      {'items', 'itemInstances'},
      path: './',
    );
    isInitialized = true;
  }

  Future<CollectionBox<Map>> _openItemsBox() async {
    return itemsCollection.openBox<Map>('items');
  }

  Future<CollectionBox<Map>> _openItemInstancesBox() async {
    return itemsCollection.openBox<Map>('itemInstances');
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

  @override
  Future<List<ItemInstanceModel>> readItemInstances(
      List<String> itemIds) async {
    final box = await _openItemInstancesBox();
    return Future.wait(itemIds.map((id) async {
      final itemInstance = await  box.get(id);
      if (itemInstance == null) {
        throw ItemInstanceNotFoundException(id);
      }
      return ItemInstanceModel.fromJson(itemInstance.cast<String, dynamic>());
    }).toList());
  }
  
  @override
  Future<bool> addItemInstance({required ItemInstanceModel itemInstanceModel}) {
    // TODO: implement addItemInstance
    throw UnimplementedError();
  }
}
