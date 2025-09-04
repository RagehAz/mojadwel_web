import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/models/bz_model/bz_model.dart';
import 'package:mojadwel_web/core/models/bz_model/bz_protocols.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/services/url_launcher.dart';
import 'package:mojadwel_web/core/shared_components/dialogs/center_dialog.dart';
import 'package:mojadwel_web/core/shared_components/dialogs/keyboard/keyboarder.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';

class DashboardController {
  // --------------------------------------------------------------------------
  VoidCallback? refresh;
  Wire<bool>? mountedWire;
  bool get mounted => mountedWire?.value ?? false;
  // --------------------
  BzModel? bzModel;
  AuthModel? authModel;
  // --------------------------------------------------------------------------
  /// --- LOADING
  final Wire<bool> loading = Wire<bool>(false);
  // --------------------
  Future<void> triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // --------------------------------------------------------------------------
  void init({
    required VoidCallback onSetState,
  }) {
    mountedWire = Wire<bool>(true);
    refresh = onSetState;
  }
  // --------------------
  bool canBuild = false;
  void didChangeDependencies() {

    Routing.waitTheNav();

    if (canBuild == false && mounted == true) {
      triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        final BzModel? _theUser = await BzProtocols.fetch(
          id: OfficialAuthing.getUserID(),
        );
        canBuild = true;
        if (_theUser != null){
          bzModel = _theUser;
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
    blog('Disposing the controller');
    if (mountedWire != null && mounted == true){
      mountedWire?.set(value: false, mounted: true);
      loading.dispose();
      mountedWire?.dispose();
      mountedWire = null;
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

      final BzModel? _bz = await BzProtocols.fetch(
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
        bzModel = _bz;
      }

    }

    authModel = _authModel;
    refresh!();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onCreateAccount() async {

    if (authModel?.id != null){

      final BzModel? _userModel = BzModel(
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
        agentStatus: null,
        accountStatus: null,
      );

      await BzProtocols.compose(model: _userModel);

      bzModel = _userModel;
      refresh!();

    }

  }
  // -----------------------------------------------------------------------------

  /// PLAN SELECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onSelectStarterPlan() async {
    await _onOpenInstapay(
      price: '500 EGP',
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onSelectProPlan() async {
    await _onOpenInstapay(
      price: '2000 EGP',
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onOpenInstapay({
    required String price,
  }) async {

    const String _url = 'https://ipn.eg/S/ragehazzazy/instapay/5sHiEu';

    final bool _go = await Dialogs.confirmProceed(
      headlineVerse: 'Transfer payment by Instapay',
      bodyVerse: 'send $price to\n$_url\n then send the receipt on whatsapp to +201554555107',
      yesVerse: 'Open Instapay',
    );

    if (_go == true){

      await URLLaunching.launchURL(
        url: _url,
      );

      final bool _openWhatsApp = await Dialogs.confirmProceed(
        headlineVerse: 'Open Whatsapp ?',
        bodyVerse: 'If you have completed the transaction, send the receipt to +201554555107',
        yesVerse: 'Open Whatsapp',
      );

      if (_openWhatsApp == true){

        const String number = '201554555107';
        final String message = 'Hello Rageh\nWe have paid the ($price) by instapay for the ai agent subscription, please activate the service to me\n\nAnd I will send you the payment receipt';
        await URLLaunching.launchURL(
          url: 'https://wa.me/$number?text=$message',
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// PROFILE EDITING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onOwnerNameTap() async {

    final String? _name = await Keyboarder.getText(
        context: getTheMainContext(),
        initialText: bzModel?.ownerName,
        hintVerse: 'Owner name',
        headline: 'Owner name'
    );

    final BzModel? _updated = bzModel?.copyWith(
      ownerName: _name,
    );

    await renovateTheModel(_updated);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onBusinessNameTap() async {

    final String? _name = await Keyboarder.getText(
      context: getTheMainContext(),
      initialText: bzModel?.businessName,
      hintVerse: 'Business name',
      headline: 'Business name'
    );

    final BzModel? _updated = bzModel?.copyWith(
      businessName: _name,
    );

    await renovateTheModel(_updated);

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
        initialText: bzModel?.phone,
        hintVerse: '+2 010 0000 0000',
        headline: 'Whats app number'
    );

    final BzModel? _updated = bzModel?.copyWith(
      phone: _phone,
    );

    await renovateTheModel(_updated);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onPlanTileTap({
    required BuildContext context,
  }) async {

    // await Routing.push(
    //   context: context,
    //   screen: (x) => PlanView(
    //     x: x,
    //     controller: this,
    //   ),
    // );

    await Routing.goTo(
      route: Routing.plans,
      // arg: this,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onExtraBzInfoTap() async {

    final String? _phone = await Keyboarder.getParagraph(
        context: getTheMainContext(),
        initialText: bzModel?.extraBzInfo,
        hintVerse: 'Company info',
        headline: 'Company info'
    );

    final BzModel? _updated = bzModel?.copyWith(
      extraBzInfo: _phone,
    );

    await renovateTheModel(_updated);

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
      initialText: bzModel?.aiInstructions,
      hintVerse: 'Ai Instructions',
      headline: 'Ai Instructions',
    );

    final BzModel? _updated = bzModel?.copyWith(
      aiInstructions: _name,
    );

    await renovateTheModel(_updated);

  }
  // --------------------
  Future<void> onProductsTileTap() async {

    // await Routing.push(
    //   context: getTheMainContext(),
    //   screen: (x) => const ProductsScreen(),
    // );

    await Routing.goTo(
      route: Routing.products,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> renovateTheModel(BzModel? newUser) async {

    if (newUser != null){

      final bool _success = await BzProtocols.renovate(
          oldModel: bzModel,
          newModel: newUser
      );

      if (_success == true){
        bzModel = newUser;
        refresh!();
      }
      else {
        await Dialogs.stateDialog(state: false);
      }


    }

  }
  // -----------------------------------------------------------------------------
  void x(){}
}
