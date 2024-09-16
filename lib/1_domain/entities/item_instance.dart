import 'package:equatable/equatable.dart';
import 'package:ludoteca/0_data/models/item_instance_model.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

enum ItemInstanceStatus {
  available,
  unavailable,
}

class ItemInstance extends Equatable {
  final ItemInstanceId id;
  final ItemId itemId;
  final ItemInstanceStatus status;
  final List<String>? incidences;
  final DateTime? borrowedAt;
  final DateTime? returnedAt;
  final UniqueId? borrowedBy;

  const ItemInstance({
    required this.id,
    required this.itemId,
    required this.status,
    this.incidences = const [],
    this.borrowedAt,
    this.returnedAt,
    this.borrowedBy,
  });

  factory ItemInstance.fromItemInstanceModel(
      ItemInstanceModel itemInstanceModel) {
    return ItemInstance(
      id: ItemInstanceId.fromUniqueString(itemInstanceModel.id),
      itemId: ItemId.fromUniqueString(itemInstanceModel.itemId),
      status: itemInstanceModel.status == 'available'
          ? ItemInstanceStatus.available
          : ItemInstanceStatus.unavailable,
      incidences: itemInstanceModel.incidences,
      borrowedAt: itemInstanceModel.borrowedAt,
      returnedAt: itemInstanceModel.returnedAt,
      borrowedBy: itemInstanceModel.borrowedBy != null
          ? UniqueId.fromUniqueString(itemInstanceModel.borrowedBy!)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        itemId,
        status,
        incidences,
        borrowedAt,
        returnedAt,
        borrowedBy,
      ];
}
