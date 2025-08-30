import 'dart:ui';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/b_dash_board_screen.dart';
import 'package:mojadwel_web/core/models/bz_model/user_fire_ops.dart';
import 'package:mojadwel_web/core/models/bz_model/bz_model.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';

class DashboardController {
  // --------------------------------------------------------------------------
  VoidCallback? refresh;
  final Wire<bool> mounted = Wire<bool>(true);
  // --------------------
  DashboardView selectedView = DashboardView.profile;
  // --------------------
  UserModel? userModel;
  AuthModel? authModel;
  // --------------------------------------------------------------------------
  /// --- LOADING
  final Wire<bool> loading = Wire<bool>(false);
  // --------------------
  Future<void> triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: loading,
      mounted: mounted.value,
      value: setTo,
    );
  }
  // --------------------------------------------------------------------------
  void init({
    required VoidCallback onSetState,
  }) {
    refresh = onSetState;
  }
  // --------------------
  bool canBuild = false;
  void didChangeDependencies() {

    Routing.waitTheNav();

    if (canBuild == false && mounted.value == true) {
      triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        final UserModel? _theUser = await UserProtocols.fetch(
          id: OfficialAuthing.getUserID(),
        );
        canBuild = true;
        if (_theUser != null){
          userModel = _theUser;
          authModel = _theUser.authModel;
        }
        refresh!();
        // -----------------------------
        await triggerLoading(setTo: false);
      });

    }

  }
  // --------------------
  void dispose() {
    mounted.set(value: false, mounted: true);
    loading.dispose();
    mounted.dispose();
  }
  // -----------------------------------------------------------------------------

  /// VIEW

  // --------------------
  /// TESTED : WORKS PERFECT
  void setView(DashboardView view){
    if (mounted.value){
      selectedView = view;
      refresh!();
    }
  }
  // -----------------------------------------------------------------------------

  /// AUTH

  // --------------------
  /// COMPLETE_ME
  Future<void> onGoogleAuth() async {

    final AuthModel? _authModel = await OfficialGoogleAuthing.googleAuth();

    if (_authModel == null){
      /// ADD_TOP_DIALOG
      blog('Failed to auth');
    }
    else {

      final UserModel? _bz = await UserProtocols.fetch(
        id: _authModel.id,
      );

      if (_bz == null){
        /// ADD_TOP_DIALOG
        blog('NO_BZ_FOUND_FOR_(${_authModel.id})');
        AuthModel.blogAuthModel(authModel: _authModel);
      }

      else {
        userModel = _bz;
      }

    }

    authModel = _authModel;
    refresh!();

  }
  // --------------------
  ///
  Future<void> onCreateAccount() async {

    if (authModel?.id != null){

      final UserModel? _userModel = UserModel(
        id: authModel!.id!,
        createdAt: DateTime.now(),
        ownerName: authModel!.name,
        email: authModel!.email,
        phone: authModel!.phone,
        plan: 'free',
        businessName: null,
        trialEndsAt: null,
        authModel: authModel,
      );

      await UserProtocols.compose(model: _userModel);

      userModel = _userModel;
      refresh!();

    }

  }
  // -----------------------------------------------------------------------------

  /// AUTH

  // --------------------
  Future<void> onSelectStarterPlan() async {
    blog('onSelectStarterPlan : start');
  }
  // --------------------
  Future<void> onSelectProPlan() async {
    blog('onSelectProPlan : haa');
  }
  // -----------------------------------------------------------------------------
  void x(){}
}
