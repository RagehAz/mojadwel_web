// ignore_for_file: prefer_single_quotes

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/app_scroll_behavior.dart';

import 'core/services/fire/fire.dart';
// --------------------------------------------------------------------------

/// MAIN

// --------------------
Future<void> main() async {
  // final WidgetsBinding _binding =
  WidgetsFlutterBinding.ensureInitialized();

  await OfficialFirebase.initialize(
    socialKeys: const SocialKeys(
      // supportApple: false,
      supportEmail: true,
      googleClientID: '410652668976-8k2p2fio3s51farp3pdukbt2ndjfbcic.apps.googleusercontent.com',
      // facebookAppID: null,
    ),
    options: const FirebaseOptions(
      apiKey: "AIzaSyC4pBl-XB9KVzIrwM2HWPiZX3Y2xEqZFvA",
      authDomain: "mojadwelagent.firebaseapp.com",
      projectId: "mojadwelagent",
      storageBucket: "mojadwelagent.firebasestorage.app",
      messagingSenderId: "410652668976",
      appId: "1:410652668976:web:52772a762917a4eff4e9f5"
    ),
  );

  print('starting');

  runApp(const Starter());

}
// --------------------------------------------------------------------------

/// STARTER WIDGET

// --------------------
class Starter extends StatefulWidget {
  // --------------------------------------------------------------------------
  const Starter({super.key});
  // --------------------
  @override
  _StarterState createState() => _StarterState();
// --------------------------------------------------------------------------
}
// --------------------
class _StarterState extends State<Starter> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit == true && mounted == true) {
      _isInit = false;
      asyncInSync(() async {});
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  // --------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      blog('Starter.didChangeAppLifecycleState(RESUMED)');
    } else if (state == AppLifecycleState.inactive) {
      blog('Starter.didChangeAppLifecycleState(INACTIVE)');
    } else if (state == AppLifecycleState.paused) {
      blog('Starter.didChangeAppLifecycleState(PAUSED)');
    } else if (state == AppLifecycleState.detached) {
      blog('Starter.didChangeAppLifecycleState(DETACHED)');
    }
    super.didChangeAppLifecycleState(state);
  }
  // ---------------------
  void asyncInSync(Function? asynchronous) {
    if (asynchronous != null) {
      Future<void> _start() async {}

      _start().then((_) async {
        await asynchronous();
      });
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blog(dynamic msg, {String? invoker}) {
    assert(() {
      if (kDebugMode) {
        debugPrint(msg?.toString());
      }
      return true;
    }(), '_');
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    superContext = context;

    return MaterialApp.router(
      /// KEYS
      // key: ,
      // scaffoldMessengerKey: ,
      // restorationScopeId: ,
      // useInheritedMediaQuery: true,
      /// SCROLLING
      scrollBehavior: const AppScrollBehavior(),

      /// DEBUG
      debugShowCheckedModeBanner: false,

      /// THEME
      title: 'Mojadwel',
      theme: ThemeData(
        canvasColor: Colorz.nothing,
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colorz.youtube,
          selectionColor: Colorz.white50,
        ),
      ),

      /// ROUTES
      routerConfig: Routing.router,
    );
  }
// -----------------------------------------------------------------------------
}
// --------------------------------------------------------------------------
