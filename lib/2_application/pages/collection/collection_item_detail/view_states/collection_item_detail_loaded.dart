import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';

class CollectionItemDetailLoaded extends StatelessWidget {
  final FullItem itemDetail;
  const CollectionItemDetailLoaded({super.key, required this.itemDetail});

  @override
  Widget build(BuildContext context) {
    return Text(itemDetail.title);
  }
}
