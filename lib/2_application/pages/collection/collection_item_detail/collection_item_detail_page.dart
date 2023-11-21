import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

class CollectionItemDetailPage extends StatelessWidget {
  final ItemId? selectedItem;
  const CollectionItemDetailPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Text(selectedItem?.value ?? '');
  }
}
