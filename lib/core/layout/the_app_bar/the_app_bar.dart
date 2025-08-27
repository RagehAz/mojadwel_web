import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/layout/the_app_bar/the_menu_button.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_image/super_image.dart';
import 'package:mojadwel_web/core/shared_components/super_pop_menu/super_pop_menu.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';

class TheAppBar extends StatelessWidget implements PreferredSizeWidget {
  // --------------------------------------------------------------------------
  const TheAppBar({super.key});
  // -----------------------------------------------------------------------------

  @override
  Size get preferredSize => const Size.fromHeight(Scale.appBarHeight);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    const double _appBarHeight = Scale.appBarHeight;
    final topMargin = context.safeAreaTopPadding;
    // --------------------
    return Container(
      width: _screenWidth,
      height: _appBarHeight + topMargin,
      padding: EdgeInsets.only(top: topMargin),
      decoration: const BoxDecoration(
        color: Colorz.white255,
        // border: Borderers.borderOnly(
        //   color: Colorz.white125,
        //   bottom: true,
        // ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            SuperBox(
              onTap: () => Routing.goTo(route: Routing.routeHome),
              height: _appBarHeight,
              width: _appBarHeight,
              icon: Iconz.logoPng,
              iconSizeFactor: 0.7,
              splashColor: Colorz.nothing,
              margins: const EdgeInsets.symmetric(horizontal: 10),
            ),

            SizedBox(
              height: _appBarHeight,
              width: _screenWidth - ((_appBarHeight + 20) * 2),
            ),

            const SuperPopMenu(
              corners: BorderRadius.all(Radius.circular(15)),
              borderColor: Colorz.dark2,
              // offset: const Offset(0, 0),
              bubbleColor: Colorz.dark2,
              enabled: true,
              popupChild: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  /// SPACING
                  SizedBox(width: 10, height: 10),

                  /// HOME
                  TheMenuButton(text: 'HOME', route: Routing.routeHome),

                  /// SPACING
                  SizedBox(width: 10, height: 10),

                  /// AUTH
                  TheMenuButton(text: 'Auth', route: Routing.routeAuth),

                  /// SPACING
                  SizedBox(width: 10, height: 10),

                  /// SIGN UP
                  TheMenuButton(text: 'Signup', route: Routing.routeSignUp),

                  /// SPACING
                  SizedBox(width: 10, height: 10),

                  /// DASHBOARD
                  TheMenuButton(text: 'Dashboard', route: Routing.routeDashboard),

                  /// SPACING
                  SizedBox(width: 10, height: 10),

                  /// TESTING HOME
                  TheMenuButton(text: 'Testing Home', route: Routing.routeTestingHome),

                  /// SPACING
                  SizedBox(width: 10, height: 10),

                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SuperImage(
                  height: Scale.appBarHeight,
                  width: Scale.appBarHeight,
                  pic: Icons.menu,
                  iconColor: Colorz.light3,
                  loading: false,
                  scale: 0.6,
                ),
              ),
            ),

          ],
        ),
      ),
    );
    // --------------------
  }

  // -----------------------------------------------------------------------------
}
