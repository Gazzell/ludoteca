part of 'collection_list_cubit.dart';

sealed class CollectionListCubitState extends Equatable {
  const CollectionListCubitState();

  @override
  List<Object> get props => [];
}

final class CollectionListLoadingState extends CollectionListCubitState {
  const CollectionListLoadingState();
}

final class CollectionListErrorState extends CollectionListCubitState {
  const CollectionListErrorState();
}

final class CollectionListItemIdsLoadedState extends CollectionListCubitState {
  final List<ItemId> itemIds;
  const CollectionListItemIdsLoadedState({required this.itemIds});

  @override
  List<Object> get props => [itemIds];
}
