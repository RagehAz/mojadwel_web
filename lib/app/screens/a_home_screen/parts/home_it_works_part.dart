import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';

class HowItWorksCard extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HowItWorksCard({
    required this.headline,
    required this.text,
    required this.icon,
    super.key
  });
  // --------------------
  final String headline;
  final String text;
  final String icon;
  // -----------------------------------------------------------------------------
  Border? borderThick(Color? color, double thickness){
    return color == null || color == Colorz.nothing ? null : Border.all(
      width: thickness,
      color: color,
      strokeAlign: BorderSide.strokeAlignOutside,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colorz.light1,
        border: borderThick(Colorz.light3, 2),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[

          /// ICON
          SuperBox(
            height: 50,
            width: 50,
            margins: 20,
            icon: icon,
            iconSizeFactor: 0.9,
            textCentered: false,
          ),

          /// HEADLINE
          SuperText(
            boxWidth: 250,
            text: headline,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            textHeight: 30,
            font: MojadwelFonts.body,
            weight: FontWeight.w900,
            textColor: Colorz.black255,
            lineSpacingFactor: 0.8,
          ),

          /// DESCRIPTION
          SuperText(
            boxWidth: 250,
            text: text,
            maxLines: 5,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            textHeight: 25,
            font: MojadwelFonts.body,
            weight: FontWeight.w500,
            textColor: Colorz.black255,
            lineSpacingFactor: 0.8,
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
