import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/red_dot/red_dot_badge.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class ProfileTile extends StatefulWidget {
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

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  // --------------------------------------------------------------------------
  bool loading = false;
  // --------------------
  Future<void> _onTap() async {

    if (widget.onTap != null && mounted == true && loading == false){

      setState(() {
        loading = true;
      });

      await widget.onTap!();

      if (mounted == true){
        setState(() {
          loading = false;
        });
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Function? _theOnTapFunction = widget.onTap == null ? null : _onTap;
    // --------------------
    final double tileWidth = context.screenWidth * 0.7;
    // --------------------
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 30,
      ),
      child: RedDotBadge(
        redDotIsOn: widget.redDot,
        approxChildWidth: tileWidth,
        shrinkChild: true,
        // height: null,
        child: TapLayer(
          width: tileWidth,
          corners: BorderRadius.circular(20),
          boxColor: Colorz.light1,
          height: null,
          onTap: _theOnTapFunction,
          splashColor: Colorz.green255,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ICON
              SuperBox(
                height: 80,
                width: 80,
                icon: widget.icon,
                iconColor: Colorz.black255,
                iconSizeFactor: 0.4,
              ),

              /// TEXTS
              SizedBox(
                width: tileWidth - 80 - 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Spacing(),

                    SuperText(
                      boxWidth: tileWidth - 80,
                      text: widget.headline,
                      textHeight: 17,
                      textColor: Colorz.light3,
                      centered: false,
                    ),

                    SuperText(
                      boxWidth: tileWidth - 80,
                      text: widget.value ?? '...',
                      textHeight: 30,
                      textColor: Colorz.black255,
                      weight: FontWeight.w800,
                      centered: false,
                    ),

                  ],
                ),
              ),

              /// LOADING
              SuperBox(
                height: 80,
                width: 80,
                iconColor: Colorz.dark1,
                iconSizeFactor: 0.8,
                loading: loading,
                // color: Colorz.bloodTest,
              ),

            ],
          ),
        ),
      ),
    );
    // --------------------
  }
}
