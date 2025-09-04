import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/lists/expander.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';

class PlanCard extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PlanCard({
    required this.headline,
    required this.secondLine,
    required this.bullets,
    required this.price,
    required this.bodyWidth,
    this.onTap,
    super.key
  });
  // --------------------
  final String headline;
  final String secondLine;
  final List<String> bullets;
  final String price;
  final Function? onTap;
  final double bodyWidth;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _currentWidth = bodyWidth * 0.45;
    const double _max = 600;
    const double _min = 450;
    // --------------------
    final double _boxWidth =
    _currentWidth > _min && _currentWidth < _max ? _currentWidth
        :
    _currentWidth < _min ? _min
        :
    _currentWidth > _max ? _max
        :
    _currentWidth
    ;
    // --------------------
    return Container(
      width: _boxWidth,
      height: 600,
      decoration: BoxDecoration(
        color: Colorz.light1,
        borderRadius: BorderRadius.circular(20),
        border: BoxBorder.all(color: Colorz.light3),
      ),
      child: Column(
        children: <Widget>[

          /// HEADLINE
          SuperText(
            text: headline,
            textHeight: 60,
            boxWidth: _boxWidth - 20,
            font: MojadwelFonts.headline,
            textColor: Colorz.black255,
            maxLines: 2,
            lineSpacingFactor: 0.6,
            margins: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
          ),

          /// SECOND LINE
          SizedBox(
            height: 120,
            // alignment: Alignment.topLeft,
            child: SuperText(
              text: secondLine,
              textHeight: 28,
              boxWidth: _boxWidth - 20,
              font: MojadwelFonts.body,
              textColor: Colorz.black255,
              maxLines: 5,
              centered: false,
              weight: FontWeight.w500,
              margins: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),
            ),
          ),

          /// BULLETS
          Container(
            width: _boxWidth,
            alignment: Alignment.center,
            child: BulletPoints(
              bulletPoints: bullets,
              boxWidth: _boxWidth - 40,
              textHeight: 25,
              textColor: Colorz.black255,
              showBottomLine: false,
              showDots: false,
            ),
          ),

          /// EXPANDER
          const Expander(),

          /// PRICE
          SuperText(
            text: price,
            boxColor: Colorz.black20,
            boxWidth: _boxWidth - 20,
            font: MojadwelFonts.headline,
            textColor: Colorz.black255,
            maxLines: 2,
            lineSpacingFactor: 0.6,
            margins: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10
            ),
          ),

          /// BUTTON
          SuperBox(
            height: 80,
            width: _boxWidth - 22,
            text: 'Get',
            onTap: onTap,
            textWeight: FontWeight.w500,
            textScaleFactor: 0.8,
            color: Colorz.black255,
            margins: 10,
          ),

          /// NOTE
          SuperText(
            text: 'Recurring billing, Non-refundable\nTerms apply.',
            boxColor: Colorz.black20,
            textHeight: 20,
            boxWidth: _boxWidth - 20,
            font: MojadwelFonts.body,
            textColor: Colorz.black255,
            maxLines: 2,
            lineSpacingFactor: 0.8,
            margins: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
