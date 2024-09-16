import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';

part 'item_instance_model.g.dart';

@JsonSerializable()
class ItemInstanceModel extends Equatable {
  final int instanceId;
  final String itemId;
  final String status;
  final List<String>? incidences;
  final DateTime? borrowedAt;
  final DateTime? returnedAt;
  final String? borrowedBy;

  const ItemInstanceModel({
    required this.instanceId,
    required this.itemId,
    required this.status,
    this.incidences = const [],
    this.borrowedAt,
    this.returnedAt,
    this.borrowedBy,
  });

  factory ItemInstanceModel.fromJson(Map<String, dynamic> json) =>
      _$ItemInstanceModelFromJson(json);

  factory ItemInstanceModel.fromItemInstance(ItemInstance itemInstance) =>
      ItemInstanceModel(
        instanceId: itemInstance.instanceId,
        itemId: itemInstance.itemId.value,
        status: itemInstance.status.name,
        incidences: itemInstance.incidences,
        borrowedAt: itemInstance.borrowedAt,
        returnedAt: itemInstance.returnedAt,
        borrowedBy: itemInstance.borrowedBy?.value,
      );

  Map<String, dynamic> toJson() => _$ItemInstanceModelToJson(this);

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
