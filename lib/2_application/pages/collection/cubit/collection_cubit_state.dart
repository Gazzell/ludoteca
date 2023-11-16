part of 'collection_cubit.dart';

sealed class CollectionCubitState extends Equatable {
  const CollectionCubitState();

  @override
  List<Object> get props => [];
}

final class CollectionInitialState extends CollectionCubitState {
  const CollectionInitialState();
}

final class CollectionLoadingState extends CollectionCubitState {
  const CollectionLoadingState();
}

final class CollectionErrorState extends CollectionCubitState {
  const CollectionErrorState();
}

final class CollectionItemIdsLoadedState extends CollectionCubitState {
  final List<ItemId> itemIds;
  const CollectionItemIdsLoadedState({required this.itemIds});

  @override
  List<Object> get props => [itemIds];
}
