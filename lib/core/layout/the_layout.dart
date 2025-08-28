import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojadwel_web/core/layout/the_app_bar/the_app_bar.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';

class TheLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheLayout({
    required this.child,
    this.backgroundColor,
    super.key,
  });
  // --------------------
  final Widget Function(double width) child;
  final Color? backgroundColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bodyWidth = Scale.theBodyWidth(context);
    // --------------------
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colorz.light3,
        statusBarColor: Colorz.light3,
        systemNavigationBarDividerColor: Colorz.light3,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colorz.light1,
        appBar: const TheAppBar(),
        body: Center(
            child: child(_bodyWidth)
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
