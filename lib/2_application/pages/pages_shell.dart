import 'package:flutter/material.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';

class PagesShell extends StatefulWidget {
  final int currentPageIndex;
  const PagesShell({super.key, required this.currentPageIndex});

  @override
  State<PagesShell> createState() => _PagesShellState();
}

class _PagesShellState extends State<PagesShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(child: HomePage()),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined), label: 'Collection'),
      ]),
    );
  }
}
