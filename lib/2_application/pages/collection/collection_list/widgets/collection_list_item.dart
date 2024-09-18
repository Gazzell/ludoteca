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
        elevation: 0,
        margin: EdgeInsets.zero,
        color: selected && Breakpoints.largeAndUp.isActive(context)
            ? colorScheme.inversePrimary
            : colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: item.imageUrl != null
                        ? Image.network(
                            item.imageUrl!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : const Placeholder(
                            fallbackWidth: 150,
                            fallbackHeight: 150,
                          ),
                  ),
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
                      style: Breakpoints.mediumAndUp.isActive(context)
                          ? textTheme.titleLarge
                          : textTheme.titleMedium,
                      // textAlign: TextAlign.start,
                    ),
                    // SizedBox(
                    //   height: Breakpoints.medium.isActive(context) ? 25 : 50,
                    // ),
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
    );
  }
}
