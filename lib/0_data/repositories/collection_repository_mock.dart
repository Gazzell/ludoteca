import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
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
              status: Random().nextInt(5) % 5 == 0
                  ? ItemStatus.unavailable
                  : ItemStatus.available,
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
  Future<Either<Failure, FullItem>> readFullItem(ItemId itemId) {
    if (!_itemCollection.containsKey(itemId.value)) {
      return Future.value(Left(ItemNotFoundFailure(itemId: itemId.value)));
    }
    final item = _itemCollection[itemId.value]!;
    return Future.value(
      Right(
        FullItem(
          id: ItemId.fromUniqueString(itemId.value),
          imageUrl: item.imageUrl,
          title: item.title,
          status: item.status,
          minAge: item.minAge,
          minPlayers: item.minPlayers,
          maxPlayers: item.maxPlayers,
          playingTime: item.playingTime,
          adquisitionDate: DateTime.now(),
          publisher: 'publisher',
          author: 'author',
          longDescription:
              "Brass: Birmingham is an economic strategy game sequel to Martin Wallace' 2007 masterpiece, Brass. Brass: Birmingham tells the story of competing entrepreneurs in Birmingham during the industrial revolution, between the years of 1770-1870.&#10;&#10;It offers a very different story arc and experience from its predecessor. As in its predecessor, you must develop, build, and establish your industries and network, in an effort to exploit low or high market demands. The game is played over two halves: the canal era (years 1770-1830) and the rail era (years 1830-1870). To win the game, score the most VPs. VPs are counted at the end of each half for the canals, rails and established (flipped) industry tiles.&#10;&#10;Each round, players take turns according to the turn order track, receiving two actions to perform any of the following actions (found in the original game):&#10;&#10;1) Build - Pay required resources and place an industry tile.&#10;2) Network - Add a rail / canal link, expanding your network.&#10;3) Develop - Increase the VP value of an industry.&#10;4) Sell - Sell your cotton, manufactured goods and pottery.&#10;5) Loan - Take a &pound;30 loan and reduce your income.&#10;&#10;Brass: Birmingham also features a new sixth action:&#10;&#10;6) Scout - Discard three cards and take a wild location and wild industry card. (This action replaces Double Action Build in original Brass.)&#10;&#10;",
        ),
      ),
    );
  }
}
