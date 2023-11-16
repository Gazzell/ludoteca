import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

class GetCollectionItemIds implements UseCase<List<ItemId>, NoParams> {
  final CollectionRepository collectionRepository;
  const GetCollectionItemIds({required this.collectionRepository});

  @override
  Future<Either<Failure, List<ItemId>>> call(NoParams params) async {
    try {
      final itemIds = await collectionRepository.readItemIds();
      return itemIds.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
