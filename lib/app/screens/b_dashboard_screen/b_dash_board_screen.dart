import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/menu.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/views/profile_view.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/views/settings_view.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/shared_components/bubble/bubble.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';

enum DashboardView {
  profile,
  setting,
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
  DashboardView _view = DashboardView.profile;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
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
    _loading.dispose();
    super.dispose();
  }
  // ---------------------------------------------------------------------------

  /// VIEW

  // --------------------
  void setView(DashboardView view){
    if (mounted){
      setState(() {
        _view = view;
      });
    }
  }
  // --------------------
  Widget _buildView(){

    switch(_view){
      case DashboardView.profile: return const ProfileView();
      case DashboardView.setting: return const SettingsView();
    }
  }
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    // --------------------
    return TheLayout(
      child: (double bodyWidth) => Container(
        width: context.screenWidth,
        height: context.screenHeight,
        color: Colorz.bloodTest,
        child: Row(
          children: <Widget>[

            /// LEFT MENU
            DashBoardMenu(
              selectedView: _view,
              onSelected: setView,
            ),

            /// PAGE
            _buildView(),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
