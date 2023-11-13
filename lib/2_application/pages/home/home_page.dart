import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int currentPageIndex;
  const HomePage({super.key, required this.currentPageIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container()),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined), label: 'Collection'),
      ]),
    );
  }
}
