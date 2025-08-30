// ignore_for_file: avoid_catches_without_on_clauses
part of ldb;

abstract class Lister {
  // -----------------------------------------------------------------------------

  /// TITLE

  // --------------------
  /// AI TESTED
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // -----------------------------------------------------------------------------
}

abstract class TextMod {
  // --------------------
  /// AI TESTED
  static String? removeTextBeforeFirstSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result;

    if (TextCheck.isEmpty(text) == false){

      _result = text;

      final bool _textContainsChar = TextCheck.stringContainsSubString(
        string: _result,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {
        final int _position = _result!.indexOf(specialCharacter);
        _result =
        (_position != -1) ? _result.substring(_position + 1, _result.length)
            :
        _result;
      }

    }

    return _result;
  }
  // --------------------
  /// AI TESTED
  static String? removeTextAfterFirstSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result = text;

    if (TextCheck.isEmpty(text) == false){

      final bool _textContainsChar = TextCheck.stringContainsSubString(
        string: text,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {
        _result = text?.substring(0, text.indexOf(specialCharacter));
      }

    }

    return _result;
  }
  // --------------------
  /// AI TESTED
  static String? removeSpacesFromAString(String? string) {
    String? _output;

    if (string != null) {
      /// solution 1,, won't work, not tested
      // string.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      /// solution 2
      // string.replaceAll(new RegExp(r"\s+"), "");
      /// solution 3
      // string.replaceAll(' ', '');
      /// solution 4
      // string.split(" ").join("");
      /// solution 5
      _output = string.replaceAll(' ', '');

      /// solution 6
      /// String replaceWhitespacesUsingRegex(String s, String replace) {
      ///   if (s == null) {
      ///     return null;
      ///   }
      ///
      ///   // This pattern means "at least one space, or more"
      ///   // \\s : space
      ///   // +   : one or more
      ///   final pattern = RegExp('\\s+');
      ///   return s.replaceAll(pattern, replace);
      ///
      /// ---> I'm just going to shortcut the above method here below
      // string?.replaceAll(new RegExp('\\s+'),'');
      _output = _output.replaceAll('‎', '');
      _output = _output.replaceAll('‏', '');
      _output = _output.replaceAll('‎ ', '');
      _output = _output.replaceAll(' ‏', '');
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? replaceAllCharacters({
    required String? characterToReplace,
    required String? replacement,
    required String? input,
  }) {
    if (
    characterToReplace != null &&
        replacement != null &&
        input != null
    ){
      return input.replaceAll(characterToReplace, replacement);
    }
    else {
      return input;
    }

  }
  // --------------------
}

abstract class TextCheck {
  // --------------------
  /// AI TESTED
  static bool stringContainsSubString({
    required String? string,
    required String? subString,
  }) {
    bool _itContainsIt = false;

    if (string != null && subString != null) {
      if (string.toLowerCase().contains(subString.toLowerCase()) == true) {
        _itContainsIt = true;
      }
    }

    return _itContainsIt;
  }
  // --------------------
  /// AI TESTED
  static bool isEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
}

abstract class Numeric {
  // --------------------
  /// AI TESTED
  static int? transformStringToInt(String? string) {
    int? _value;

    if (string != null) {
      final double? _doubleValue = double.tryParse(string);
      _value = _doubleValue?.toInt();
    }

    return _value;
  }
}

abstract class Mapper {
  // --------------------
  /// AI TESTED
  static List<Map<String, dynamic>> cleanMapsOfDuplicateIDs({
    required List<Map<String, dynamic>>? maps,
    required String idFieldName,
  }){
    final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final int _index = _output.indexWhere((m) => m[idFieldName] == map[idFieldName]);

        if (_index == -1){
          _output.add(map);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<String> getMapsPrimaryKeysValues({
    required List<Map<String, dynamic>>? maps,
    String primaryKey = 'id',
    bool throwErrorOnInvalidID = false,
  }){

    final List<String> _primaryKeys = <String>[];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final dynamic _id = map[primaryKey];

        if (_id != null && _id is String){
          _primaryKeys.add(_id);
        }
        else {
          if (throwErrorOnInvalidID == true){
            // assert(_id is String, 'id : $_id is not a String');
            final Error _error = ArgumentError('id : $_id is not a String');
            throw _error;
          }
        }

      }

    }

    return _primaryKeys;
  }
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromDynamics({
    required dynamic dynamics,
  }) {
    final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    if (dynamics != null && dynamics is List){

      final List<dynamic> _list = dynamics;

      if (Lister.checkCanLoop(_list) == true) {
        for (final dynamic object in _list) {
          if (object != null && object is Map){
            final Map<String, dynamic>? _map = jsonDecode(jsonEncode(object));
            if (_map != null){
              _output.add(_map);
            }
          }
        }
      }

    }

    return _output;
  }
}

Future<void> tryAndCatch({
  required Future<void> Function() functions,
  required String invoker,
  ValueChanged<String>? onError,
  int? timeout,
}) async {

  try {

    ///  WITHOUT TIMEOUT
    if (timeout == null) {
      await functions();
    }

    /// WITH TIMEOUT
    else {
      await functions().timeout(
          Duration(seconds: timeout),
          onTimeout: () async {
            if (onError != null){
              onError('Timeout ( $invoker ) after ( $timeout) seconds');
            }
          });
    }


  }
  // on Exception : this does not work on web
  catch (error) {

    if (onError == null){
      blog('$invoker : tryAndCatch ERROR : $error');
    }

    else {
      onError(error.toString());
    }

    // throw(error);
  }

}

void blog(dynamic msg, {String? invoker}){

  assert((){
    if (kDebugMode) {
      debugPrint(msg?.toString());
    }
    return true;
  }(), '_');

}

Future<void> awaiter({
  required bool wait,
  required Function function,
}) async {

  if (wait == true){
    await function();
  }

  else {
    unawaited(function());
  }

}
