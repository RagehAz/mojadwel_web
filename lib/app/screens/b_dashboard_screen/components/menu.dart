import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/b_dash_board_screen.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/menu_button.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';

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
      height: (DashboardScreen.menuButtonSize + 10) * 3,
      boxAlignment: Alignment.topCenter,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        MenuButton(
          size: DashboardScreen.menuButtonSize,
          text: 'Profile',
          icon: Iconz.brain,
          isSelected: selectedView == DashboardView.profile,
          onTap: () => onSelected(DashboardView.profile),
        ),

        MenuButton(
          size: DashboardScreen.menuButtonSize,
          text: 'Plan',
          icon: Iconz.plan,
          isSelected: selectedView == DashboardView.plan,
          onTap: () => onSelected(DashboardView.plan),
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
