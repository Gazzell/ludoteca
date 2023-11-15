import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/2_application/core/page_config.dart';
import 'package:ludoteca/2_application/pages/collection/collection_page.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';

class PagesShell extends StatefulWidget {
  final int currentPageIndex;
  PagesShell({super.key, required String tab})
      : currentPageIndex = tabs.indexWhere((element) => element.name == tab);

  static const List<PageConfig> tabs = [
    HomePage.pageConfig,
    CollectionPage.pageConfig,
  ];

  @override
  State<PagesShell> createState() => _PagesShellState();
}

class _PagesShellState extends State<PagesShell> {
  final destinations = PagesShell.tabs.map(
    (page) => NavigationDestination(
      icon: Icon(page.icon, key: Key('icon-${page.name}')),
      label: page.name,
    ),
  );

  void _onTapNavigationDestination(BuildContext context, int index) {
    context.goNamed(
      'shell',
      pathParameters: {'tab': PagesShell.tabs[index].name},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium-and-up'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  destinations: destinations
                      .map(
                        (destination) =>
                            AdaptiveScaffold.toRailDestination(destination),
                      )
                      .toList(),
                  onDestinationSelected: (index) =>
                      _onTapNavigationDestination(context, index),
                  selectedIndex: widget.currentPageIndex,
                ),
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottom-navigation-small'),
                builder: (context) =>
                    AdaptiveScaffold.standardBottomNavigationBar(
                  destinations: destinations.toList(),
                  onDestinationSelected: (index) =>
                      _onTapNavigationDestination(context, index),
                  currentIndex: widget.currentPageIndex,
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('body-small-and-up'),
                builder: (context) =>
                    PagesShell.tabs[widget.currentPageIndex].child,
              )
            },
          ),
        ),
      ),
    );
  }
}
