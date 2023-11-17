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

final class CollectionListItemsLoadedState extends CollectionListCubitState {
  final List<Item> items;
  const CollectionListItemsLoadedState({required this.items});

  @override
  List<Object> get props => [items];
}
