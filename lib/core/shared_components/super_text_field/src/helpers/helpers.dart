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

abstract class Scale {
  // -----------------------------------------------------------------------------

  /// APP BAR

  // --------------------
  static const double appBarHeight = 50;
  static const double popUpButtonWidth = 250;
  static const double popUpButtonSideMargin = 10;
  static const double popUpSeparatorWidth = popUpButtonWidth + popUpButtonSideMargin + popUpButtonSideMargin;
  // -----------------------------------------------------------------------------

  /// BODY

  // --------------------
  static const double marginValue = 10;
  static const double bothMarginsValue = marginValue * 2;
  // --------------------
  ///
  static double bodyWidth(BuildContext context){
    return Scale.responsive(
      context: context,
      landscape: Scale.screenShortestSide(context) - bothMarginsValue,
      portrait: Scale.screenWidth(context) - bothMarginsValue,
    );
  }
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenWidth(BuildContext context) {
    return context.mounted == true ? MediaQuery.sizeOf(context).width : 0;
    // return MediaQuery.of(context).size.width;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenHeight(BuildContext context) {

    // print('screenHeight : top(${MediaQuery.paddingOf(context).top}) bottom(${MediaQuery.paddingOf(context).bottom})');

    if (context.mounted == true){
      return    MediaQuery.sizeOf(context).height
          - MediaQuery.paddingOf(context).top
          - MediaQuery.paddingOf(context).bottom;
    }

    else {
      return 0;
    }

    // return    MediaQuery.of(context).size.height
    //         - MediaQuery.of(context).padding.top
    //         - MediaQuery.of(context).padding.bottom;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenHeightGross(BuildContext context) {
    return context.mounted == true ? MediaQuery.sizeOf(context).height : 0;
    // return MediaQuery.of(context).size.height;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static double superScreenHeightWithoutSafeArea(BuildContext context) {
    return screenHeight(context) - superSafeAreaTopPadding(context);
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenShortestSide(BuildContext context){

    if (context.mounted == true){
      final bool _isLandscape = isLandScape(context);

      if (_isLandscape == true) {
        return MediaQuery.sizeOf(context).height;
        // return MediaQuery.of(context).size.height;
      }

      else {
        return MediaQuery.sizeOf(context).width;
        // return MediaQuery.of(context).size.width;
      }

    }

    else {
      return 0;
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenLongestSide(BuildContext context){

    if (context.mounted == true){
      final bool _isLandscape = isLandScape(context);

      if (_isLandscape == true) {
        return MediaQuery.sizeOf(context).width;
        // return MediaQuery.of(context).size.width;
      }

      else {
        return MediaQuery.sizeOf(context).height;
        // return MediaQuery.of(context).size.height;
      }

    }

    else {
      return 0;
    }

  }
  // -----------------------------------------------------------------------------

  /// ADAPTIVE

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isLandScape(BuildContext context){
    return context.mounted == true ? MediaQuery.orientationOf(context) == Orientation.landscape : false;
    // return MediaQuery.of(context).orientation == Orientation.landscape;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double responsive({
    required BuildContext context,
    required double? landscape,
    required double? portrait,
  }){

    if (context.mounted == true){
      if (landscape == null || portrait == null){
        return 0;
      }
      else {

        final bool _isLandscape = isLandScape(context);

        if (_isLandscape == true){
          return landscape;
        }
        else {
          return portrait;
        }

      }
    }

    else {
      return 0;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double adaptiveWidth(BuildContext context, double? ratio){

    if (context.mounted == true){
      if (ratio == null){
        return 0;
      }
      else {
        return screenWidth(context) * ratio;
      }
    }

    else {
      return 0;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double adaptiveHeight(BuildContext context, double? ratio){

    if (context.mounted == true){
      if (ratio == null){
        return 0;
      }
      else {
        return screenHeight(context) * ratio;
      }
    }

    else {
      return 0;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superWidth(BuildContext context, double? ratio){

    if (context.mounted == true){
      if (ratio != null) {
        return Scale.responsive(
          context: context,
          landscape: Scale.adaptiveHeight(context, ratio),
          portrait: Scale.adaptiveWidth(context, ratio),
        );
      }

      else {
        return 0;
      }

    }

    else {
      return 0;
    }

  }
  // -----------------------------------------------------------------------------

  /// PADDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static double superSafeAreaTopPadding(BuildContext context) {
    return context.mounted == true ? MediaQuery.paddingOf(context).top : 0;
    // return MediaQuery.of(context).padding.top;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superInsets({ // clean all trances to become constants
    required BuildContext context,
    required bool appIsLTR,
    double bottom = 0,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
  }) {

    if (context.mounted == true){
      if (appIsLTR == true){
        return EdgeInsets.only(
            left: enLeft,
            right: enRight,
            bottom: bottom,
            top: top
        );
      }

      else {
        return EdgeInsets.only(
            bottom: bottom,
            left: enRight,
            right: enLeft,
            top: top
        );
      }
    }

    else {
      return EdgeInsets.zero;
    }

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static EdgeInsets superPadding({
    required BuildContext context,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
    double bottom = 0,
  }) {

    if (TextDir.checkAppIsLeftToRight(context) == true){
      return EdgeInsets.only(
          left: enLeft,
          right: enRight,
          bottom: bottom,
          top: top,
      );
    }

    else {
      return EdgeInsets.only(
          left: enRight,
          right: enLeft,
          top: top,
          bottom: bottom,
      );
    }

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superMargins({dynamic margin}) {

    if (margin == null || margin == 0){
      return EdgeInsets.zero;
    }

    else if (margin.runtimeType == double){
      return EdgeInsets.all(margin);
    }

    else if (margin.runtimeType == int){
      return EdgeInsets.all(margin.toDouble());
    }

    else if (margin.runtimeType == EdgeInsets){
      return margin;
    }

    else {
      return margin;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superDeviceRatio(BuildContext context) {
    return context.mounted == true ? MediaQuery.sizeOf(context).aspectRatio : 1;
    // return MediaQuery.of(context).size.aspectRatio;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double devicePixelRatio(BuildContext context) {
    // return MediaQuery.of(context).devicePixelRatio,
    return context.mounted == true ? MediaQuery.devicePixelRatioOf(context) : 1;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets screenInsets(BuildContext context){
    return context.mounted == true ? MediaQuery.viewInsetsOf(context) : EdgeInsets.zero;
    // return MediaQuery.of(context).viewInsets;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Size screenSize(BuildContext context){
    return context.mounted == true ? MediaQuery.sizeOf(context) : Size.zero;
    // return MediaQuery.of(context).size;
  }
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const EdgeInsets constantMarginsAll5 = EdgeInsets.all(5);
  static const EdgeInsets constantMarginsAll10 = EdgeInsets.all(10);
  static const EdgeInsets constantMarginsAll20 = EdgeInsets.all(20);
  // --------------------
  static const EdgeInsets constantHorizontal5 = EdgeInsets.symmetric(horizontal: 5);
  static const EdgeInsets constantHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  // -----------------------------------------------------------------------------

  /// DIVISION

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getUniformRowItemWidth({
    required int? numberOfItems,
    required double? boxWidth,
    double spacing = 10,
    bool considerMargins = true,
  }) {

    /// this concludes item width after dividing screen width over number of items
    /// while considering 10 pixels spacing between them

    double _width = 0;

    if (numberOfItems != null && boxWidth != null){

      /// has side margins same as spacing
      if (considerMargins == true){
        _width = (boxWidth - (spacing * (numberOfItems + 1))) / numberOfItems;
      }

      /// has no side margins
      else {
        _width = (boxWidth - (spacing * (numberOfItems - 1))) / numberOfItems;
      }

    }

    return _width;
  }
// -----------------------------------------------------------------------------
}
