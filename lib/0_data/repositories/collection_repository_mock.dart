import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
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
              instances: const [],
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
  Future<Either<Failure, Item>> addItem(Item item) {
    _itemIds.add(item.id);
    _itemCollection[item.id.value] = item;
    return Future.value(Right(item));
  }

  Item modelToItem({required ItemModel itemModel}) {
    return Item(
      id: itemModel.id != null ? ItemId.fromUniqueString(itemModel.id!) : ItemId(),
      bggId: itemModel.bggId,
      title: itemModel.title,
      instances: const [],
      description: itemModel.description,
      imageUrl: itemModel.imageUrl,
      minAge: itemModel.minAge,
      minPlayers: itemModel.minPlayers,
      maxPlayers: itemModel.maxPlayers,
      playingTime: itemModel.playingTime,
    );
  }
}
