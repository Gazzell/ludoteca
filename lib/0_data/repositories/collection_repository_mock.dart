import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';

class CollectionRepositoryMock implements CollectionRepository {
  final List<ItemId> _itemIds = List<ItemId>.generate(
    20,
    (index) => ItemId.fromUniqueString('item-$index'),
  );

  @override
  Future<Either<Failure, List<ItemId>>> readItemIds() {
    return Future.value(
      Right(_itemIds),
    );
  }
}
