import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/2_application/pages/collection/collection_page.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';

class PagesShell extends StatefulWidget {
  final int currentPageIndex;
  PagesShell({super.key, required String tab})
      : currentPageIndex = tabs.indexWhere((element) => element['name'] == tab);

  static const tabs = [
    {
      'child': HomePage(),
      'name': 'home',
      'icon': Icons.home_outlined,
    },
    {
      'child': CollectionPage(),
      'name': 'collection',
      'icon': Icons.menu_book_outlined,
    },
  ];

  @override
  State<PagesShell> createState() => _PagesShellState();
}

class _PagesShellState extends State<PagesShell> {
  void _onTapNavigationDestination(BuildContext context, int index) {
    context.goNamed(
      'shell',
      pathParameters: {'tab': PagesShell.tabs[index]['name'] as String},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PagesShell.tabs[widget.currentPageIndex]['child'] as Widget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentPageIndex,
        items: PagesShell.tabs
            .map(
              (tab) => BottomNavigationBarItem(
                  icon: Icon(tab['icon'] as IconData),
                  label: tab['name'] as String),
            )
            .toList(),
        onTap: (value) => _onTapNavigationDestination(context, value),
      ),
    );
  }
}
