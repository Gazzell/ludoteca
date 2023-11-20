import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class ItemParams extends Params {
  final ItemId itemId;

  ItemParams({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}
