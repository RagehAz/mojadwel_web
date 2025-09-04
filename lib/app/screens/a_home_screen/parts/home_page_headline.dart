import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';

class HomePageHeadline extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageHeadline({
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
      textHeight: 100,
      font: MojadwelFonts.headline,
      textColor: Colorz.black255,
      maxLines: 4,
      lineSpacingFactor: 0.6,
      margins: 5,
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
