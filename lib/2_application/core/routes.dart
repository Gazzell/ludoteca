import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/2_application/pages/collection/collection_add_item/collection_add_item_page.dart';
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
        GoRoute(
          name: 'itemDetail',
          path: '/routes/collection/detail/:itemId',
          builder: (context, state) {
            final itemIdValue = state.pathParameters['itemId'];
            final itemId = itemIdValue != null
                ? ItemId.fromUniqueString(itemIdValue)
                : null;
            return CollectionItemDetailPageProvider(
              selectedItem: itemId,
              showAppBar: true,
            );
          },
        ),
        GoRoute(
          name: 'addItem',
          path: '/routes/collection/addItem',
          builder: (context, state) {
            return const CollectionAddItemPageProvider(
              showAppBar: true,
              title: 'Add Item',
            );
          },
        )
      ],
      builder: (context, state, child) => child,
    ),
  ],
);
