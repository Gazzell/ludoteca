part of 'collection_item_detail_cubit.dart';

sealed class CollectionItemDetailCubitState extends Equatable {
  const CollectionItemDetailCubitState();

  @override
  List<Object> get props => [];
}

final class CollectionItemDetailLoadingState
    extends CollectionItemDetailCubitState {
  const CollectionItemDetailLoadingState();
}

final class CollectionItemDetailErrorState
    extends CollectionItemDetailCubitState {
  const CollectionItemDetailErrorState();
}

final class CollectionItemDetailLoadedState
    extends CollectionItemDetailCubitState {
  final FullItem itemDetail;
  const CollectionItemDetailLoadedState({required this.itemDetail}) : super();

  @override
  List<Object> get props => [itemDetail];
}

final class CollectionItemDetailEmptyState
    extends CollectionItemDetailCubitState {
  const CollectionItemDetailEmptyState();
}
