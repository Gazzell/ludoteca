import 'package:either_dart/either.dart';
import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';

class BggRepository {
  final BggDataSource _bggDataSource;

  BggRepository({required BggDataSource bggDataSource})
      : _bggDataSource = bggDataSource;

  Future<Either<Failure, Item>> getItem(String itemId) async {
    try {
      final itemModel = await _bggDataSource.getItem(id: itemId);
      Item item = Item.fromItemModel(itemModel);
      return Future.value(Right(item));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
