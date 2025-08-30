import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/b_dash_board_screen.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class TuneView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TuneView({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return VerticalFloatingList(
      width: context.screenWidth - DashboardScreen.menuWidth,
      height: context.screenHeight,
      boxColor: Colorz.light2,
      children: <Widget>[

        SuperBox(
          height: 100,
          text: 'Settings',
          onTap: (){},
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
