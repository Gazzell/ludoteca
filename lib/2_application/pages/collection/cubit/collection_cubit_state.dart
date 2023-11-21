part of 'collection_cubit.dart';

sealed class CollectionCubitState extends Equatable {
  const CollectionCubitState();

  @override
  List<Object?> get props => [];
}

final class CollectionItemSelectedState extends CollectionCubitState {
  final ItemId? selectedItem;

  const CollectionItemSelectedState({required this.selectedItem});

  @override
  List<Object?> get props => [selectedItem];
}
