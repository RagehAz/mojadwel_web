import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';

class HomePageSecondLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageSecondLine({
    required this.text,
    super.key
  });
  // --------------------
  final String text;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperText(
      text: text,
      textHeight: 35,
      font: MojadwelFonts.body,
      textColor: Colorz.black255,
      maxLines: 2,
      lineSpacingFactor: 0.8,
      margins: 5,
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
