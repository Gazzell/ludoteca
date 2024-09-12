import 'package:either_dart/either.dart';
import 'package:ludoteca/0_data/data_sources/interfaces/collection_local_source_interface.dart';
import 'package:ludoteca/0_data/exceptions/exceptions.dart';
import 'package:ludoteca/0_data/models/item_model.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';

class CollectionRepositoryLocal implements CollectionRepository {
  final CollectionLocalSourceInterface localDataSource;
  const CollectionRepositoryLocal({required this.localDataSource});

  @override
  Future<Either<Failure, List<ItemId>>> readItemIds() async {
    try {
      final result = await localDataSource.readItemIds();
      return Right(result.map((e) => ItemId.fromUniqueString(e)).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> readItems() async {
    try {
      final ids = await localDataSource.readItemIds();
      if (ids.isEmpty) {
        return const Right([]);
      }
      final items = await localDataSource.readItems(ids);
      return Right(itemModelListToItemList(items));
    } on ItemNotFoundException catch (e) {
      return Left(ItemNotFoundFailure(itemId: e.itemId));
    } on CacheException catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Item>> readItem(ItemId itemId) async {
    try {
      final itemModel = await localDataSource.readItem(itemId: itemId.value);
      return Right(Item.fromItemModel(itemModel));
    } on ItemNotFoundException catch (e) {
      return Left(ItemNotFoundFailure(itemId: e.itemId));
    } on CacheException catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Item>> addItem(Item newItem) async {
    try {
      final result =
          await localDataSource.addItem(itemModel: ItemModel.fromItem(newItem));
      if (!result) {
        return Left(CacheFailure(stackTrace: 'Error adding item'));
      }
      return Right(newItem);
    } on CacheException catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }

  List<Item> itemModelListToItemList(List<ItemModel> itemsModel) =>
      itemsModel.map((itemModel) => Item.fromItemModel(itemModel)).toList();
}
