import 'package:firebase_auth/firebase_auth.dart';
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

    return true;
  }
  // -----------------------------------------------------------------------------
  final String _emailToRegister = 'bro@bldrs.net';
  final String _passwordToRegister = '123456';
  final String _newEmail = 'new_bro@bldrs.com';
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: VerticalFloatingList(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        columnChildren: [

          // --------------------------------------------------------------------------

          /// ANONYMOUS
          Column(
            children: <Widget>[

              /// ANONYMOUS
              const SuperHeadline(text: 'Anonymous'),

              /// OfficialAuthing.anonymousSignin
              TestButton(
                text: '1. Authing anonymousSignin..',
                function: () async {
                  final AuthModel? _authModel = await OfficialAuthing.anonymousSignIn();
                  return _authModel;
                },
                result: (dynamic result) async {
                  // --------------------
                  final AuthModel? _authModel = result;
                  final bool _authModelIsGood = _authModel != null;
                  blog('authModelIsGood($_authModelIsGood)');
                  // --------------------
                  setState(() {});
                  // --------------------
                  final bool _emailIsNull = _authModel?.email == null;
                  blog('emailIsNull($_emailIsNull) : ${_authModel?.email}');
                  // --------------------
                  final bool _isAnonymous = OfficialAuthing.userIsSignedUp(_authModel?.signInMethod) == false;
                  blog('isAnonymous($_isAnonymous)');
                  // --------------------
                  final bool _deleted = await OfficialAuthing.deleteUser();
                  blog('deleted($_deleted)');
                  // --------------------
                  final bool _signedOut = await OfficialAuthing.signOut();
                  blog('signedOut($_signedOut)');
                  // --------------------
                  setState(() {});
                  // --------------------
                  return _authModelIsGood && _emailIsNull && _isAnonymous && _deleted && _signedOut;
                },
              ),

              /// OfficialAuthing.signOut
              TestButton(
                text: '2. Authing signOut',
                function: () => OfficialAuthing.signOut(),
                result: (dynamic result){
                  setState(() {});
                  return result == true && OfficialAuthing.getUserID() == null;
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

              /// PREPARE BEFORE REGISTER
              TestButton(
                text: 'Prepare before register',
                addNotes: [
                  'this will sign in ($_emailToRegister) then delete that account so to register from scratch in the next test',
                ],
                function: () async {

                  String? _status;

                  final AuthModel? _authModel = await OfficialEmailAuthing.signIn(
                      email: _emailToRegister,
                      password: _passwordToRegister
                  );

                  setState(() {});

                  if (_authModel != null){
                    final bool _deleted = await OfficialAuthing.deleteUser();

                    _status = _deleted ? 'ready' : 'not deleted';
                  }
                  else {
                    _status = 'ready';
                  }

                  return _status;
                },
                result: (dynamic result) async {
                  setState(() {});
                  return result == 'ready';
                },
              ),

              /// OfficialEmailAuthing.register
              TestButton(
                text: '3. OfficialEmailAuthing.register',
                addNotes: [
                  'will use ($_emailToRegister) and password ($_passwordToRegister)',
                ],
                function: () async {

                  blog('starting register or sign in ---------- > .. ');
                  blog('Registering with email: $_emailToRegister');
                  blog('and password: $_passwordToRegister');

                  final AuthModel? _authModel = await OfficialEmailAuthing.register(
                    autoSendVerificationEmail: true,
                    email: _emailToRegister,
                    password: _passwordToRegister,
                  );


                  return _authModel;
                },
                result: (dynamic result) async{
                  setState(() {});
                  final AuthModel? _registered = result;
                  final bool _registeredIsGood = _registered != null;
                  blog('registered is good : $_registeredIsGood');
                  // --------------------
                  final AuthModel? _signed = await OfficialEmailAuthing.signIn(
                      email: _emailToRegister,
                      password: _passwordToRegister
                  );
                  final bool _signedIsGood = _signed != null;
                  blog('signed is good : $_signedIsGood : signed user ID (${_signed?.id})');
                  // --------------------
                  final bool authsAreIdentical = AuthModel.checkAuthModelsAreIdentical(
                    auth1: _registered,
                    auth2: _signed,
                  );
                  blog('auths are identical : $authsAreIdentical');
                  // --------------------
                  setState(() {});
                  // --------------------
                  return _registeredIsGood && _signedIsGood && authsAreIdentical;
                },
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

              /// OfficialEmailAuthing.signIn
              TestButton(
                text: '3. OfficialEmailAuthing.signIn',
                addNotes: [
                  'will use ($_emailToRegister) and password ($_passwordToRegister)',
                ],
                function: () async {

                  final AuthModel? _authModel = await OfficialEmailAuthing.signIn(
                      email: _emailToRegister,
                      password: _passwordToRegister
                  );

                  return _authModel;
                },
                result: (dynamic result) async{
                  setState(() {});
                  final AuthModel? _authModel = result;
                  final bool _signedIsGood = _authModel != null;
                  blog('_authModel is good : $_signedIsGood');
                  // --------------------
                  return _signedIsGood;
                },
              ),

              /// OfficialEmailAuthing.checkPasswordIsCorrect (with original email and password)
              TestButton(
                text: '4. EmailAuthing checkPasswordIsCorrect (with original email and password)',
                addNotes: [
                  'will use ($_emailToRegister) and password ($_passwordToRegister)',
                ],
                function: () => OfficialEmailAuthing.checkPasswordIsCorrect(
                  email: _emailToRegister,
                  password: _passwordToRegister,

                ),
                result: (dynamic result){
                  return result == true;
                },
              ),

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

          /// RE-AUTH
          Column(
            children: <Widget>[

              /// RE-AUTH
              const SuperHeadline(text: 'RE-AUTH'),

              /// REAUTH BY EMAIL
              // TestButton(
              //   text: 'RE-AUTH BY EMAIL',
              //   function: () async {
              //     // --------------------
              //     final bool _signedOut = await SpawningProtocols.signOutBldrs();
              //     blog('signedOut($_signedOut)');
              //     // --------------------
              //     setState(() {});
              //     // --------------------
              //     const String _email = 'powerful@bldrs.net';
              //     const String _password = '123456';
              //     final AuthModel? _authModel = await AuthProtocols.composeByEmail(email: _email, password: _password, onError: null);
              //     final bool _authed = _authModel != null;
              //     blog('authed($_authed)');
              //     // --------------------
              //     setState(() {});
              //     // --------------------
              //     final AuthModel? _signed = await UserAuthOps.readByEmail(email: _email, password: _password, onError: null);
              //     final bool _signedIsGood = _signed != null;
              //     blog('signedIsGood($_signedIsGood)');
              //     // --------------------
              //     final FirebaseAuth? _firebaseAuth = OfficialFirebase.getAuth();
              //     final User? _firebaseUser = _firebaseAuth?.currentUser;
              //     final UserCredential? _cred =  await _firebaseUser?.reauthenticateWithCredential(EmailAuthProvider.credential(
              //       email: _email,
              //       password: _password,
              //     ));
              //     final bool _credIsGood = _cred != null;
              //     blog('credIsGood($_credIsGood)');
              //     // --------------------
              //     final AuthModel? _reAuthModel = OfficialModelling.getAuthModelFromOfficialUserCredential(
              //       cred: _cred,
              //     );
              //     final bool _reAuthed = _reAuthModel != null;
              //     blog('reAuthed($_reAuthed)');
              //     // --------------------
              //     // final bool _reAuthed = await OfficialAuthing.reAuth(
              //     //   doStuffBetweenReAuthing: () async {
              //     //
              //     //     blog('Doing the stuff in between');
              //     //
              //     //   },
              //     // );
              //     // blog('reAuthed($_reAuthed)');
              //     // --------------------
              //     final bool _deleted = await AuthProtocols.wipeByEmail(email: _email, password: _password, onError: null);
              //     blog('deleted($_deleted)');
              //     // --------------------
              //     setState(() {});
              //     // --------------------
              //     return _signedOut && _authed && _signedIsGood && _reAuthed && _deleted && _credIsGood;
              //   },
              //   result: (dynamic result) async {
              //     return result == true;
              //   },
              // ),

              /// REAUTH BY GOOGLE
              TestButton(
                text: 'RE-AUTH BY GOOGLE',
                function: () async {
                  // --------------------
                  final bool _signedOut = await signOutBldrs();
                  blog('signedOut($_signedOut)');
                  // --------------------
                  setState(() {});
                  // --------------------
                  final AuthModel? _authModel = await OfficialGoogleAuthing.emailSignIn();
                  final bool _authed = _authModel != null;
                  blog('authed($_authed)');
                  // --------------------
                  setState(() {});
                  // --------------------
                  final FirebaseAuth? _firebaseAuth = OfficialFirebase.getAuth();
                  final AuthCredential _authCredential = GoogleAuthProvider.credential(
                    accessToken: _authModel?.data?['googleSignInAuthentication.accessToken'],
                    idToken: _authModel?.data?['googleSignInAuthentication.idToken'],
                  );
                  final UserCredential? _userCredential = await _firebaseAuth?.signInWithCredential(_authCredential);
                  final AuthModel? _signed = OfficialModelling.getAuthModelFromOfficialUserCredential(
                    cred: _userCredential,
                    addData: _authModel?.data,
                  );
                  final bool _signedIsGood = _signed != null;
                  blog('signedIsGood($_signedIsGood)');
                  // --------------------
                  final User? _firebaseUser = _firebaseAuth?.currentUser;
                  final UserCredential? _cred =  await _firebaseUser?.reauthenticateWithCredential(_authCredential);
                  final bool _credIsGood = _cred != null;
                  blog('credIsGood($_credIsGood)');
                  // --------------------
                  final AuthModel? _reAuthModel = OfficialModelling.getAuthModelFromOfficialUserCredential(
                    cred: _cred,
                  );
                  final bool _reAuthed = _reAuthModel != null;
                  blog('reAuthed($_reAuthed)');
                  // --------------------
                  // final bool _reAuthed = await OfficialAuthing.reAuth(
                  //   doStuffBetweenReAuthing: () async {
                  //
                  //     blog('Doing the stuff in between');
                  //
                  //   },
                  // );
                  // blog('reAuthed($_reAuthed)');
                  // --------------------
                  final bool _signedOut2 = await signOutBldrs();
                  blog('_signedOut2($_signedOut2)');
                  // --------------------
                  // setState(() {});
                  // --------------------
                  return _signedOut && _authed && _signedIsGood && _reAuthed && _signedOut2 && _credIsGood;
                },
                result: (dynamic result) async {
                  return result == true;
                },
              ),

            ],
          ),

          // --------------------------------------------------------------------------

          /// UPDATE_EMAIL_TASK
          Disabler(
            isDisabled: true,
            disabledOpacity: 0.3,
            child: Column(
              children: [

                /// EMAIL CHANGE
                const SuperHeadline(text: 'Email Change'),

                /// OfficialEmailAuthing.updateUserEmail
                TestButton(
                  text: '5. EmailAuthing updateUserEmail',
                  addNotes: [
                    'This method is not supported in Native class plugin',
                    'will change old email\n(${OfficialAuthing.getAuthEmail()})\nto\n($_newEmail)',
                  ],
                  function: () async {

                    bool _result = await OfficialEmailAuthing.updateUserEmail(
                      newEmail: _newEmail,
                    );

                    if (_result == false){
                      final AuthModel? _authModel = await OfficialEmailAuthing.signIn(
                          email: _emailToRegister,
                          password: _passwordToRegister
                      );
                      if (_authModel != null){
                        _result = await OfficialEmailAuthing.updateUserEmail(
                          newEmail: _newEmail,
                        );
                      }
                    }

                    setState(() {});

                    return _result;
                  },
                  result: (dynamic result){

                    return result == true;

                  },

                ),

                /// OfficialAuthing.signOut
                TestButton(
                  text: '6. Authing signOut',
                  function: () => OfficialAuthing.signOut(),
                  result: (dynamic result) => result == true,
                ),

                /// OfficialEmailAuthing.signIn ( with new email )
                TestButton(
                  text: '7. EmailAuthing signIn ( with new email )',
                  function: (){

                    return OfficialEmailAuthing.signIn(
                      password: _passwordToRegister,
                      email: _newEmail,
                    );

                  },
                  result: (dynamic result) => result != null,
                ),

                /// OfficialAuthing.userIsSignedIn
                TestButton(
                  text: '8. EmailAuthing userHasID',
                  function: () => OfficialAuthing.userHasID(),
                  result: (dynamic result) => result == true,
                ),

              ],
            ),
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
