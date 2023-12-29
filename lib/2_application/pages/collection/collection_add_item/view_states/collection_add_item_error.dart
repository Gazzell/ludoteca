import 'package:flutter/material.dart';

class CollectionAddItemError extends StatelessWidget {
  const CollectionAddItemError({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Card(
        color: colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Error getting bgg item. Try again later.',
            style: TextStyle(
              color: colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
