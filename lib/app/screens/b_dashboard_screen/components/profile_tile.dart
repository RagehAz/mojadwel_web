import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/red_dot/red_dot_badge.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class ProfileTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ProfileTile({
    required this.headline,
    required this.value,
    required this.icon,
    required this.redDot,
    this.onTap,
    super.key
  });
  // --------------------
  final String headline;
  final String? value;
  final dynamic icon;
  final Function? onTap;
  final bool redDot;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// --------------------
    final double tileWidth = context.screenWidth * 0.7;
    // --------------------
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SuperText(
          text: headline,
          textHeight: 20,
          margins: const EdgeInsets.only(
            top: 10,
            left: 30+80,
          ),
          textColor: Colorz.light3,
        ),

        RedDotBadge(
          redDotIsOn: redDot,
          approxChildWidth: tileWidth,
          shrinkChild: true,
          height: 80,
          child: SuperBox(
            height: 80,
            width: tileWidth,
            text: value ?? '...',
            icon: icon,
            iconColor: Colorz.black255,
            iconSizeFactor: 0.5,
            color: Colorz.light1,
            textCentered: false,
            textColor: Colorz.black255,
            margins: const EdgeInsets.only(
              bottom: 10,
              left: 30,
            ),
            onTap: onTap,
          ),
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
