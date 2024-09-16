import 'package:equatable/equatable.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

enum ItemInstanceStatus {
  available,
  unavailable,
}

class ItemInstance extends Equatable {
  final int instanceId;
  final ItemId itemId;
  final ItemInstanceStatus status;
  final List<String>? incidences;
  final DateTime? borrowedAt;
  final DateTime? returnedAt;
  final UniqueId? borrowedBy;

  const ItemInstance({
    required this.instanceId,
    required this.itemId,
    required this.status,
    this.incidences = const [],
    this.borrowedAt,
    this.returnedAt,
    this.borrowedBy,
  });

  @override
  List<Object?> get props => [
        instanceId,
        itemId,
        status,
        incidences,
        borrowedAt,
        returnedAt,
        borrowedBy,
      ];
}
