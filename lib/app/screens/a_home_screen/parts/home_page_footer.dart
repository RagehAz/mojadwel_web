import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/lists/expander.dart';
import 'package:mojadwel_web/core/shared_components/lists/separator_line.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/app_info.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';

class HomePageFooter extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageFooter({
    required this.width,
    super.key
  });
  // --------------------
  final double width;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Column(
      children: [

        /// LINE
        SeparatorLine(
          width: width,
          color: Colorz.light3,
        ),

        /// SPACING
        const Spacing(size: 20),

        /// FOLLOW US
        SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              /// FOLLOW US
              const SuperBox(
                height: 30,
                // width: _appBarHeight,
                // icon: Iconz.logoPng,
                text: 'Follow us',
                textColor: Colorz.black255,
                textFont: MojadwelFonts.body,
                textWeight: FontWeight.w500,
                textScaleFactor: 1 / 0.7,
                iconSizeFactor: 0.7,
                splashColor: Colorz.nothing,
                margins: EdgeInsets.symmetric(horizontal: 5),
              ),

              /// FACEBOOK
              SuperBox(
                height: 30,
                width: 30,
                icon: Iconz.facebook,
                iconColor: Colorz.black255,
                splashColor: Colorz.facebook,
                color: Colorz.white255,
                margins: const EdgeInsets.symmetric(horizontal: 5),
                onTap: (){
                  blog('should go facebook page');
                },
              ),

              /// INSTAGRAM
              SuperBox(
                height: 30,
                width: 30,
                icon: Iconz.instagram,
                iconColor: Colorz.white255,
                splashColor: Colorz.instagram,
                color: Colorz.black255,
                margins: const EdgeInsets.symmetric(horizontal: 5),
                onTap: (){
                  blog('should go instagram page');
                },
              ),

              /// SPACING
              const Spacing(size: 20),

            ],
          ),
        ),

        /// SPACING
        const Spacing(size: 20),

        /// LOGO AND TERMS
        SizedBox(
          width: width,
          child: Row(
            children: <Widget>[

              /// LOGO
              const SuperBox(
                height: 40,
                // width: _appBarHeight,
                // icon: Iconz.logoPng,
                text: theBrandName,
                textColor: Colorz.black255,
                textFont: MojadwelFonts.headline,
                textWeight: FontWeight.w500,
                textScaleFactor: 1.5 / 0.7,
                iconSizeFactor: 0.7,
                splashColor: Colorz.nothing,
                margins: EdgeInsets.symmetric(horizontal: 10),
              ),

              /// EXPANDER
              const Expander(),

              /// COPY RIGHTS
              const _SmallText(
                text: '©2025 $theCompanyName',
              ),

              /// SPACING
              const Spacing(size: 5),

              /// LEGAL
              _SmallText(
                text: 'Legal',
                onTap: (){
                  blog('should go to legal terms and regulations page');
                },
              ),

              /// SPACING
              const Spacing(size: 5),

              /// PRIVACY
              _SmallText(
                text: 'Privacy',
                onTap: (){
                  blog('should go to privacy policy page');
                },
              ),

              /// SPACING
              const Spacing(size: 20),

            ],
          ),
        ),

        /// SPACING
        const Spacing(size: 50),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _SmallText extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _SmallText({
    required this.text,
    this.onTap,
  });
  // --------------------
  final String text;
  final Function? onTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperBox(
      text: text,
      textColor: Colorz.black255,
      height: 25,
      corners: 4,
      textScaleFactor: 1.1,
      textFont: MojadwelFonts.body,
      onTap: onTap,
      splashColor: Colorz.bloodTest,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
