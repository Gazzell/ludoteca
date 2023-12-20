import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/2_application/pages/collection/widgets/item_play_properties.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    item.imageUrl,
                    width: 150,
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: Breakpoints.medium.isActive(context)
                            ? textTheme.titleLarge
                            : textTheme.headlineSmall,
                        // textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: Breakpoints.medium.isActive(context) ? 25 : 50,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ItemPlayProperties(
                          minAge: item.minAge,
                          minPlayers: item.minPlayers,
                          maxPlayers: item.maxPlayers,
                          playingTime: item.playingTime,
                        ),
                      ),
                    ],
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
