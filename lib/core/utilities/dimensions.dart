// ignore_for_file: unreachable_switch_default
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Dimensions {
  // --------------------------------------------------------------------------
  const Dimensions({
    required this.width,
    required this.height,
  });
  // --------------------
  final double? width;
  final double? height;
  // -----------------------------------------------------------------------------

  /// ZERO

  // --------------------
  static Dimensions zero = const Dimensions(width: 0, height: 0,);
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'width': width,
      'height': height,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions? decipherDimensions(Map<String, dynamic>? map) {
    Dimensions? _imageSize;
    if (map != null) {

      final dynamic _widthInInt = map['width'];
      final dynamic _heightInInt = map['height'];

      _imageSize = Dimensions(
        width: _widthInInt.toDouble(),
        height: _heightInInt.toDouble(),
      );
    }
    return _imageSize;
  }
  // -----------------------------------------------------------------------------

  /// toSize

  // --------------------
  /// TESTED : WORKS PERFECT
  Size toSize(){
    return Size(width ?? 0, height ?? 0);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions fromSize(Size? size){
    return Dimensions(width: size?.width ?? 0, height: size?.height ?? 0);
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  double getAspectRatio(){

    double _output = 1;

    final double _width = width ?? 0;
    final double _height = height ?? 0;

    if (_width == 0 || _height == 0){
      _output = 1;
    }
    else {
      /// ASPECT RATIO IS WITH / HEIGHT
      _output = _width / _height;
    }

    return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getHeightByAspectRatio({
    required double? aspectRatio,
    required double? width,
  }){
    double? _output;

    if (aspectRatio != null && width != null){
      /// AspectRatio = (widthA / heightA)
      ///             = (widthB / heightB)
      ///
      /// so heightB = widthB / aspectRatio
      _output = width / aspectRatio;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getWidthByAspectRatio({
    required double? aspectRatio,
    required double? height,
  }){
    double? _output;

    if (aspectRatio != null && height != null){
      /// AspectRatio = (widthA / heightA)
      ///             = (widthB / heightB)
      ///
      /// so widthB = aspectRatio * heightB
      _output = aspectRatio * height;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double? getHeightForWidth({
    required double? width,
  }){
    final double? _aspectRatio = getAspectRatio();
    return getHeightByAspectRatio(aspectRatio: _aspectRatio, width: width);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double? getWidthForHeight({
    required double? height,
  }){
    final double? _aspectRatio = getAspectRatio();
    return getWidthByAspectRatio(aspectRatio: _aspectRatio, height: height);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions? resizeToWidth({
    required double? width,
  }){

    if (width == null){
      return null;
    }

    else {
      final double _height = getHeightForWidth(width: width)!;
      return Dimensions(width: width, height: _height);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions? resizeToHeight({
    required double? height,
  }){

    if (height == null){
      return null;
    }

    else {
      final double _width = getWidthForHeight(height: height)!;
      return Dimensions(width: _width, height: height);
    }

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDimensions({String invoker = ''}) {
    blog('blogDimensions.($invoker).Dimensions.W($width).H($height)');
  }
  // --------------------
  void blog(dynamic msg, {String? invoker}){

    assert((){
      if (kDebugMode) {
        debugPrint(msg?.toString());
      }
      return true;
    }(), '_');

  }
  // -----------------------------------------------------------------------------

  /// BOX FIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static int cipherBoxFit(BoxFit? boxFit) {
    switch (boxFit) {
      case BoxFit.fitHeight:return 1;
      case BoxFit.fitWidth:return 2;
      case BoxFit.cover:return 3;
      case BoxFit.none:return 4;
      case BoxFit.fill:return 5;
      case BoxFit.scaleDown:return 6;
      case BoxFit.contain:return 7;
      default:return 3;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BoxFit? decipherBoxFit(int? boxFit) {
    switch (boxFit) {
      case 1:   return BoxFit.fitHeight;
      case 2:   return BoxFit.fitWidth;
      case 3:   return BoxFit.cover;
      case 4:   return BoxFit.none;
      case 5:   return BoxFit.fill;
      case 6:   return BoxFit.scaleDown;
      case 7:   return BoxFit.contain;
      default:  return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double concludeHeightByDimensions({
    required double width,
    required double graphicWidth,
    required double graphicHeight,
  }) {
    /// height / width = graphicHeight / graphicWidth
    return (graphicHeight * width) / graphicWidth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double concludeWidthByDimensions({
    required double height,
    required double graphicWidth,
    required double graphicHeight,
  }) {
    /// height / width = graphicHeight / graphicWidth
    return (graphicWidth * height) / graphicHeight;
  }
  // -----------------------------------------------------------------------------

  /// ORIENTATION CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsPortrait(){

    if (_isGreaterThan(number: height, isGreaterThan: width) == true){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsLandscape(){

    if (_isGreaterThan(number: width, isGreaterThan: height) == true){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsSquared(){

    if (width == height){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _isGreaterThan({
    required num? number,
    required num? isGreaterThan,
  }){
    bool _output = false;

    if (number != null && isGreaterThan != null){
      _output = number > isGreaterThan;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkDimensionsAreIdentical({
    required Dimensions? dim1,
    required Dimensions? dim2,
  }){

    bool _identical = false;

    if (dim1 == null && dim2 == null){
      _identical = true;
    }
    else if (
    dim1 != null &&
        dim2 != null &&
        dim1.width == dim2.width &&
        dim1.height == dim2.height
    ){
      _identical = true;
    }

    return _identical;
  }
  // --------------------------------------------------------------------------

  /// FITTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions fitGraphicToCanvas({
    required Dimensions canvas,
    required Dimensions graphic,
    required BoxFit boxFit,
  }){
    Dimensions _output = Dimensions.zero;

    final double canvasWidth = canvas.width ?? 0;
    final double canvasHeight = canvas.height ?? 0;
    final double graphicWidth = graphic.width ?? 0;
    final double graphicHeight = graphic.height ?? 0;

    if (graphicWidth == 0 || graphicHeight == 0 || canvasWidth == 0 || canvasHeight == 0) {
      _output = Dimensions.zero;
    }

    else {

      final double widthRatio = canvasWidth / graphicWidth;
      final double heightRatio = canvasHeight / graphicHeight;

      switch (boxFit) {

      /// FIT WIDTH
        case BoxFit.fitWidth:
          _output = graphic.resizeToWidth(width: canvasWidth)!;

      /// FIT HEIGHT
        case BoxFit.fitHeight:
          _output = graphic.resizeToHeight(height: canvasHeight)!;

      /// CONTAIN
        case BoxFit.contain:
          if (widthRatio < heightRatio) {
            _output = graphic.resizeToWidth(width: canvasWidth)!;
          } else {
            _output = graphic.resizeToHeight(height: canvasHeight)!;
          }

      /// COVER
        case BoxFit.cover:
          if (widthRatio > heightRatio) {
            _output = graphic.resizeToWidth(width: canvasWidth)!;
          } else {
            _output = graphic.resizeToHeight(height: canvasHeight)!;
          }

      /// FILL
        case BoxFit.fill:
          _output = Dimensions(width: canvasWidth, height: canvasHeight);

      /// SCALE DOWN
        case BoxFit.scaleDown:
          final bool isLargerThanCanvas = graphicWidth > canvasWidth || graphicHeight > canvasHeight;
          if (isLargerThanCanvas) {
            _output = fitGraphicToCanvas(
              canvas: canvas,
              graphic: graphic,
              boxFit: BoxFit.contain,
            );
          }
          else {
            _output = graphic;
          }

      /// NON
        case BoxFit.none: _output = graphic;

      ///DEFAULT
        default: _output = graphic;
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() => 'Dimensions(width: $width, height: $height)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Dimensions){
      _areIdentical = checkDimensionsAreIdentical(
        dim1: this,        dim2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      width.hashCode^
      height.hashCode;
  // -----------------------------------------------------------------------------
}
