import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:ludoteca/0_data/exceptions/exceptions.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';

class CollectionRepositoryMock implements CollectionRepository {
  final List<ItemId> _itemIds = List<ItemId>.generate(
    20,
    (index) => ItemId.fromUniqueString('item-$index'),
  );

  late Map<String, Item> _itemCollection;

  final ages = [0, 5, 8, 10, 12, 14, 18];

  final times = [5, 15, 30, 45, 60, 120, 180];

  late Map<String, ItemInstance> _itemInstances;

  CollectionRepositoryMock() {
    _itemCollection = Map.fromEntries(
      _itemIds.map(
        (item) {
          final minPlayers = Random().nextInt(2) + 1;
          final maxPlayers = Random().nextInt(4) + minPlayers;
          return MapEntry(
            item.value,
            Item(
              id: item,
              title:
                  'Title of ${item.value} ${Random().nextInt(4) % 4 == 0 ? 'with a very long title and far more long, even too long' : ''}',
              instances: List<ItemInstanceId>.empty(growable: true),
              imageUrl:
                  'https://cf.geekdo-images.com/x3zxjr-Vw5iU4yDPg70Jgw__imagepagezoom/img/7a0LOL48K-7JNIOSGtcsNsIxkN0=/fit-in/1200x900/filters:no_upscale():strip_icc()/pic3490053.jpg',
              minAge: ages[Random().nextInt(ages.length)],
              minPlayers: minPlayers,
              maxPlayers: maxPlayers,
              playingTime: times[Random().nextInt(times.length)],
            ),
          );
        },
      ),
    );

    _itemInstances = [
      for (var item in _itemCollection.values)
        ...List<ItemInstance>.generate(
          Random().nextInt(5),
          (index) {
            final status = ItemInstanceStatus
                .values[Random().nextInt(ItemInstanceStatus.values.length)];
            final newInstance = ItemInstance(
              id: ItemInstanceId.fromUniqueString(
                  '${item.id.value}-instance-$index'),
              itemId: item.id,
              status: status,
              borrowedAt: status == ItemInstanceStatus.available
                  ? null
                  : DateTime.now()
                      .subtract(Duration(days: Random().nextInt(15))),
              returnedAt: status == ItemInstanceStatus.unavailable
                  ? null
                  : DateTime.now()
                      .subtract(Duration(days: Random().nextInt(15))),
              borrowedBy: status == ItemInstanceStatus.available
                  ? null
                  : UniqueId.fromUniqueString('borrower-$index'),
            );
            item.instances.add(newInstance.id);
            return newInstance;
          },
        ),
    ].fold<Map<String, ItemInstance>>(
      {},
      (map, instances) => map..addAll({instances.id.value: instances}),
    );
  }

  @override
  Future<Either<Failure, List<ItemId>>> readItemIds() {
    return Future.value(
      Right(_itemIds),
    );
  }

  @override
  Future<Either<Failure, List<Item>>> readItems() {
    return Future.value(Right(_itemCollection.values.toList()));
  }

  @override
  Future<Either<Failure, Item>> readItem(ItemId itemId) async {
    Item? item = _itemCollection[itemId.value];
    if (item == null) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
    return Future.value(Right(item));
  }

  @override
  Future<Either<Failure, List<ItemInstance>>> readItemInstances(
      List<ItemInstanceId> itemInstanceIds) {
    try {
      final itemInstances = itemInstanceIds.map((id) {
        if (!_itemInstances.containsKey(id.value)) {
          throw ItemInstanceNotFoundException(id.value);
        }
        return _itemInstances[id.value]!;
      }).toList();
      return Future.value(Right(itemInstances));
    } on ItemInstanceNotFoundException catch (e) {
      return Future.value(Left(
        ItemInstanceNotFoundFailure(itemInstanceId: e.instanceId),
      ));
    }
  }

  @override
  Future<Either<Failure, Item>> addItem(Item item) {
    _itemIds.add(item.id);
    _itemCollection[item.id.value] = item;
    return Future.value(Right(item));
  }

  @override
  Future<Either<Failure, ItemInstance>> addItemInstance(
      ItemInstance itemInstance) {
    if (!_itemCollection.containsKey(itemInstance.itemId.value)) {
      return Future.value(
          Left(ItemNotFoundFailure(itemId: itemInstance.itemId.value)));
    }

    _itemCollection[itemInstance.itemId.value]!.instances.add(itemInstance.id);
    _itemInstances[itemInstance.id.value] = itemInstance;
    return Future.value(Right(itemInstance));
  }
}
