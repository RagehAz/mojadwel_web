// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:mojadwel_web/app/screens/a_home_screen/a_home_screen.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/b_dash_board_screen.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/views/plan_screen.dart';
import 'package:mojadwel_web/app/screens/c_terms_screens/legalizer.dart';
import 'package:mojadwel_web/app/testing_screens/a_testing_home.dart';
import 'package:mojadwel_web/app/testing_screens/b_auth_testing_screen.dart';
import 'package:mojadwel_web/app/testing_screens/c_fire_testing_screen.dart';
import 'package:mojadwel_web/core/theme/app_info.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
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
  static const routeTerms = 'terms';
  static const routePrivacy = 'privacy';
  static const plans = 'plans';
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

      /// DASHBOARD
      GoRoute(
        path: '/$routeDashboard',
        name: routeDashboard,
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),

      /// TERMS
      GoRoute(
        path: '/$routeTerms',
        name: routeTerms,
        builder: (context, state) => const TermsScreen(
          company: theCompanyName,
          domain: theDomainName,
          email: thePublicEmail,
        ),
      ),

      /// PRIVACY
      GoRoute(
        path: '/$routePrivacy',
        name: routePrivacy,
        builder: (context, state) => const PrivacyScreen(
          company: theCompanyName,
          domain: theDomainName,
          email: thePublicEmail,
        ),
      ),

      GoRoute(
        path: '/$plans',
        name: plans,
        builder: (x, _) => PlanView(
          x: x,
          // controller: this,
        ),
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
    required Widget Function(BuildContext x) screen,
  }) async {

    final dynamic _result = await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colorz.nothing,
        fullscreenDialog: true,
        pageBuilder: (BuildContext x, __, ___) => screen(x),
      ),
    );

    return _result;
  }
  // --------------------------------------------------------------------------

  /// ANIMATION

  // --------------------
  static Future<void> waitTheNav() async {
    await Future.delayed(const Duration(milliseconds: 350));
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wait({
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    await Future.delayed(duration);
  }
  // --------------------------------------------------------------------------
}
// --------------------------------------------------------------------------
