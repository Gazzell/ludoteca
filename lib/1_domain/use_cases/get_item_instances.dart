import 'package:either_dart/either.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/repositories/collection_repository.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

class GetItemInstances
    implements UseCase<List<ItemInstance>, GetItemInstancesParams> {
  final CollectionRepository collectionRepository;
  const GetItemInstances({required this.collectionRepository});

  @override
  Future<Either<Failure, List<ItemInstance>>> call(
      GetItemInstancesParams params) async {
    try {
      final itemInstances =
          await collectionRepository.readItemInstances(params.itemInstanceIds);
      return itemInstances.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
