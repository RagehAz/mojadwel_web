import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/controllers/dashboard_controller.dart';
import 'package:provider/provider.dart';

class DashPro extends ChangeNotifier {
  // -----------------------------------------------------------------------------
  static DashPro getPro({
    BuildContext? context,
    bool listen = false,
  }){
    final DashPro _pro = Provider.of<DashPro>(context ?? getTheMainContext(), listen: listen);
    return _pro;
  }
  // --------------------
  static DashPro livePro(BuildContext context){
    return getPro(context: context, listen: true);
  }
  // --------------------
  static void notifyNow({
    bool notify = true,
  }){
    if (notify == true){
      getPro().notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// DARK MODE

  // --------------------
  final DashboardController _controller = DashboardController();
  DashboardController get controller => _controller;
  // --------------------
  static DashboardController getController({
    BuildContext? context,
    bool listen = false,
  }){
    final DashPro _pro = getPro(context: context, listen: listen);
    return _pro._controller;
  }
  // --------------------------------------------------------------------------
}
