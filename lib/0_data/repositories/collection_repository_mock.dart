import 'package:either_dart/either.dart';
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
  CollectionRepositoryMock() {
    _itemCollection = {
      for (var element in _itemIds)
        element.value: Item(
          id: element,
          title: 'Title of ${element.value}',
          description: 'A super fancy description of ${element.value}',
          imageUrl:
              'https://cf.geekdo-images.com/x3zxjr-Vw5iU4yDPg70Jgw__imagepagezoom/img/7a0LOL48K-7JNIOSGtcsNsIxkN0=/fit-in/1200x900/filters:no_upscale():strip_icc()/pic3490053.jpg',
        ),
    };
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
}
