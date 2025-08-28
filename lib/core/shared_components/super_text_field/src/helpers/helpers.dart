part of super_text_field;

abstract class _Helpers {
  // --------------------
  /// AI TESTED
  static TextDirection? autoSwitchTextDirection({
    required String? val,
    required bool appIsLTR,
  }) {

    // bool _appIsLeftToRight = appIsLeftToRight(context);
    // TextDirection _defaultByLang = _appIsLeftToRight == true ? TextDirection.ltr : TextDirection.rtl;

    /// when val has a value
    if (isEmpty(val) == false) {

      /// first character defines the direction
      final String? _trimmedVal = removeSpacesFromAString(val!.trim());
      final String? _firstCharacter = cutNumberOfCharactersOfAStringBeginning(
        string: _trimmedVal,
        number: 1,
      );

      if (textStartsInEnglish(_firstCharacter)) {
        return TextDirection.ltr;
      }

      else if (textStartsInArabic(_firstCharacter)) {
        return TextDirection.rtl;
      }

      else {
        // _textDirection = _defaultByLang; // can not check app is left to right in initState of SuperTextField
        return TextDirection.ltr; // instead of null
      }

    }

    /// when val is empty
    else {
      // _textDirection = _defaultByLang;
      /// can not check app is left to right in initState of SuperTextField
      return getAppLangTextDirection(
        appIsLTR: appIsLTR,
      ); // instead of null
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection getAppLangTextDirection({
    required bool appIsLTR,
  }) {

    if (appIsLTR == true) {
      return TextDirection.ltr;
    }

    else {
      return TextDirection.rtl;
    }
  }
  // --------------------
  /// AI TESTED
  static bool textStartsInArabic(String? val) {

    if (isEmpty(val) == true){
      return false;
    }
    else {

      /// \p{N} will match any unicode numeric digit.
      // String _reg = r"^[\u0621-\u064A\s\p{N}]+$" ;

      /// To match only ASCII digit use:
      // String _reg = r"^[\u0621-\u064A\s0-9]+$" ;

      /// this gets all arabic and english together
      // String _reg = r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$" ;

      /// others
      // String _reg = r"^[\u0621-\u064A\u0660-\u0669 ]+$";
      // "[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]"

      /// This works for Arabic/Persian even numbers.
      const String _reg = r'^[؀-ۿ]+$';

      final RegExp _exp = RegExp(_reg, multiLine: true);
      // bool isArabic;

      final String? _firstCharacter = cutFirstCharacterAfterRemovingSpacesFromAString(val);

      bool _startInArabic = true;

      if (_firstCharacter == null || _firstCharacter == '') {
        _startInArabic = false;
      } else if (_exp.hasMatch(_firstCharacter) == true) {
        _startInArabic = true;
      } else {
        _startInArabic = false;
      }

      return _startInArabic;
    }
  }
  // --------------------
  /// AI TESTED
  static bool textStartsInEnglish(String? val) {
    const String _reg = r'[a-zA-Z]';
    final RegExp _exp = RegExp(_reg, multiLine: true);
    final String? _firstCharacter = cutFirstCharacterAfterRemovingSpacesFromAString(val);

    bool _startsInEnglish = true;

    if (_firstCharacter == null || _firstCharacter == '') {
      _startsInEnglish = false;
    }

    else if (_exp.hasMatch(_firstCharacter) == true) {
      _startsInEnglish = true;
    }

    else {
      _startsInEnglish = false;
    }

    return _startsInEnglish;
  }
  // --------------------
  /// AI TESTED
  static String? cutFirstCharacterAfterRemovingSpacesFromAString(String? string) {

    if (isEmpty(string) == true){
      return null;
    }

    else {
      final String? _stringWithoutSpaces = removeSpacesFromAString(string?.trim());
      final String? _firstCharacter = cutNumberOfCharactersOfAStringBeginning(
        string: _stringWithoutSpaces,
        number: 1,
      );

      if (_stringWithoutSpaces == null ||
          _stringWithoutSpaces == '' ||
          _stringWithoutSpaces == ' ') {
        return null;
      }

      else if (_firstCharacter == '') {
        return null;
      }

      else {
        return _firstCharacter;
      }

    }

  }
  // --------------------
  /// AI TESTED
  static String? cutNumberOfCharactersOfAStringBeginning({
    required String? string,
    required int? number
  }) {

    if (string == null || string.isEmpty == true || string.trim() == ''){
      return string;
    }
    else if (number == null){
      return string;
    }
    else if (string.length < number){
      return string.substring(0, string.length);
    }

    else {
      return string.substring(0, number);

    }

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius superCorners({
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = cornerAll(corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  // --------------------
  /// AI TESTED
  static TextDirection concludeTextDirection({
    required TextDirection? definedDirection,
    required TextDirection? detectedDirection,
    required bool appIsLTR,
  }) {

    /// when definedDirection is already defined, it overrides all
    if (definedDirection != null) {
      return definedDirection;
    }

    /// when it is not defined outside, and detectedDirection hadn't changed yet we
    /// use default superTextDirection that detects current app language
    else if (detectedDirection == null) {
      return getAppLangTextDirection(
        appIsLTR: appIsLTR,
      );
    }

    /// so otherwise we use detectedDirection that auto detects current input
    /// language
    else {
      return detectedDirection;
    }

  }
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
  static String? removeTextBeforeFirstSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result;

    if (isEmpty(text) == false){

      _result = text;

      final bool _textContainsChar = stringContainsSubString(
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
  // -----------------------------------------------------------------------------
  void x(){}
}
