import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/shared_components/dialogs/center_dialog.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class TestingHome extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TestingHome({super.key});
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: (ScreenDim screen) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// AUTH TESTING
          MenuButton(
            icon: Iconz.googleColor,
            text: 'Auth Testing screen',
            onTap: () async {

              await Routing.goTo(
                route: Routing.routeAuthTesting,
              );

            },
          ),

          /// FIRE TESTING
          MenuButton(
            icon: Iconz.star,
            text: 'Fire Testing screen',
            onTap: () async {

              await Routing.goTo(
                route: Routing.routeFireTesting,
              );

            },
          ),

          /// TOP DIALOG
          MenuButton(
            icon: Iconz.star,
            text: 'Top dialog test',
            onTap: () async {

              await Dialogs.stateDialog(state: true);

            },
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class MenuButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MenuButton({
    required this.text,
    required this.icon,
    required this.onTap,
    super.key
  });
  // --------------------
  final Function onTap;
  final dynamic icon;
  final String text;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperBox(
      height: 50,
      width: context.screenWidth * 0.5,
      color: Colorz.dark1,
      icon: icon,
      iconSizeFactor: 0.6,
      text: text,
      textCentered: false,
      // iconColor: Colorz.googleRed,
      // color: Colorz.white255,
      // iconSizeFactor: 1,
      // corners: 50,
      margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      onTap: onTap,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
