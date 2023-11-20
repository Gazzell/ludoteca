import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/item.dart';

class CollectionListLoaded extends StatelessWidget {
  final List<Item> items;
  const CollectionListLoaded({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image.network(items[index].imageUrl, height: 200, width: 200),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        items[index].title,
                        style: textTheme.titleLarge,
                      ),
                      Text(
                        items[index].description,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
