import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';

class MenuButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MenuButton({
    required this.size,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isSelected,
    super.key
  });
  // --------------------
  final double size;
  final dynamic icon;
  final String text;
  final Function onTap;
  final bool isSelected;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TapLayer(
      height: size,
      width: size,
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 10, top: 1),
      boxColor: isSelected ? Colorz.black255 : Colorz.light2,
      borderColor: Colorz.light3,
      corners: BorderRadius.all(Radius.circular(size * 0.2)),
      splashColor: Colorz.green255,
      child: Column(
        children: [

          SuperBox(
            height: size * 0.7,
            width: size,
            icon: icon,
            iconColor: isSelected ? Colorz.white255 : Colorz.black255,
            iconSizeFactor: 0.7,
          ),

          SuperText(
            boxHeight: size * 0.3,
            boxWidth: size,
            text: text,
            textHeight: size * 0.3,
            maxLines: 2,
            textColor: isSelected ? Colorz.white255 : Colorz.black255,
            font: MojadwelFonts.headline,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
