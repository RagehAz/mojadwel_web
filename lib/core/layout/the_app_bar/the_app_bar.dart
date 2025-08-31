import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/layout/the_app_bar/the_menu_button.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_image/super_image.dart';
import 'package:mojadwel_web/core/shared_components/super_pop_menu/super_pop_menu.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';

class TheAppBar extends StatelessWidget implements PreferredSizeWidget {
  // --------------------------------------------------------------------------
  const TheAppBar({super.key});
  // --------------------
  @override
  Size get preferredSize => const Size.fromHeight(Scale.appBarHeight);
  // --------------------
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _theBodyWidth = Scale.theBodyWidth(context);
    const double _appBarHeight = Scale.appBarHeight;
    final topMargin = context.safeAreaTopPadding;
    // --------------------
    return Container(
      width: _screenWidth,
      height: _appBarHeight + topMargin,
      padding: EdgeInsets.only(top: topMargin),
      decoration: const BoxDecoration(
        color: Colorz.light1,
        // border: Borderers.borderOnly(
        //   color: Colorz.white125,
        //   bottom: true,
        // ),
      ),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: _theBodyWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
        
              SuperBox(
                onTap: () => Routing.goTo(route: Routing.routeHome),
                height: _appBarHeight,
                // width: _appBarHeight,
                // icon: Iconz.logoPng,
                text: 'Mokh.ai',
                textColor: Colorz.black255,
                textFont: MojadwelFonts.headline,
                textWeight: FontWeight.w500,
                textScaleFactor: 1.5 / 0.7,
                iconSizeFactor: 0.7,
                splashColor: Colorz.nothing,
                margins: const EdgeInsets.symmetric(horizontal: 10),
              ),
        
              const SuperPopMenu(
                corners: BorderRadius.all(Radius.circular(20)),
                borderColor: Colorz.light2,
                offset: Offset(- 10, 0),
                bubbleColor: Colorz.light1,
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

                    /// DASHBOARD
                    TheMenuButton(text: 'PROFILE', route: Routing.routeDashboard),

                    /// SPACING
                    if (kDebugMode)
                    SizedBox(width: 10, height: 10),

                    /// TESTING HOME
                    if (kDebugMode)
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
                    pic: Iconz.menu,
                    iconColor: Colorz.black255,
                    loading: false,
                    scale: 0.6,
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
