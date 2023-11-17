import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

class GetCollectionItems implements UseCase<List<Item>, NoParams> {
  final CollectionRepository collectionRepository;
  GetCollectionItems({required this.collectionRepository});

  @override
  Future<Either<Failure, List<Item>>> call(NoParams params) async {
    try {
      final items = await collectionRepository.readItems();
      return items.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
