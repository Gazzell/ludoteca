import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/item_detail_data/item_detail_data_header.dart';
import 'package:ludoteca/2_application/pages/collection/widgets/item_play_properties.dart';

class ItemDetailData extends StatelessWidget {
  const ItemDetailData({
    super.key,
    required this.itemDetail,
  });

  final FullItem itemDetail;

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
              child: ItemDetailDataHeader(title: itemDetail.title),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ItemPlayProperties(
                minAge: itemDetail.minAge,
                minPlayers: itemDetail.minPlayers,
                maxPlayers: itemDetail.maxPlayers,
                playingTime: itemDetail.playingTime,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Text(itemDetail.longDescription ?? 'itemDetail.description'),
            )
          ],
        ),
      ),
    );
  }
}
