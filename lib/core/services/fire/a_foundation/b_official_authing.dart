part of super_fire;

/// => TAMAM
abstract class OfficialAuthing {
  // -----------------------------------------------------------------------------

  /// USER ID

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getUserID() {
    return getUser()?.uid;
  }
  // -----------------------------------------------------------------------------

  /// ANONYMOUS AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel?> anonymousSignIn({
    Function(String? error)? onError,
  }) async {
    AuthModel? _output;

    await tryAndCatch(
      invoker: 'OfficialAuthing.anonymousSignin',
      onError: onError,
      functions: () async {

        final f_a.UserCredential? _userCredential = await OfficialFirebase
            .getAuth()?.signInAnonymously();

        _output = OfficialModelling.getAuthModelFromOfficialUserCredential(
            cred: _userCredential,
        );

      },
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signOut({
    Function(String? error)? onError,
  }) async {

    final bool _success = await tryCatchAndReturnBool(
      invoker: 'OfficialAuthing.signOut',
      onError: onError,
      functions: () async {
        // final SignInMethod? signInMethod = getCurrentSignInMethod();

        /// GOOGLE SIGN OUT
        // if (signInMethod == SignInMethod.google) {
        //     final GoogleSignIn _instance = OfficialGoogleAuthing.getGoogleSignInInstance();
        //     await _instance.disconnect();
        //     await _instance.signOut();
        // }

        /// FIREBASE SIGN OUT
        await OfficialFirebase.getAuth()?.signOut();
      },
    );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// DELETE USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteUser({
    Function(String? error)? onError,
  }) async {


    final bool _success = await tryCatchAndReturnBool(
        invoker: 'Official.deleteFirebaseUser',
        functions: () async {
          await OfficialFirebase.getAuth()?.currentUser?.delete();
        },
        onError: onError,
    );

    return _success;

  }
  // -----------------------------------------------------------------------------

  /// SIGN IN METHOD

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool userHasID() {
    return getUser() != null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod? getCurrentSignInMethod(){
    return _getSignInMethodFromUser(user: OfficialAuthing.getUser());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod? _getSignInMethodFromUser({
    required f_a.User? user,
  }){
    SignInMethod? _output;

    if (user != null){

      final List<f_a.UserInfo> providerData = user.providerData;

      if (checkCanLoop(providerData) == true){
        final f_a.UserInfo _info = providerData.first;
        final String? providerID = _info.providerId;
        _output = AuthModel.decipherSignInMethod(
          providerID: providerID,
          userID: getUserID(),
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  
  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsSocialSignInMethod(SignInMethod? method){
    switch (method){
      case SignInMethod.anonymous: return false;
      case SignInMethod.password:  return false;
      case SignInMethod.google:    return true;
      case SignInMethod.facebook:  return true;
      case SignInMethod.apple:     return true;
      default: return false;
    }
  }
  /// TESTED : WORKS PERFECT
  static bool userIsSignedUp(SignInMethod? method){

    if (
    method == null ||
        method == SignInMethod.anonymous
    ){
      return false;
    }
    else {
      return true;
    }

  }
  // -----------------------------------------------------------------------------

  /// USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static f_a.User? getUser() {
    return OfficialFirebase.getAuth()?.currentUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getAuthEmail(){
    return getUser()?.email;
  }
  // --------------------
  /// TASK : TEST ME
  static DateTime? getLastSignIn(){
    return getUser()?.metadata.lastSignInTime;
  }
  // -----------------------------------------------------------------------------
}

/// => TAMAM
class OfficialGoogleAuthing {
  // --------------------
  OfficialGoogleAuthing.singleton();
  static final OfficialGoogleAuthing _singleton = OfficialGoogleAuthing.singleton();
  static OfficialGoogleAuthing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// GOOGLE AUTH PROVIDER SINGLETON

  // --------------------
  f_a.GoogleAuthProvider? _googleAuthProvider;
  f_a.GoogleAuthProvider get googleAuthProvider => _googleAuthProvider ??=  f_a.GoogleAuthProvider();
  static f_a.GoogleAuthProvider getGoogleAuthProviderInstance() => OfficialGoogleAuthing.instance.googleAuthProvider;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel?> googleAuth() async {
    AuthModel? _output;

    await tryAndCatch(
      invoker: 'webGoogleAuth',
      functions: () async {
        final provider = f_a.GoogleAuthProvider();
        const List<String> scopes = [
          'https://www.googleapis.com/auth/calendar',
          'https://www.googleapis.com/auth/calendar.events',
          'https://www.googleapis.com/auth/spreadsheets',
        ];
        scopes.forEach(provider.addScope);
        final f_a.FirebaseAuth? _firebaseAuth = OfficialFirebase.getAuth();
        final f_a.UserCredential? _userCredential = await _firebaseAuth?.signInWithPopup(provider);
        _output = OfficialModelling.getAuthModelFromOfficialUserCredential(
          cred: _userCredential,
        );
      },
    );

    return _output;
  }
  // -----------------------------------------------------------------------------
}

/// => TAMAM
abstract class OfficialAuthBlog {
  // -----------------------------------------------------------------------------

  /// FIREBASE

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogUserCredential({
    required f_a.UserCredential? cred,
  }){

    if (cred == null){
      blog('blogUserCredential : USER CREDENTIAL IS NULL');
    }

    else {
      blog('USER CREDENTIAL :----> ');
      blog('credential.user.displayName : ${cred.user?.displayName}');
      blog('credential.user.email : ${cred.user?.email}');
      blog('credential.user.emailVerified : ${cred.user?.emailVerified}');
      blog('credential.user.isAnonymous : ${cred.user?.isAnonymous}');
      blog('credential.user.metadata : ${cred.user?.metadata}');
      blog('credential.user.phoneNumber : ${cred.user?.phoneNumber}');
      blog('credential.user.photoURL : ${cred.user?.photoURL}');
      blog('credential.user.providerData : ${cred.user?.providerData}');
      blog('credential.user.refreshToken : ${cred.user?.refreshToken}');
      blog('credential.user.tenantId : ${cred.user?.tenantId}');
      blog('credential.user.uid : ${cred.user?.uid}');
      blog('credential.user.multiFactor : ${cred.user?.multiFactor}');
      blog('CREDENTIAL :-');
      blog('credential.credential.accessToken : ${cred.credential?.accessToken}');
      blog('credential.credential.providerId : ${cred.credential?.providerId}');
      blog('credential.credential.signInMethod : ${cred.credential?.signInMethod}');
      blog('credential.credential.token : ${cred.credential?.token}');
      blog('ADDITIONAL USER INFO :-');
      blog('credential.additionalUserInfo.providerId : ${cred.additionalUserInfo?.providerId}');
      blog('credential.additionalUserInfo.isNewUser : ${cred.additionalUserInfo?.isNewUser}');
      blog('credential.additionalUserInfo.profile : ${cred.additionalUserInfo?.profile}');
      blog('credential.additionalUserInfo.username : ${cred.additionalUserInfo?.username}');
      blog('blogUserCredential : USER CREDENTIAL BLOG END <-----');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogOfficialFirebaseUser({
    required f_a.User? user,
  }){

    if (user == null){
      blog('blogUserCredential : FIRE BASE USER IS NULL');
    }

    else {
      blog('FIRE BASE USER :----> ');
      blog('credential.user.displayName : ${user.displayName}');
      blog('credential.user.email : ${user.email}');
      blog('credential.user.emailVerified : ${user.emailVerified}');
      blog('credential.user.isAnonymous : ${user.isAnonymous}');
      blog('credential.user.metadata : ${user.metadata}');
      blog('credential.user.phoneNumber : ${user.phoneNumber}');
      blog('credential.user.photoURL : ${user.photoURL}');
      blog('credential.user.providerData : ${user.providerData}');
      blog('credential.user.refreshToken : ${user.refreshToken}');
      blog('credential.user.tenantId : ${user.tenantId}');
      blog('credential.user.uid : ${user.uid}');
      blog('credential.user.multiFactor : ${user.multiFactor}');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCurrentOfficialFirebaseUser(){

    final f_a.User ?_user = OfficialAuthing.getUser();

    if (_user == null){
      blog('blogCurrentFirebaseUser : user is null');
    }
    else {
      blogOfficialFirebaseUser(user: _user);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogAuthCred(f_a.AuthCredential? authCred){

    if (authCred == null){
      blog('blogAuthCred : AUTH CREDENTIAL IS NULL');
    }

    else {
      blog('AUTH CREDENTIAL :----> ');
      blog('authCred.signInMethod : ${authCred.signInMethod}');
      blog('authCred.providerId : ${authCred.providerId}');
      blog('authCred.accessToken : ${authCred.accessToken}');
      blog('authCred.token : ${authCred.token}');

    }

  }
// -----------------------------------------------------------------------------
}
