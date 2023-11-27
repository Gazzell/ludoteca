import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/cubit/collection_cubit.dart';

class CollectionListLoaded extends StatefulWidget {
  final List<Item> items;

  const CollectionListLoaded({super.key, required this.items});

  @override
  State<CollectionListLoaded> createState() => _CollectionListLoadedState();
}

class _CollectionListLoadedState extends State<CollectionListLoaded> {
  ItemId? selectedItemId;

  _onItemTap(BuildContext context, int index) async {
    final collectionCubit = context.read<CollectionCubit>();

    collectionCubit.selectItem(widget.items[index].id);

    if (Breakpoints.small.isActive(context)) {
      await context.pushNamed('itemDetail', pathParameters: {
        'itemId': widget.items[index].id.value,
      });
      collectionCubit.selectItem(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<CollectionCubit, CollectionCubitState>(
      listener: (context, state) {
        if (state is CollectionItemSelectedState) {
          setState(() {
            selectedItemId = state.selectedItem;
          });
        }
      },
      child: NotificationListener(
        onNotification: (notification) {
          if (Breakpoints.small.isActive(context) && selectedItemId != null) {
            final collectionCubit = context.read<CollectionCubit>();
            collectionCubit.selectItem(null);
          }
          return true;
        },
        child: Center(
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _onItemTap(context, index),
                child: Card(
                  color: selectedItemId == widget.items[index].id &&
                          !Breakpoints.small.isActive(context)
                      ? colorScheme.inverseSurface
                      : colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Image.network(widget.items[index].imageUrl,
                                height: 200, width: 200),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                widget.items[index].title,
                                style: textTheme.titleLarge,
                              ),
                              Text(
                                widget.items[index].description,
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
