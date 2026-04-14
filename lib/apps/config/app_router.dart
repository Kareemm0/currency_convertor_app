import 'package:currency_convertor_app/apps/apps.dart';
import 'package:currency_convertor_app/presentation/screens/custom_bottom_nav_bar_screen.dart';
import 'package:currency_convertor_app/presentation/screens/historical_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/presentation.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: "/${Routes.home}",
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.home,
              path: "/${Routes.home}",
              builder: (context, state) {
                return const HomeScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.historical,
              path: "/${Routes.historical}",
              builder: (context, state) {
                return const HistoricalScreen();
              },
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) =>
          CustomBottomNavBarScreen(navigationShell: navigationShell),
    ),
  ],
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
);
