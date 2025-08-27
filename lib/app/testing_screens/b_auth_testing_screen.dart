import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/lists/separator_line.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'components/test_button.dart';

class AuthTestingScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const AuthTestingScreen({super.key});

  @override
  State<AuthTestingScreen> createState() => _AuthTestingScreenState();
}

class _AuthTestingScreenState extends State<AuthTestingScreen> {
  // --------------------------------------------------------------------------
  Future<bool> signOutBldrs() async {

    // final bool _success = await OfficialAuthing.signOut(
    //     onError: (String? error) async {
    //       await BldrsCenterDialog.showCenterDialog(
    //         headlineVerse: const Verse(
    //           id: 'phid_trouble_signing_out',
    //           translate: true,
    //         ),
    //         bodyVerse: Verse(
    //           id: error,
    //           translate: false,
    //         ),
    //       );
    //     }
    // );
    //
    // if (_success == true){
    //   UserPro.proSetMyUserModel(userModel: null, notify: true);
    // }

    return OfficialAuthing.signOut();
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: VerticalFloatingList(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        columnChildren: [

          SuperBox(
            height: 50,
            text: 'userID : (${OfficialAuthing.getUserID()})',
          ),

          // --------------------------------------------------------------------------

          /// GOOGLE AUTH
          Column(
            children: <Widget>[

              /// RE-AUTH
              const SuperHeadline(text: 'GOOGLE AUTH'),

              /// AUTH BY GOOGLE
              TestButton(
                text: 'RE-AUTH BY GOOGLE',
                function: () async {
                  // --------------------
                  final bool _signedOut = await signOutBldrs();
                  blog('signedOut($_signedOut)');
                  // --------------------
                  setState(() {});
                  // --------------------
                  final AuthModel? _authModel = await OfficialGoogleAuthing.googleAuth();
                  final bool _authed = _authModel != null;
                  blog('authed($_authed)');
                  // --------------------
                  final String? _accessToken = _authModel?.getGoogleAccessToken();
                  final bool _accessTokenIsGood = _accessToken != null;
                  blog('accessToken($_accessToken)');
                  setState(() {});
                  // --------------------
                  return _signedOut && _authed && _accessTokenIsGood;
                },
                result: (dynamic result) async {
                  return result == true;
                },
              ),

            ],
          ),

          // --------------------------------------------------------------------------

          /// REGISTER
          Column(
            children: <Widget>[

              /// REGISTER
              const SuperHeadline(text: 'Register'),

              /// OfficialAuthing.userHasID
              TestButton(
                text: '4. EmailAuthing userHasID',
                function: () => OfficialAuthing.userHasID(),
                result: (dynamic result) => result == true,
              ),

              /// OfficialAuthing.getUserID
              TestButton(
                text: '5. Authing getUserID',
                function: () => OfficialAuthing.getUserID(),
                result: (dynamic result) => result != null,
              ),

              /// OfficialAuthing.getCurrentSignInMethod - userIsSignedUp
              TestButton(
                text: 'EmailAuthing getCurrentSignInMethod - userIsSignedUp',
                function: () async {

                  final SignInMethod? method = OfficialAuthing.getCurrentSignInMethod();

                  final bool _isSignedUp = OfficialAuthing.userIsSignedUp(method);

                  return _isSignedUp;
                },
                result: (dynamic result) => result == true,
              ),

              /// OfficialAuthing.signOut
              TestButton(
                text: '3. OfficialAuthing.signOut',
                function: () => OfficialAuthing.signOut(),
                result: (dynamic result) {
                  setState(() {});
                  return result == true;
                },
              ),

              /// OfficialAuthing.deleteUser
              TestButton(
                text: 'Authing deleteUser',
                function: () async {

                  final bool _result = await OfficialAuthing.deleteUser();
                  setState(() {});
                  return _result;
                },
                result: (dynamic result) {

                  return result == true;
                },
              ),

            ],
          ),

          // --------------------------------------------------------------------------

          const SeparatorLine(),

          // --------------------------------------------------------------------------



        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
