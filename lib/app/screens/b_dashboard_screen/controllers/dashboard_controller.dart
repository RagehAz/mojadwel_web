import 'dart:ui';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/b_dash_board_screen.dart';
import 'package:mojadwel_web/core/models/bz_model/user_protocols.dart';
import 'package:mojadwel_web/core/models/bz_model/user_model.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/dialogs/center_dialog.dart';
import 'package:mojadwel_web/core/shared_components/dialogs/keyboard/keyboarder.dart';
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
  /// TESTED : WORKS PERFECT
  Future<void> onGoogleAuth() async {

    final AuthModel? _authModel = await OfficialGoogleAuthing.googleAuth();

    if (_authModel == null){
      await Dialogs.stateDialog(
        state: false,
        failVerse: 'Failed to sign in',
        body: 'Please try again',
      );
    }
    else {

      final UserModel? _bz = await UserProtocols.fetch(
        id: _authModel.id,
      );

      if (_bz == null){
        AuthModel.blogAuthModel(authModel: _authModel);
        await Dialogs.stateDialog(
          state: false,
          failVerse: 'Account is not found',
          body: '[${_authModel.name}] no record has been found in the database',
        );
      }

      else {
        userModel = _bz;
      }

    }

    authModel = _authModel;
    refresh!();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
        extraBzInfo: null,
        aiInstructions: null,
        products: null,
      );

      await UserProtocols.compose(model: _userModel);

      userModel = _userModel;
      refresh!();

    }

  }
  // -----------------------------------------------------------------------------

  /// PLAN SELECTION

  // --------------------
  Future<void> onSelectStarterPlan() async {
    blog('onSelectStarterPlan : start');
  }
  // --------------------
  Future<void> onSelectProPlan() async {
    blog('onSelectProPlan : haa');
  }
  // -----------------------------------------------------------------------------

  /// PROFILE EDITING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onOwnerNameTap() async {

    final String? _name = await Keyboarder.getText(
      context: getTheMainContext(),
      initialText: userModel?.ownerName,
      hintVerse: 'Owner name',
    );

    final UserModel? _updated = userModel?.copyWith(
      ownerName: _name,
    );

    await _renovateTheModel(_updated);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onBusinessNameTap() async {

    final String? _name = await Keyboarder.getText(
      context: getTheMainContext(),
      initialText: userModel?.businessName,
      hintVerse: 'Business name',
    );

    final UserModel? _updated = userModel?.copyWith(
      businessName: _name,
    );

    await _renovateTheModel(_updated);

  }
  // --------------------
  /// CANCELLED
  // Future<void> onEmailTap() async {
  //   // blog('should change email');
  // }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onPhoneTap() async {

    final String? _phone = await Keyboarder.getText(
      context: getTheMainContext(),
      initialText: userModel?.phone,
      hintVerse: '+2 010 0000 0000',
    );

    final UserModel? _updated = userModel?.copyWith(
      phone: _phone,
    );

    await _renovateTheModel(_updated);

  }
  // --------------------
  /// DO_MULTI_BUTTON_SELECTOR_DIALOG
  Future<void> onPlanTileTap() async {
    blog('should change plan');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onExtraBzInfoTap() async {

    final String? _phone = await Keyboarder.getParagraph(
      context: getTheMainContext(),
      initialText: userModel?.extraBzInfo,
      hintVerse: 'Company info',
    );

    final UserModel? _updated = userModel?.copyWith(
      extraBzInfo: _phone,
    );

    await _renovateTheModel(_updated);

  }
  // --------------------
  /// DO_ME
  Future<void> onSheetsTileTap() async {
    blog('should change sheets');
  }
  // --------------------
  /// DO_ME
  Future<void> onCalendarTileTap() async {
    blog('should change calendar');
  }
  // --------------------
  /// DO_MULTI_BUTTON_SELECTOR_DIALOG
  Future<void> onRemindersTileTap() async {
    blog('should change reminders');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onAiInstructionsTap() async {

    final String? _name = await Keyboarder.getText(
      context: getTheMainContext(),
      initialText: userModel?.aiInstructions,
      hintVerse: 'Ai Instructions',
    );

    final UserModel? _updated = userModel?.copyWith(
      aiInstructions: _name,
    );

    await _renovateTheModel(_updated);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _renovateTheModel(UserModel? newUser) async {

    if (newUser != null){

      await UserProtocols.renovate(
          oldModel: userModel,
          newModel: newUser
      );

      userModel = newUser;
      refresh!();

    }

  }
  // -----------------------------------------------------------------------------
  void x(){}
}
