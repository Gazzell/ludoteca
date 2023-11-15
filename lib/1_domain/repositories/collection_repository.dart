import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<ItemId>>> readItemIds();
}
