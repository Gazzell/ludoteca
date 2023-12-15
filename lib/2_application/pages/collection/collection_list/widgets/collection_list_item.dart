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
            : colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.network(item.imageUrl, height: 200, width: 200),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      item.title,
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      item.description,
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
  }
}
