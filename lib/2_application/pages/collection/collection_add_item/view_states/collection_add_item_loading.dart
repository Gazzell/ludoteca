import 'package:flutter/material.dart';

class CollectionAddItemLoading extends StatelessWidget {
  const CollectionAddItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
