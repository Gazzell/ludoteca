import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

class GetFullItem implements UseCase<FullItem, ItemParams> {
  final CollectionRepository collectionRepository;

  const GetFullItem({required this.collectionRepository});

  @override
  Future<Either<Failure, FullItem>> call(ItemParams params) async {
    try {
      final item = await collectionRepository.readFullItem(params.itemId);
      return item.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
