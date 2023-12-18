import 'package:flutter/material.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/widgets/rating_star.dart';

class ItemDetailDataHeader extends StatelessWidget {
  final double rating;
  final String title;

  const ItemDetailDataHeader({
    super.key,
    required this.title,
    this.rating = -1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingStar(rating: rating),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
