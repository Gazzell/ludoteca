import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';

import 'use_case.dart';
import '../failures/failures.dart';
import '../repositories/collection_repository.dart';

class AddItemInstance implements UseCase<ItemInstance, AddItemInstanceParams> {
  final CollectionRepository collectionRepository;
  const AddItemInstance({required this.collectionRepository});

  @override
  Future<Either<Failure, ItemInstance>> call(
      AddItemInstanceParams params) async {
    try {
      final itemInstance =
          await collectionRepository.addItemInstance(params.itemInstance);
      return itemInstance.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
