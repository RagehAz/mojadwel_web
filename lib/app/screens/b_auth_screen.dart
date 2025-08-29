import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';

class AuthScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AuthScreen({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: (double bodyWidth) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// GOOGLE AUTH
          CheckTile(
            width: bodyWidth,
            headline: 'Google Sign in',
            icon: Iconz.googleColor,
            isDone: true,
          ),

          /// GOOGLE SHEETS
          CheckTile(
            width: bodyWidth,
            headline: 'Google sheets',
            icon: Iconz.googleSheetsColor,
            isDone: true,
          ),

          /// GOOGLE CALENDAR
          CheckTile(
            width: bodyWidth,
            headline: 'Google calendar',
            icon: Iconz.googleCalendarColor,
            isDone: true,
          ),

          /// WHATS APP NUMBER
          CheckTile(
            width: bodyWidth,
            headline: 'Whatsapp number',
            icon: Iconz.whatsappColor,
            isDone: true,
          ),


        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}


class CheckTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CheckTile({
    required this.headline,
    required this.icon,
    required this.isDone,
    required this.width,
    super.key
  });
  // --------------------
  final String headline;
  final String icon;
  final bool isDone;
  final double width;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: width,
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colorz.light2,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[

          Container(
            width: 100,
            height: 100,
            // color: Colorz.light2,
            alignment: Alignment.center,
            child: SuperBox(
              height: 90,
              width: 90,
              icon: icon,
              iconSizeFactor: 0.7,
            ),
          ),

          SizedBox(
            width: width - 200,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SuperText(
                  text: headline,
                  textColor: Colorz.black255,
                  textHeight: 40,
                ),

              ],
            ),
          ),

          Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: SuperBox(
              height: 90,
              width: 90,
              icon: isDone ? Iconz.check : Iconz.xBig,
              iconSizeFactor: 0.7,
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
