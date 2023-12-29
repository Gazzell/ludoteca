import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data_header.dart';
import 'package:ludoteca/2_application/pages/collection/widgets/item_play_properties.dart';

class ItemDetailData extends StatelessWidget {
  const ItemDetailData({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.66,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ItemDetailDataHeader(title: item.title),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ItemPlayProperties(
                minAge: item.minAge,
                minPlayers: item.minPlayers,
                maxPlayers: item.maxPlayers,
                playingTime: item.playingTime,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(item.description ?? 'item.description'),
            )
          ],
        ),
      ),
    );
  }
}
