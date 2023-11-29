import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<ItemId>>> readItemIds();

  Future<Either<Failure, List<Item>>> readItems();

  Future<Either<Failure, FullItem>> readFullItem(ItemId itemId);
}
