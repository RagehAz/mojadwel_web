// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/super_positioned.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';

class _RedDot extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _RedDot({
    this.isNano = false,
    this.count,
    this.text,
    this.color,
    this.textColor,
    // super.key
  });
  // --------------------
  final bool isNano;
  final int? count;
  final String? text;
  final Color? color;
  final Color? textColor;
  // --------------------------------------------------------------------------
  static const double defaultSize = 18;
  static const double maxWidth = 60;
  // --------------------
  static double getSize({
    required bool isNano
  }){
    final double _factor = isNano == true ? 0.7 : 1.0;
    final double _height = defaultSize * _factor;
    return _height;
  }
  // --------------------
  String? _concludeCount(int? count) {
    String? _count;

    if (count == null || count == 0) {
      _count = null;
    }

    else if (count > 0 && count <= 99) {
      _count = '$count';
    }

    else {
      _count = '99+';
    }

    return _count;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? _count = _concludeCount(count);
    final double factor = isNano == true ? 0.7 : 1.0;
    final double _size = getSize(isNano: isNano);
    // --------------------
    return Container(
      // width: _size * 0.3,
      height: _size,
      // margin: const EdgeInsets.all(buttonWidth * 0.1),
      constraints: BoxConstraints(
        minWidth: _size,
        maxWidth: _count != null || text != null ? maxWidth : _size,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_size * 0.5)),
        color: color ?? const Color.fromARGB(255, 233, 0, 0),
      ),
      // padding: EdgeInsets.symmetric(horizontal: 2 * factor),
      // alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          SuperText(
            text: text ?? _count,
            textColor: textColor ?? Colorz.white255,
            textHeight: _size * 0.9 * factor,
            margins: EdgeInsets.only(
              left: _size * 0.3,
              right: _size * 0.3,
              top: _size * 0.13 * 0,
            ),
            // labelColor: Colorz.white50,
          )

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class RedDotBadge extends StatelessWidget {
  // --------------------------------------------------------------------------
  const RedDotBadge({
    required this.child,
    required this.redDotIsOn,
    required this.approxChildWidth,
    this.count,
    this.shrinkChild = false,
    this.isNano = false,
    this.text,
    this.color,
    this.height,
    this.textColor,
    this.horizontalOffset,
    super.key
  });
  // --------------------------------------------------------------------------
  final bool redDotIsOn;
  final int? count;
  final Widget child;
  final bool shrinkChild;
  final bool isNano;
  final double approxChildWidth;
  final String? text;
  final Color? textColor;
  final Color? color;
  final double? height;
  final double? horizontalOffset;
  // --------------------------------------------------------------------------
  static double getShrinkageScale({
    required double childWidth,
    required bool isNano,
  }){
    final double _viewWidth = childWidth - (_RedDot.getSize(isNano: isNano) * 0.2);
    return _viewWidth / childWidth;
  }
  // --------------------
  static double getShrinkageDX({
    required double childWidth,
    required bool isNano,
  }){

    final double ratio = getShrinkageScale(
      childWidth: childWidth,
      isNano: isNano,
    );
    final double _dx = childWidth - (ratio * childWidth);

    return _dx;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          if (shrinkChild == true)
            Transform.scale(
              scale: getShrinkageScale(
                isNano: isNano,
                childWidth: approxChildWidth,
              ),
              alignment: Alignment.bottomLeft,
              child: child,
            ),

          if (shrinkChild == false)
            child,

          if (redDotIsOn == true)
            SuperPositioned(
              enAlignment: Alignment.topRight,
              horizontalOffset: horizontalOffset ?? 0,
              // horizontalOffset: -(NoteRedDot.size * 0.5),
              appIsLTR: true,
              child: _RedDot(
                count: count,
                isNano: isNano,
                text: text,
                textColor: textColor,
                color: color,
              ),
            ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
