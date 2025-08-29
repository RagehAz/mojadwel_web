import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/b_dash_board_screen.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/menu_button.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class DashBoardMenu extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DashBoardMenu({
    required this.selectedView,
    required this.onSelected,
    super.key
  });
  // --------------------
  final DashboardView selectedView;
  final Function(DashboardView view) onSelected;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return VerticalFloatingList(
      width: DashboardScreen.menuWidth,
      height: context.screenHeight,
      boxColor: Colorz.light1,
      boxAlignment: Alignment.topCenter,
      children: [

        MenuButton(
          size: DashboardScreen.menuButtonSize,
          text: 'Profile',
          icon: Iconz.star,
          isSelected: selectedView == DashboardView.profile,
          onTap: () => onSelected(DashboardView.profile),
        ),

        MenuButton(
          size: DashboardScreen.menuButtonSize,
          text: 'Settings',
          icon: Iconz.star,
          isSelected: selectedView == DashboardView.setting,
          onTap: () => onSelected(DashboardView.setting),
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
