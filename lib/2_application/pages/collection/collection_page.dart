import 'package:flutter/material.dart';
import 'package:ludoteca/2_application/core/page_config.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.menu_book_outlined,
    name: 'collection',
    child: CollectionPage(),
  );
  @override
  Widget build(BuildContext context) {
    return const Text('Collection');
  }
}