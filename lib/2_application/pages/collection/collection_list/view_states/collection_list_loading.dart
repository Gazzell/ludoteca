import 'package:flutter/material.dart';

class CollectionListLoading extends StatelessWidget {
  const CollectionListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
