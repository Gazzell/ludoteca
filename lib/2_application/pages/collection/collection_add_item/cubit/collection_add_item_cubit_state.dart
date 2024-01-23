part of 'collection_add_item_cubit.dart';

sealed class CollectionAddItemCubitState extends Equatable {
  const CollectionAddItemCubitState();

  @override
  List<Object> get props => [];
}

final class CollectionAddItemLoadingState extends CollectionAddItemCubitState {
  const CollectionAddItemLoadingState();
}

final class CollectionAddItemErrorState extends CollectionAddItemCubitState {
  const CollectionAddItemErrorState();
}

final class CollectionAddItemLoadedState extends CollectionAddItemCubitState {
  final Item item;
  const CollectionAddItemLoadedState({required this.item}) : super();

  @override
  List<Object> get props => [item];
}

final class CollectionAddItemEmptyState extends CollectionAddItemCubitState {
  const CollectionAddItemEmptyState();
}

final class CollectionAddItemAddedState extends CollectionAddItemCubitState {
  final Item item;
  const CollectionAddItemAddedState({required this.item}) : super();

  @override
  List<Object> get props => [item];
}
