import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';

class ItemDetailInstanceList extends StatelessWidget {
  final List<ItemInstance> instances;
  const ItemDetailInstanceList({super.key, required this.instances});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: instances.map(
        (instance) {
          return Text('Item ${instance.id}');
        },
      ).toList(),
    );
  }
}
