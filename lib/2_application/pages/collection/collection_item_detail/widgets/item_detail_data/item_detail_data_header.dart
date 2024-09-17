import 'package:flutter/material.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/rating_star.dart';

class ItemDetailDataHeader extends StatelessWidget {
  final double rating;
  final String title;
  final bool showItemInstancesButton;
  final VoidCallback? onShowItemInstances;

  const ItemDetailDataHeader({
    super.key,
    required this.title,
    this.rating = -1,
    this.showItemInstancesButton = false,
    this.onShowItemInstances,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingStar(rating: rating),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        if (showItemInstancesButton)
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: onShowItemInstances,
          ),
      ],
    );
  }
}
