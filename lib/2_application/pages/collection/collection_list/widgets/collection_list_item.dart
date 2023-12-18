import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:ludoteca/1_domain/entities/item.dart';

class CollectionListItem extends StatelessWidget {
  final Item item;
  final bool selected;
  final Function() onTap;

  CollectionListItem({
    super.key,
    required this.item,
    this.selected = false,
    Function()? onTap,
  }) : onTap = onTap ?? (() {});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Card(
        color: selected && !Breakpoints.small.isActive(context)
            ? colorScheme.inverseSurface
            : item.status == ItemStatus.available
                ? colorScheme.surface
                : colorScheme.inversePrimary,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(item.imageUrl),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    item.title,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
