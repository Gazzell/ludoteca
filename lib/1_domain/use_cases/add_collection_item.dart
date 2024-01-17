import 'package:either_dart/either.dart';

import 'use_case.dart';
import '../failures/failures.dart';
import '../repositories/collection_repository.dart';
import '../entities/item.dart';

class AddCollectionItem implements UseCase<Item, AddItemParams> {
  final CollectionRepository collectionRepository;
  const AddCollectionItem({required this.collectionRepository});

  @override
  Future<Either<Failure, Item>> call(AddItemParams params) async {
    try {
      final itemIds = await collectionRepository.addItem(params.item);
      return itemIds.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
