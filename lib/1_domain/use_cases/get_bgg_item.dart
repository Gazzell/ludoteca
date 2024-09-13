import 'package:either_dart/either.dart';
import 'package:ludoteca/0_data/repositories/bgg_repository.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

class GetBggItem implements UseCase<Item, GetBggItemParams> {
  final BggRepository bggRepository;

  const GetBggItem({required this.bggRepository});

  @override
  Future<Either<Failure, Item>> call(GetBggItemParams params) async {
    try {
      final item = await bggRepository.getItem(params.itemId);
      return item.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
