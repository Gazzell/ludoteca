import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

class GetItem implements UseCase<Item, ItemParams> {
  final CollectionRepository collectionRepository;

  const GetItem({required this.collectionRepository});

  @override
  Future<Either<Failure, Item>> call(ItemParams params) async {
    try {
      final item = await collectionRepository.readItem(params.itemId);
      return item.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
