import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item.dart';

class CollectionListLoaded extends StatelessWidget {
  final List<Item> items;
  const CollectionListLoaded({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(items[index].title),
          ));
        },
      ),
    );
  }
}
