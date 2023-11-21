import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_item_detail/collection_item_detail_page.dart';
import 'package:ludoteca/2_application/pages/pages_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'pages');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/routes/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        GoRoute(
          name: 'shell',
          path: '/routes/:tab',
          builder: (context, state) {
            return PagesShell(
              key: state.pageKey,
              tab: state.pathParameters['tab'] ?? 'home',
            );
          },
        ),
      ],
      builder: (context, state, child) => child,
    ),
    GoRoute(
        name: 'itemDetail',
        path: '/routes/collection/:itemId',
        builder: (context, state) {
          final itemIdValue = state.pathParameters['itemId'];
          final itemId =
              itemIdValue != null ? ItemId.fromUniqueString(itemIdValue) : null;
          return NotificationListener(
              onNotification: (notification) {
                if (Breakpoints.small.isActive(context) && context.canPop()) {
                  context.pop(true);
                }
                return true;
              },
              child: SizeChangedLayoutNotifier(
                child: CollectionItemDetailPage(selectedItem: itemId),
              ));
        },),
  ],
);
