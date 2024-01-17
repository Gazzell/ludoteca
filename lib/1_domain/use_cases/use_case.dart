import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../entities/unique_id.dart';
import '../failures/failures.dart';
import '../entities/item.dart';

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

class AddItemParams extends Params {
  final Item item;

  AddItemParams({required this.item});

  @override
  List<Object?> get props => [item];
}
