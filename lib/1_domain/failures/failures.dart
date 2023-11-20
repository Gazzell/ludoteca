import 'package:equatable/equatable.dart';

abstract class Failure {}

class ServerFailure extends Failure with EquatableMixin {
  final String? stackTrace;
  ServerFailure({this.stackTrace});

  @override
  List<Object?> get props => [stackTrace];
}

class ItemNotFoundFailure extends Failure with EquatableMixin {
  final String itemId;
  ItemNotFoundFailure({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}
