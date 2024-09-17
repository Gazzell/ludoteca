import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';

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

class AddItemInstanceParams extends Params {
  final ItemInstance itemInstance;

  AddItemInstanceParams({required this.itemInstance});

  @override
  List<Object?> get props => [itemInstance];
}

class GetItemInstancesParams extends Params {
  final List<ItemInstanceId> itemInstanceIds;

  GetItemInstancesParams({required this.itemInstanceIds});

  @override
  List<Object?> get props => [itemInstanceIds];
}

class GetBggItemParams extends Params {
  final String itemId;

  GetBggItemParams({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}
