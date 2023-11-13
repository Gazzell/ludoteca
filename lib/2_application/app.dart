import 'package:flutter/material.dart';
import 'package:ludoteca/2_application/core/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ludoteca app',
      routerConfig: routes,
    );
  }
}
