import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';

class PageHeadline extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PageHeadline({
    required this.text,
    this.width,
    this.centered = false,
    super.key
  });
  // --------------------
  final String text;
  final double? width;
  final bool centered;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperText(
      boxWidth: width,
      text: text,
      textHeight: 100,
      font: MojadwelFonts.headline,
      textColor: Colorz.black255,
      maxLines: 2,
      lineSpacingFactor: 0.6,
      margins: 30,
      centered: centered,
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
