import 'package:either_dart/either.dart';
import 'package:ludoteca/0_data/data_sources/bgg_data_source.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';

class BggRepository {
  final BggDataSource _bggDataSource;

  BggRepository({required BggDataSource bggDataSource})
      : _bggDataSource = bggDataSource;

  Future<Either<Failure, Item>> getItem(String itemId) async {
    try {
      final itemModel = await _bggDataSource.getItem(id: itemId);
      Item item = modelToItem(itemModel);
      return Future.value(Right(item));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  Item modelToItem(ItemModel itemModel) {
    return Item(
      id: ItemId.fromUniqueString(itemModel.id),
      title: itemModel.title,
      description: itemModel.description,
      instances: const [],
      imageUrl: itemModel.imageUrl,
      minAge: itemModel.minAge,
      minPlayers: itemModel.minPlayers,
      maxPlayers: itemModel.maxPlayers,
      playingTime: itemModel.playingTime,
    );
  }
}
