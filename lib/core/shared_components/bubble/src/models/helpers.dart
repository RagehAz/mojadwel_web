// ignore_for_file: non_constant_identifier_names

part of bubble;

abstract class _Helpers {
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
  // --------------------
  /// AI TESTED
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color? decipherColor(String? colorString) {
    Color? _color;

    if (colorString != null) {
      /// reference ciphered color code
      // String _string = '${_alpha}*${_r}*${_g}*${_b}';

      /// ALPHA
      final String _a = removeTextAfterFirstSpecialCharacter(
        text: colorString,
        specialCharacter: '*',
      )!;
      final int _alpha = transformStringToInt(_a)!;

      /// RED
      final String _rX_gX_b = removeTextBeforeFirstSpecialCharacter(
        text: colorString,
        specialCharacter: '*',
      )!;
      final String _r = removeTextAfterFirstSpecialCharacter(
        text: _rX_gX_b,
        specialCharacter: '*',
      )!;
      final int _red = transformStringToInt(_r)!;

      /// GREEN
      final String _gX_b = removeTextBeforeFirstSpecialCharacter(
        text: _rX_gX_b,
        specialCharacter: '*',
      )!;
      final String _g = removeTextAfterFirstSpecialCharacter(
        text: _gX_b,
        specialCharacter: '*',
      )!;
      final int _green = transformStringToInt(_g)!;

      /// BLUE
      final String _b = removeTextBeforeFirstSpecialCharacter(
        text: _gX_b,
        specialCharacter: '*',
      )!;
      final int _blue = transformStringToInt(_b)!;

      _color = Color.fromARGB(_alpha, _red, _green, _blue);
    }

    return _color;
  }
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
  // --------------------
  /// AI TESTED
  static String? removeTextAfterFirstSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result = text;

    if (isEmpty(text) == false){

      final bool _textContainsChar = stringContainsSubString(
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
// -----------------------------------------------------------------------------
}

abstract class Aligner {
  // -----------------------------------------------------------------------------

  /// ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment top({
    required bool appIsLTR,
    bool inverse = false,
  }) {

    if (appIsLTR == true) {
      return inverse == true ? Alignment.topRight : Alignment.topLeft;
    }

    else {
      return inverse == true ? Alignment.topLeft : Alignment.topRight;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment center({
    required bool appIsLTR,
    bool inverse = false,
  }) {

    if (appIsLTR == true) {
      return inverse == true ? Alignment.centerRight : Alignment.centerLeft;
    }

    else {
      return inverse == true ? Alignment.centerLeft : Alignment.centerRight;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment bottom({
    required bool appIsLTR,
    bool inverse = false,
  }) {

    if (appIsLTR == true) {
      return inverse == true ? Alignment.bottomRight : Alignment.bottomLeft;
    }

    else {
      return inverse == true ? Alignment.bottomLeft : Alignment.bottomRight;
    }

  }
  // -----------------------------------------------------------------------------

  /// POSITION IN LEFT ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? rightOffsetInLeftAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromRight,
  }) {
    double? _rightOffset;

    /// WHEN LEFT TO RIGHT
    if (appIsLTR == true) {
      /// right offset position should be programmatic
      _rightOffset = null;
    }

    /// WHEN RIGHT IN LEFT
    else {
      /// right offset position should have the offset value
      _rightOffset = offsetFromRight;
    }

    return _rightOffset;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? leftOffsetInLeftAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromLeft,
  }) {
    /// gets [left position] of object that [aligns left] when app is english (LTR)
    double? _leftOffset;

    /// when in English
    if (appIsLTR == true) {
      /// left offset position should have the offset value
      _leftOffset = offsetFromLeft;
    }

    /// when in Arabic
    else {
      /// left offset position should be programmatic
      _leftOffset = null;
    }

    return _leftOffset;
  }
  // -----------------------------------------------------------------------------

  /// POSITION IN RIGHT ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? rightOffsetInRightAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromRight,
  }) {
    /// gets [right position] of object that [aligns right] when app is english (LTR)
    return leftOffsetInLeftAlignmentEn(
      appIsLTR: appIsLTR,
      offsetFromLeft: offsetFromRight,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? leftOffsetInRightAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromLeft,
  }) {
    /// gets [left position] of object that [aligns right] when app is english (LTR)
    return rightOffsetInLeftAlignmentEn(
      appIsLTR: appIsLTR,
      offsetFromRight: offsetFromLeft,
    );

  }
// -----------------------------------------------------------------------------
}

class UnNullify<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const UnNullify({
    required this.value,
    required this.builder,
    this.nullChild,
    super.key
  });
  // --------------------
  final T? value;
  final Widget? nullChild;
  final Widget Function(T value) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (value == null){
      return nullChild ?? const SizedBox();
    }
    else {
      return builder(value!);
    }
    // --------------------
  }
// --------------------------------------------------------------------------
}

void asyncInSync(Function? asynchronous) {

  if (asynchronous != null){

    Future<void> _start() async {}

    _start().then((_) async {
      await asynchronous();
    });

  }

}
