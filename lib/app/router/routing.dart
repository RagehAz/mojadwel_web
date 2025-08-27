import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:mojadwel_web/app/screens/a_home_screen.dart';
import 'package:mojadwel_web/app/screens/b_auth_screen.dart';
import 'package:mojadwel_web/app/screens/c_sign_up_screen.dart';
import 'package:mojadwel_web/app/screens/d_dash_board_screen.dart';
import 'package:mojadwel_web/app/testing_screens/a_testing_home.dart';
import 'package:mojadwel_web/app/testing_screens/b_auth_testing_screen.dart';
import 'package:mojadwel_web/app/testing_screens/c_fire_testing_screen.dart';
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
  static const routeAuth = 'auth';
  static const routeSignUp = 'signup';
  static const routeDashboard = 'dashboard';
  // --------------------
  static const routeTestingHome = 'testing_home';
  static const routeAuthTesting = 'testing_auth';
  static const routeFireTesting = 'testing_fire';
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

      /// AUTH
      GoRoute(
        path: '/$routeAuth',
        name: routeAuth,
        builder: (context, state) {
          return const AuthScreen();
        },
      ),

      /// SIGN UP
      GoRoute(
        path: '/$routeSignUp',
        name: routeSignUp,
        builder: (context, state) {
          return const SignupScreen();
        },
      ),

      /// DASHBOARD
      GoRoute(
        path: '/$routeDashboard',
        name: routeDashboard,
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),

      // --------------------

      /// TESTING HOME
      GoRoute(
        path: '/$routeTestingHome',
        name: routeTestingHome,
        builder: (context, state) {
          return const TestingHome();
        },
      ),

      /// AUTH TESTING
      GoRoute(
        path: '/$routeAuthTesting',
        name: routeAuthTesting,
        builder: (context, state) {
          return const AuthTestingScreen();
        },
      ),

      /// FIRE TESTING
      GoRoute(
        path: '/$routeFireTesting',
        name: routeFireTesting,
        builder: (context, state) {
          return const FireTestingScreen();
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> push({
    required BuildContext context,
    required Widget screen,
  }) async {

    final dynamic _result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );

    return _result;
  }
  // --------------------------------------------------------------------------
}
// --------------------------------------------------------------------------
