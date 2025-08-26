import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:mojadwel_web/app/screens/a_home_screen.dart';
import 'package:mojadwel_web/app/screens/b_dash_board_screen.dart';
// -----------------------------------------------------------------------------

/// MAIN NAV KEY SUPER GLOBAL KEY

// --------------------
final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>();
// --------------------
BuildContext? superContext;
// --------------------
/// TESTED : WORKS PERFECT
BuildContext getTheMainContext() {
  return mainNavKey.currentContext ?? superContext!;
}
// -----------------------------------------------------------------------------

/// ROUTER

// --------------------
abstract class Routing {
  // --------------------------------------------------------------------------

  /// ROUTES

  // --------------------
  static const routeHome = 'home';
  static const routeDashboard = 'dashboard';
  // --------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  static final GoRouter router = GoRouter(
    navigatorKey: mainNavKey,
    initialLocation: '/',
    routes: <GoRoute>[
      // --------------------

      /// HOME
      GoRoute(
        path: '/',
        name: routeHome,
        builder: (context, state) => const HomeScreen(),
      ),

      /// VIDEO
      GoRoute(
        path: '/$routeDashboard',
        name: routeDashboard,
        builder: (context, state) {
          final params = state.uri.queryParameters;
          final data = params['encrypted'];
          return DashBoardScreen(
            encryptedData: data,
          );
        },
      ),

      // --------------------

    ],
  );
  // --------------------------------------------------------------------------

  /// NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goTo({required String route, String? arg}) async {
    getTheMainContext().goNamed(route);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBack({
    required BuildContext? context,
    String? invoker,
    dynamic passedData,
    bool addPostFrameCallback = false,
  }) async {
    /// OLD
    if (context != null) {
      if (Navigator.canPop(context) == true) {
        if (addPostFrameCallback == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context, passedData);
          });
        } else {
          await Future.delayed(Duration.zero, () {
            Navigator.pop(context, passedData);
          });
        }
      }
    }
  }
  // --------------------------------------------------------------------------
}
// --------------------------------------------------------------------------
