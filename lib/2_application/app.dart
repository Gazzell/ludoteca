import 'package:flutter/material.dart';
import 'package:ludoteca/2_application/pages/pages_shell.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PagesShell(currentPageIndex: 0));
  }
}
