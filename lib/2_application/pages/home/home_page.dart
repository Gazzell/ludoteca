import 'package:flutter/material.dart';
import 'package:ludoteca/2_application/core/page_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.home_outlined,
    name: 'home',
    child: HomePage(),
  );

  @override
  Widget build(BuildContext context) {
    return const Text('Home');
  }
}
