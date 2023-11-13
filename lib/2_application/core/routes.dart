import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ludoteca/2_application/pages/pages_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'pages');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/routes',
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(
            path: '/routes',
            name: 'shell',
            builder: (context, state) => const PagesShell(currentPageIndex: 0),
          ),
        ],
        builder: (context, state, child) => child),
  ],
);
