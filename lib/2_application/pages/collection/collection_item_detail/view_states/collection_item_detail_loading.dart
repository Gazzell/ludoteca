import 'package:flutter/material.dart';

class CollectionItemDetailLoading extends StatelessWidget {
  const CollectionItemDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
