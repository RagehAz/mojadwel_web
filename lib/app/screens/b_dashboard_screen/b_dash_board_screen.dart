import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/menu.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/controllers/dashboard_controller.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/views/a_profile_view.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/views/b_plan_view.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

enum DashboardView {
  profile,
  plan,
}

class DashboardScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const DashboardScreen({
    super.key
  });
  // --------------------
  // --------------------
  static const double menuWidth = 90;
  static const double menuButtonSize = menuWidth - 10;
  // --------------------
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
  // --------------------------------------------------------------------------
}

class _DashboardScreenState extends State<DashboardScreen> {
  // --------------------------------------------------------------------------
  DashboardController controller = DashboardController();
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    controller.init(
      onSetState: onSetState,
    );
  }
  // --------------------
  void onSetState(){
    if (mounted){
      setState((){});
    }
  }
  // --------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final DashboardView _view = controller.selectedView;
    // --------------------
    return TheLayout(
      child: (double bodyWidth) => SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// LEFT MENU
            DashBoardMenu(
              selectedView: _view,
              onSelected: controller.setView,
            ),


            if (_view == DashboardView.profile)
              ProfileView(controller: controller),

            if (_view == DashboardView.plan)
              PlanView(controller: controller),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
